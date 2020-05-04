import 'dart:io';
import 'package:cms/controller/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/Others.dart';
import 'onboarding.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  bool hidePassword = true;final _formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl=new TextEditingController();
  TextEditingController newPassCtrl=new TextEditingController();
  TextEditingController oldPassCtrl=new TextEditingController();
  TextEditingController emailCtrl=new TextEditingController();
  TextEditingController mobileCtrl=new TextEditingController();
  TextEditingController studentidCtrl=new TextEditingController();
  TextEditingController departmentCtrl=new TextEditingController();
  //TextEditingController semesterCtrl=new TextEditingController();
  TextEditingController passCtrl=new TextEditingController();
  static Pattern pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String name,email,department,semester,mobile,role,id,password,oldpassword,newpassword,studentid;
  int sid,departmentid;ProgressDialog pr;
  SharedPreferences sp;
  File image;Auth auth=new Auth();
  RegExp regex = new RegExp(pattern);
  List posts,departments,semesters;

    @override
  void initState() {
    super.initState();
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    _welcome();
    _Others();
  }

  void toast(String text) {
  Fluttertoast.showToast(
        msg: text,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  Future _submit() async{
  Others others=new Others();
  if(await others.checkConection()== true){
   if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      pr.update(message: "Please wait");
      pr.show();
      bool result;
      if(image != null){
        if(newPassCtrl.text.length > 0){
        result =await Auth().updateUserWithImage(sid,nameCtrl.text,studentidCtrl.text,mobileCtrl.text,emailCtrl.text,newPassCtrl.text,image);
        pr.dismiss();
        if(result == true){
        //alertSucess("Notice", "User created successfully...");
        toast("Profile Update successfully");
          var a = auth.logoutUser(sid);
          sp=await SharedPreferences.getInstance();
          await sp.clear();
          Route route=MaterialPageRoute(builder: (context) => Onboarding());
          Navigator.push(context, route);
        }else{
        //alertError("Notice", "Something went wrong...");
        toast("Something went wrong");
        } 
        }else{
        result =await Auth().updateUserWithImage(sid,nameCtrl.text,studentidCtrl.text,mobileCtrl.text,emailCtrl.text,oldPassCtrl.text,image);
        pr.dismiss();
        if(result == true){
        //alertSucess("Notice", "User created successfully...");
        toast("Profile Update successfully");
          var a = auth.logoutUser(sid);
          sp=await SharedPreferences.getInstance();
          await sp.clear();
          Route route=MaterialPageRoute(builder: (context) => Onboarding());
          Navigator.push(context, route);
        }else{
        //alertError("Notice", "Something went wrong...");
        toast("Something went wrong");
        }
        }
      }else{
        if(newPassCtrl.text.length > 0){
        result =await Auth().updateUserWithoutImage(sid,nameCtrl.text,studentidCtrl.text,mobileCtrl.text,emailCtrl.text,newPassCtrl.text);
        pr.dismiss();
        if(result == true){
        //alertSucess("Notice", "User created successfully...");
        toast("Profile Update successfully");
          var a = auth.logoutUser(sid);
          sp=await SharedPreferences.getInstance();
          await sp.clear();
          Route route=MaterialPageRoute(builder: (context) => Onboarding());
          Navigator.push(context, route);
        }else{
        //alertError("Notice", "Something went wrong...");
        toast("Something went wrong");
        } 
        }else{
        result =await Auth().updateUserWithoutImage(sid,nameCtrl.text,studentidCtrl.text,mobileCtrl.text,emailCtrl.text,oldPassCtrl.text);
        pr.dismiss();
        if(result == true){
        //alertSucess("Notice", "User created successfully...");
        toast("Profile Update successfully");
          var a = auth.logoutUser(sid);
          sp=await SharedPreferences.getInstance();
          await sp.clear();
          Route route=MaterialPageRoute(builder: (context) => Onboarding());
          Navigator.push(context, route);
        }else{
        //alertError("Notice", "Something went wrong...");
        toast("Something went wrong");
        }
        }
      }
    }}else{
      others.showMessage(context, "Notice", "Please check your internet connection !!!");
    }
  }

  Future getImage() async {
    var img= await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = img;
    });
  }
    _welcome() async{
    sp=await SharedPreferences.getInstance();
    String r=sp.getString('role');
    String n=sp.getString('name');
    String d=sp.getString('department');
    String m=sp.getString('mobile');
    String si=sp.getString('studentid');
    String e=sp.getString('email').toString();
    int i=sp.getInt('id');
    setState(() {
      nameCtrl.text=n;
      mobileCtrl.text=m;
      studentidCtrl.text=si;
      emailCtrl.text=e;
      // this.role=r;
      this.name=n;
      // this.mobile=m;
      // this.department=d;
      // this.studentid=si;
      this.password=sp.getString('password').toString();
      this.sid=i;
      // this.email=e;
    });
    
  }

   _setDepartment(String value){
    for(var item in departments){
       if(item['name']==value){
         setState(() {
           this.departmentid=item['id'];
         });
      }
    }
  }

  _Others()async{
    Others others=new Others();
    this.departments=await others.getDepartment();
    this.semesters=await others.getSemester();
    setState((){
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
      key: _formKey,
      child:
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
          image: new DecorationImage(image:
          image != null? FileImage(image): new NetworkImage("http://cms.flatbasha.com/image/$sid.jpg"),
      fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  child: ListView(
                    children: <Widget>[
                      Text(
                        'Welcome $name',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: <Widget>[
                      Text(
                        'tap to upload image',
                        style: TextStyle(color: Colors.black54,fontStyle: FontStyle.italic),
                      ),
                      InkWell(
                        child: Icon(Icons.camera_alt,color: Colors.blue,),
                        onTap: (){
                          getImage();
                        },
                      ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0,right: 0, bottom: 0, top: 0),
                        child: TextFormField(
                          controller: nameCtrl,
                          decoration: new InputDecoration(
                            labelText: 'Name',
                            fillColor: Colors.white,
                            icon: Icon(Icons.person,color: Colors.black,),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter your name';
                          //   }else {
                          //     return null;
                          //   }
                          // },
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          onChanged: (value){
                            setState(() {
                              this.name=value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0,right: 0, bottom: 0, top: 0),
                        child: TextFormField(
                          controller: studentidCtrl,
                          decoration: new InputDecoration(
                            labelText: 'Student/Staff ID', 
                            fillColor: Colors.white,
                            prefixText: '',
                            icon: Icon(Icons.account_balance_wallet,color: Colors.black,),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return 'Please enter staff id';
                          //   }else {
                          //     return null;
                          //   }
                          // },
                          keyboardType: TextInputType.phone,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          onChanged: (value){
                            setState(() {
                              this.studentid=value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0,right: 0, bottom: 0, top: 0),
                        child: TextFormField(
                          controller: mobileCtrl,
                          decoration: new InputDecoration(
                            labelText: 'Mobile No',
                            fillColor: Colors.white,
                            prefixText: '+88 ',
                            icon: Icon(Icons.phone,color: Colors.black,),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          validator: (value) {
                            if (value.isNotEmpty && value.length != 11) {
                              return 'Mobile no must be 11 Digits';
                            }else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.phone,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          onChanged: (value){
                            setState(() {
                              this.mobile=value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0,right: 0, bottom: 0, top: 0),
                        child: TextFormField(
                          controller: emailCtrl,
                          decoration: new InputDecoration(
                            labelText: 'Email',
                            fillColor: Colors.white,
                            icon: Icon(Icons.email,color: Colors.black,),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          validator: (value) {
                            if (value.isNotEmpty && !regex.hasMatch(value)) {
                              return 'Please enter valid email';
                            }else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          onChanged: (value){
                            setState(() {
                              this.email=value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0,right: 0, bottom: 0, top: 0),
                        child: TextFormField(
                          controller: oldPassCtrl,
                          obscureText: true,
                          decoration: new InputDecoration(
                            labelText: 'Old Password',
                            fillColor: Colors.white,
                            icon: Icon(Icons.lock,color: Colors.black,),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter old password';
                            }else if(value != password){
                              return 'wrong old password';
                            }
                            else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          onChanged: (value){
                            setState(() {
                              this.oldpassword=value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0,right: 0, bottom: 0, top: 0),
                        child: TextFormField(
                          controller: newPassCtrl,
                          obscureText: true,
                          decoration: new InputDecoration(
                            labelText: 'New Password',
                            fillColor: Colors.white,
                            icon: Icon(Icons.security,color: Colors.black,),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          // validator: (value) {
                          //   if (value != password) {
                          //     return 'Please enter secure code';
                          //   }else {
                          //     return null;
                          //   }
                          // },
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                          onChanged: (value){
                            setState(() {
                              this.newpassword=value;
                            });
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 5,right: 0, bottom:10, top: 0),
                      //   child:DropdownButtonFormField(
                      //     decoration: new InputDecoration(
                      //       labelText: 'Department',
                      //       fillColor: Colors.white,
                      //       isDense: true,
                      //       icon: Icon(Icons.import_contacts,color: Colors.black,),
                      //       border: UnderlineInputBorder(),
                      //       //fillColor: Colors.green
                      //     ),
                      //     value: (department != null)?department:null,
                      //     items: (departments != null)?departments.map((array){
                      //       return DropdownMenuItem(
                      //         value: array['name'].toString(),
                      //         child: Text(array['name']),
                      //       );
                      //     }).toList():null,
                      //     onChanged: (value){
                      //       setState((){
                      //         this.department=value;
                      //       });
                      //       _setDepartment(department);
                      //     },
                      //     validator: (value) {
                      //       if (value.isEmpty) {
                      //         return 'Please enter your department';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                padding: EdgeInsets.only(left: 0),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // InkWell(
                    //   onTap: getImage,
                    //   child:
                    //   roundedRectButton("Get Photo", signInGradients, false),
                    // ),
                    InkWell(
                      onTap: _submit,
                      child:
                      roundedRectButton("Update", signUpGradients, false),
                    ),
                  ],
                ),
              ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black87,width: 1),
                      //     borderRadius: BorderRadius.circular(7)
                      //   ),
                      //   child: CustomButton(
                      //     text: 'Update',
                      //     bgColor: Colors.white.withOpacity(0),
                      //     textColor: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      )
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.bgColor,
    this.text,
    this.textColor
  });

  final Color bgColor;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Material(
            color: bgColor,
            borderRadius: BorderRadius.circular(7),
            child: InkWell(
              borderRadius: BorderRadius.circular(7),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  '$text',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        )
      ],
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