import 'package:cms/controller/Others.dart';
import 'package:flutter/material.dart';
import 'package:cms/controller/auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
//import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:cms/register.dart'; 
import 'package:cms/home.dart';

class Log extends StatefulWidget {
  Log({Key key}) : super(key:key);
  @override
  _LogState createState() => _LogState();  
}

class _LogState extends State<Log> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileCtrl=new TextEditingController();
  TextEditingController passwordCtrl=new TextEditingController();
  var mobile,password,message,body,cr;
  ProgressDialog pr;
  Auth login=new Auth();
  Others others=new Others();

   _submit() async{
   if(await others.checkConection()==true){
   if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      pr.update(message:"Please Wait...");
      pr.show();
      bool result=await login.loginUser(mobileCtrl.text,passwordCtrl.text,pr);
      if(result == true){
      Route route=MaterialPageRoute(builder: (context) => Home());
      Navigator.push(context, route);
      }else{
        //alertError("Alert", "Sorry, you are invalid, register then try...");
        toast("Sorry, Register then try again");
      }
   }}else{
     others.showMessage(context, "Notice", "Please check your internet connection !!!");
   }
  }

  void toast(String text) {
    Fluttertoast.showToast(
        msg: text,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  //   void alertError(String title,String body){
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return RichAlertDialog(
  //           alertTitle: richTitle(title),
  //           alertSubtitle: richSubtitle(body),
  //           alertType: RichAlertType.ERROR,
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text("OK"),
  //               onPressed: (){Navigator.pop(context);},
  //             ),
  //             FlatButton(
  //               child: Text("Cancel"),
  //               onPressed: (){Navigator.pop(context);},
  //             ),
  //           ],
  //         );
  //       }
  //   );
  //  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
return Scaffold(
        backgroundColor: Colors.white,
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
                          onTap: _submit,
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