import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:dio/dio.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:cms/register.dart';


class Login extends StatefulWidget {
  Login({Key key,this.mobile,this.password,this.message,this.body}) : super(key:key);
  var mobile,password,message,body;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileCtrl=new TextEditingController();
  TextEditingController passwordCtrl=new TextEditingController();
  SharedPreferences sp;List posts;
  int netStatus=0;
  ProgressDialog pr;
  String POST_URL = 'http://flatbasha.com/loginverify';
  var mobile,password,message,body,cr;

  Future<int> _checkConection() async{
    try{
      cr = await (Connectivity().checkConnectivity());
    }catch(e){
      print(e.toString());
    }finally{
      setState(() {
        if (cr == ConnectivityResult.none) {
          this.netStatus=0;
        }if(cr== ConnectivityResult.wifi){
          this.netStatus=1;
        }if(cr == ConnectivityResult.mobile){
          this.netStatus=1;
        }
      });
    }
  }

  init() async{
    sp=await SharedPreferences.getInstance();
    setState((){
      if(posts != null){
        sp.setInt('id', posts[0]['id']);
        sp.setString('name', posts[0]['name']);
        sp.setString('mobile', posts[0]['mobile']);
        sp.setString('email', posts[0]['email']);
        sp.setString('address', posts[0]['address']);
        sp.setInt('role', posts[0]['role']);
        sp.setInt('status', posts[0]['status']);
        sp.setString('image', posts[0]['image']);
        sp.setString('dob', posts[0]['dateofjoin']);
        navigateMainPage();
      }
    });
  }

  void navigateMainPage(){
    pr.hide();
//    Route route=MaterialPageRoute(builder: (context) => Homepage());
//    Navigator.push(context, route);
  }


  @override
  void initState(){
    super.initState();
    //_checkConection();
  }

  _validate(){
    if(_formKey.currentState.validate()){
      _checkConection();
      _formKey.currentState.save();
      if(netStatus != 0){
        pr.update(message: "Please Wait ...");
        pr.show();
        _submit();
      }else{
        if(pr.isShowing()){
          pr.hide();
        }
        setState(() {
          this.message="Interner Connection";
          this.body="Please check the mobile data or wifi connection !!!";
        });
        showMessage(message, body);
      }

    }
  }

  void alertError(String title,String body){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RichAlertDialog(
            alertTitle: richTitle(title),
            alertSubtitle: richSubtitle(body),
            alertType: RichAlertType.ERROR,
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: (){Navigator.pop(context);},
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: (){Navigator.pop(context);},
              ),
            ],
          );
        }
    );
  }

  Future<bool> _submit() async{
    _checkConection();
    String info="?mobile=$mobile&password=$password";
    var response;
    Dio dio = new Dio();
    response = await dio.get(POST_URL+info);
    print(response.data.toString().length);
    if (response.data.toString().length > 2) {
      this.posts = json.decode(response.toString());
      pr.hide();
      init();
    }else{
      pr.hide();
      alertError("Notice","Not Registered, Something went Wrong!!!");
    }
  }

  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    return Scaffold(
        backgroundColor: Colors.red,
      body: Form(
        key: _formKey,
        child:ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.9),
              ),
              Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 10),
                        child:
                        Column(
                          children: <Widget>[
                            Text('SIGN IN',textAlign: TextAlign.start,style: TextStyle(color: Colors.orange,fontSize: 25),),
                            Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20, bottom: 5, top: 0),
                                    child: TextFormField(
                                      controller: mobileCtrl,
                                      decoration: new InputDecoration(
                                        labelText: 'Mobile',
                                        fillColor: Colors.white,
                                        prefixText: '+88 ',
                                        icon: Icon(Icons.phone),
                                        border: UnderlineInputBorder(),
                                        //fillColor: Colors.green
                                      ),
                                      validator:  (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter mobile no';
                                        }else if(value.length != 11){
                                          return 'Mobile no must be 11 Digits';
                                        }else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.phone,
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                      onSaved: (String val){
                                        this.mobile=val;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20, bottom:20 , top: 0),
                                    child: TextFormField(
                                      controller: passwordCtrl,
                                      obscureText: true,
                                      decoration: new InputDecoration(
                                        labelText: 'Password',
                                        fillColor: Colors.white,
                                        icon: Icon(Icons.lock),
                                        border:UnderlineInputBorder(),
                                      ),
                                      //fillColor: Colors.green
                                      validator:(value) {
                                        if (value.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        return null;
                                      },
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                      onSaved: (String val){
                                        this.password=val;
                                      },
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child:
                        Center(
                            child:
                            InkWell(
                              onTap: (){
                                Route route=MaterialPageRoute(builder: (context) => register());
                                Navigator.push(context, route);
                              },
                              child: Text("Not Register? Create an Account"),
                            )
                        ),
                      ),
                      Center(
                        child:
                        InkWell(
                          onTap: _validate,
                          child:
                          roundedRectButton("Submit ", signInGradients, false),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ]
        ),
      ),
    );
  }

  void showMessage(message, body) {
    showDialog(
        context: context,
        builder: (BuildContext context) => FancyDialog(
          title: message,
          descreption: body,
        )
    );
  }
}

Widget roundedRectButton(
    String title, List<Color> gradient, bool isEndIconVisible) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(mContext).size.width / 2.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ),
          Visibility(
            visible: isEndIconVisible,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: ImageIcon(
                  AssetImage("images/ic_forward.png"),
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  });
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];


