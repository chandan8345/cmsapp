import 'package:cms/controller/Others.dart';
import 'package:flutter/material.dart';
import 'package:cms/controller/auth.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Forgot extends StatefulWidget {
Forgot({Key key}) : super(key:key);
  @override
  _ForgotState createState() => _ForgotState();  
}

class _ForgotState extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileCtrl=new TextEditingController();
  TextEditingController emailCtrl=new TextEditingController();
  static Pattern pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  String mobile,email,message,body,cr;
  ProgressDialog pr;
  Auth login=new Auth();
  Others others=new Others();

   _submit() async{
   if(await others.checkConection()==true){
   if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      pr.update(message:"Please Wait...");
      pr.show();
      List a=await Auth().forgotPassword(mobile);
      print(a.length);
      if(a.length != 0){
       toast("Congrats, Please check your email");
      }else{
        toast("Sorry, Something went wrong");
      }
      pr.dismiss();
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
                            Text('Recover Account',textAlign: TextAlign.start,style: TextStyle(color: Colors.orange,fontSize: 25),),
                            Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20,right: 20, bottom:20 , top: 20),
                                    child: TextFormField(
                                      controller: mobileCtrl,
                                      //obscureText: true,
                                      decoration: new InputDecoration(
                                        labelText: 'Registered Mobile',
                                        fillColor: Colors.white,
                                        prefixText: '+88 ',
                                        icon: Icon(Icons.lock),
                                        border:UnderlineInputBorder(),
                                      ),
                                      //fillColor: Colors.green
                                      validator:(value) {
                                        if (value.isEmpty) {
                                          return 'please enter registered mobile no';
                                        }
                                        return null;
                                      },
                                      style: new TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                      onSaved: (String val){
                                        this.mobile=val;
                                      },
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child:
                        Center(
                            child:
                            InkWell(
                              onTap: (){
                              },
                              child: Text("password will be send to your provided email",style: TextStyle(color: Colors.deepOrange),),
                            )
                        ),
                      ),
                      Center(
                        child:
                        InkWell(
                          onTap: _submit,
                          child:
                          roundedRectButton("Send Email ", signInGradients, false),
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