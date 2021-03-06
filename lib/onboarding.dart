import 'package:cms/membership.dart';
import 'package:flutter/material.dart';
import 'util.dart';
import 'package:cms/register.dart';
import 'package:cms/home.dart';
import 'package:cms/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key key}) : super(key: key);

  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int log=1;SharedPreferences sp;int departmentid;

  @override
  void initState(){
    super.initState();
  }

  _welcome() async{
    sp=await SharedPreferences.getInstance();
    this.departmentid=sp.getInt('departmentid');
    departmentid==null?_memberShip():_homE();
    print(departmentid);
  }

  _homE(){
      Route route=MaterialPageRoute(builder: (context) => Home());
      Navigator.push(context, route);
  }
  _memberShip(){
      Route route=MaterialPageRoute(builder: (context) => Membership());
      Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.1,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Hero(
                  tag: 'Clipboard',
                  child: Image.asset('assets/images/collaboration.png'),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Northern University Bangladesh',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Colors.deepPurple),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Counseling Management System',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.green),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "cms provides students overcome challenges and become more competent and confident in both their work and their relationships with others. ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: CustomColors.TextBody,
                          fontFamily: 'opensans'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    //if (log == 0) Login(),
                    //if (log == 0) Width(),
                    //if (log == 0) Register(),
                    log != 0? Welcome():SizedBox(),
                ],
                )
              ),

              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget Login()=>RaisedButton(
    onPressed: () {
      Route route=MaterialPageRoute(builder: (context) => Log());
      Navigator.push(context, route);
    },
    textColor: Colors.white,
    padding: const EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: 60,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            CustomColors.GreenLight,
            CustomColors.GreenDark,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.GreenShadow,
            blurRadius: 15.0,
            spreadRadius: 7.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Center(
        child: const Text(
          'Login',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
  
  Widget Register()=>RaisedButton(
    onPressed: () {
      Route route=MaterialPageRoute(builder: (context) => register());
      Navigator.push(context, route);
    },
    textColor: Colors.white,
    padding: const EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: 60,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.indigoAccent,
            Colors.deepPurple,
//                              CustomColors.GreenLight,
//                              CustomColors.GreenDark,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.PurpleShadow,
            blurRadius: 15.0,
            spreadRadius: 7.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Center(
        child: const Text(
          'Register',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
  
  Widget Width()=>SizedBox(
    width: 10,
  );
  
  Widget Welcome()=>RaisedButton(
    onPressed: _welcome,
    textColor: Colors.white,
    padding: const EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 60,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            CustomColors.GreenLight,
            CustomColors.GreenDark,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.GreenShadow,
            blurRadius: 15.0,
            spreadRadius: 7.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Center(
        child: const Text(
          'Get Started',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}
