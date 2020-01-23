import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:cms/login.dart';

class register extends StatefulWidget {
  register({Key key,this.message,this.body,this.name,this.email,this.address,this.mobile,this.image}) : super(key: key);
  var message,body;
  String name,email,mobile,address;
  File image;

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl=new TextEditingController();
  TextEditingController emailCtrl=new TextEditingController();
  TextEditingController mobileCtrl=new TextEditingController();
  TextEditingController addressCtrl=new TextEditingController();
  TextEditingController passwordCtrl=new TextEditingController();
  String name,email,mobile,address;
  var cr;
  var netStatus=0;List posts;
  ProgressDialog pr;
  String POST_URL='http://flatbasha.com/register';
  var message,body;
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);

  File image;

  Future getImage() async {
    //var img= await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      //this.image = img;
    });
  }

  Future _sumbit(file) async{
    var fileContent = file.readAsBytesSync();
    var fileContentBase64 = base64.encode(fileContent);
    var dio=new Dio();
    try{
      FormData formData = new FormData.fromMap(<String, dynamic>{
        "name" : name,
        "email" : email,
        "address" : address,
        "mobile" : mobile,
        "password" : mobile,
        "image" : fileContentBase64
      });
      Response response = await dio.post(POST_URL,data: formData);
      pr.hide();
      if(response.toString() == "Already exist this Member"){
        String res="Already exist this Member";
        alertError("Notice", res);
      }else{
        alertSucess("Notice", response.toString());
      }
    }catch(e){
      print(e.toString());
      pr.hide();
      alertError("Notice", "Already Registered, please try again.");
    }
  }


  @override
  void initState(){
    super.initState();
    //_checkConection();
  }

  _validate(){
    _checkConection();
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      if(netStatus != 0){
        pr.show();
        _sumbit(image);
      }else{
        if(pr.isShowing()){
          pr.hide();
        }
        setState(() {
          this.message="Internet Connection";
          this.body="Please check your mobile data or wifi connection";
        });
        showMessage(message, body);
      }
    }
  }

  void alertSucess(String title,String body){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RichAlertDialog(
            alertTitle: richTitle(title),
            alertSubtitle: richSubtitle(body),
            alertType: RichAlertType.SUCCESS,
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

  Future<int> _checkConection() async{
    try{
      cr = await (Connectivity().checkConnectivity());
      setState(() {
        if (cr == ConnectivityResult.none) {
          this.netStatus=0;
          if(pr.isShowing()){
            pr.hide();
          }
        }if(cr== ConnectivityResult.wifi){
          this.netStatus=1;
        }if(cr == ConnectivityResult.mobile){
          this.netStatus=1;
        }
      });
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
      key: _formKey,
      child:
      ListView(
        children: <Widget>[
          Padding(
            padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height / 7.0),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child:
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 60,
                        child: ClipOval(
                          child: SizedBox(
                            width: 120.0,
                            height: 120.0,
                            child: (image != null) ? Image.file(image,fit: BoxFit.fill,):
                            Image.network("https://i7.pngguru.com/preview/136/22/549/user-profile-computer-icons-girl-customer-avatar.jpg",fit: BoxFit.fill,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text('SIGN UP',textAlign: TextAlign.start,style: TextStyle(color: Colors.orange,fontSize: 25
              ),),
              Padding(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20,right: 20, bottom: 0, top: 0),
                        child: TextFormField(
                          controller: nameCtrl,
                          decoration: new InputDecoration(
                            labelText: 'Name',
                            fillColor: Colors.white,
                            icon: Icon(Icons.person),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          onSaved: (String val){
                            this.name=val;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20,right: 20, bottom: 0, top: 0),
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
                          validator: (value) {
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
                        padding: EdgeInsets.only(left: 20,right: 20, bottom: 0, top: 0),
                        child: TextFormField(
                          controller: emailCtrl,
                          decoration: new InputDecoration(
                            labelText: 'Email',
                            fillColor: Colors.white,
                            icon: Icon(Icons.email),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter email address';
                            }else if(!regex.hasMatch(value)){
                              return 'Please enter valid email';
                            }else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          onSaved: (String val){
                            this.email=val;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20,right: 20, bottom:20, top: 0),
                        child: TextFormField(
                          controller: addressCtrl,
                          decoration: new InputDecoration(
                            labelText: 'Location',
                            fillColor: Colors.white,
                            icon: Icon(Icons.location_on),
                            border:UnderlineInputBorder(),
                          ),
                          //fillColor: Colors.green
                          validator:(value) {
                            if (value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          onSaved: (String val){
                            this.address=val;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child:
                        Center(
                            child:
                            InkWell(
                              onTap: (){
                                Route route=MaterialPageRoute(builder: (context) => Login());
                                Navigator.push(context, route);
                              },
                              child: Text("Already Register? Go to Sign in Page"),
                            )
                        ),
                      ),
//                      Padding(
//                        padding: EdgeInsets.only(left: 20,right: 20, bottom:20 , top: 0),
//                        child: TextFormField(
//                          controller: passwordCtrl,
//                          obscureText: true,
//                          decoration: new InputDecoration(
//                            labelText: 'Password',
//                            fillColor: Colors.white,
//                            icon: Icon(Icons.lock),
//                            border:UnderlineInputBorder(),
//                          ),
//                          //fillColor: Colors.green
//                          validator: (value) {
//                            if (value.isEmpty) {
//                              return 'Please enter 5 digit password';
//                            }else if(value.length >= 5){
//                              return 'password must be 5 dignit';
//                            }else {
//                              return null;
//                            }
//                          },
//                          style: new TextStyle(
//                            fontFamily: "Poppins",
//                          ),
//                          onSaved: (String val){
//                            this.password=val;
//                          },
//                        ),
//                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: getImage,
                      child:
                      roundedRectButton("Choose Photo", signInGradients, false),
                    ),
                    InkWell(
                      onTap: _validate,
                      child:
                      roundedRectButton("Register", signUpGradients, false),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    )
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

Widget roundedRectButton(String title, List<Color> gradient, bool isEndIconVisible) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(mContext).size.width / 2.8,
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
                    fontSize: 18,
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
