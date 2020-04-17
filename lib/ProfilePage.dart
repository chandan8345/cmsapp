import 'dart:convert';
import 'package:cms/register.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import 'onboarding.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>{
  bool _status = true;SharedPreferences sp;
  final FocusNode myFocusNode = FocusNode();
  String name,department,semester,mobile,role,id;
  List today,waiting,pending,settled;int sid;

  @override
  void initState() {
    super.initState();
    _welcome();
  }

  _welcome() async{
    sp=await SharedPreferences.getInstance();
    String r=sp.getString('role');
    String n=sp.getString('name');
    String s=sp.getString('semester');
    String d=sp.getString('department');
    String m=sp.getString('mobile');
    String si=sp.getString('studentid');
    int i=sp.getInt('id');
    setState(() {
      this.role=r;
      this.name=n;
      this.mobile=m;
      this.semester=s;
      this.department=d;
      //this.id=i;
      this.sid=i;
    });
    _today();
    _waiting();
    _pending();
    _settled();
  }

     Future _today() async {
    Dio dio = new Dio();
    Response r1 = await dio.get("http://cms.flatbasha.com/totaltoday?id=$sid");
    setState(() {
    this.today = json.decode(r1.toString());
    });
  }
  Future _waiting() async{
    Dio dio = new Dio();
    Response r2 =await dio.get("http://cms.flatbasha.com/totalwaiting?id=$sid");
        setState(() {
    this.waiting = json.decode(r2.toString());
        });
  }
    Future _pending() async{
    Dio dio = new Dio();
    Response r3 =await dio.get("http://cms.flatbasha.com/totalpending?id=$sid");
        setState(() {
    this.pending = json.decode(r3.toString());
        });
        print(pending[0]['total']);
  }
    Future _settled() async{
    Dio dio = new Dio();
    Response r4 =await dio.get("http://cms.flatbasha.com/totalsettled?id=$sid");
    setState(() {
    this.settled = json.decode(r4.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl = 'https://i7.pngguru.com/preview/136/22/549/user-profile-computer-icons-girl-customer-avatar.jpg';
    return new Stack(children: <Widget>[
      new Container(color: Colors.blue,),
      new Image.network(
        (sid != null) ? "http://cms.flatbasha.com/image/$sid.jpg" :
                        "https://i7.pngguru.com/preview/136/22/549/user-profile-computer-icons-girl-customer-avatar.jpg",fit: BoxFit.fill,),
      new BackdropFilter(
      filter: new ui.ImageFilter.blur(
      sigmaX: 6.0,
      sigmaY: 6.0,
      ),
      child: new Container(
      decoration: BoxDecoration(
      color:  Colors.blue.withOpacity(0.9),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),)),
      new Scaffold(
          // appBar: new AppBar(
          //   title: new Text(''),
          //   centerTitle: false,
          //   elevation: 0.0,
          //   backgroundColor: Colors.transparent,
          // ),
          // drawer: new Drawer(child: new Container(),),
          backgroundColor: Colors.transparent,
          body:
          new Center(
            child: new Column(
              children: <Widget>[
                new SizedBox(height: _height/12,),
                new CircleAvatar(radius:_width<_height? _width/4:_height/4,
                backgroundImage: NetworkImage(
                  (sid != null) ? "http://cms.flatbasha.com/image/$sid.jpg" :
                        "https://i7.pngguru.com/preview/136/22/549/user-profile-computer-icons-girl-customer-avatar.jpg",
                ),),
                new SizedBox(height: _height/25.0,),
                new Text('$name', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: _width/15, color: Colors.white),),
                new Padding(padding: new EdgeInsets.only(top: 5,bottom: 10),
                  child:new Text('$role',
                    style: new TextStyle(fontWeight: FontWeight.normal, fontSize: _width/25,color: Colors.white),textAlign: TextAlign.center,) ,),
                new Divider(height: _height/30,color: Colors.white,),
                new Row(
                  children: <Widget>[
                    rowCell(today!=null?today[0]['total'].toString():"0", 'TODAY'),
                    rowCell(waiting!=null?waiting[0]['total'].toString():"0", 'WAITING'),
                    rowCell(pending!=null?pending[0]['total'].toString():"0", 'PENDING'),
                    rowCell(settled!=null?settled[0]['total'].toString():"0", 'SETTLED'),
                  ],),
                new Divider(height: _height/30,color: Colors.white),
                // new Padding(padding: new EdgeInsets.only(left: _width/8, right: _width/8), child: new FlatButton(onPressed: (){},
                //   child: new Container(child: new Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                //     new Icon(Icons.person),
                //     new SizedBox(width: _width/30,),
                //     new Text('FOLLOW')
                //   ],)),color: Colors.blue[50],),),
              ],
            ),
          ),
          //floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
          floatingActionButton: 
          Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      (role != 'student')?Padding(
        padding: EdgeInsets.all(10.0),
        child: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.school,color: Colors.blueAccent,
        ),
        onPressed: () async {
          Route route=MaterialPageRoute(builder: (context) => register());
          Navigator.pop(context, route);
        },
        heroTag: null,
      ),
      ):SizedBox(),
      Padding(
        padding: EdgeInsets.all(10.0),
        child: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.power_settings_new,color: Colors.blueAccent,
        ),
        onPressed: () async {
          sp=await SharedPreferences.getInstance();
          await sp.clear();
          Route route=MaterialPageRoute(builder: (context) => Onboarding());
          Navigator.push(context, route);
        },
        heroTag: null,
      ),
      ),
    ]
  )
          // FloatingActionButton(
          //   onPressed: () async{
          //     sp=await SharedPreferences.getInstance();
          //                           await sp.clear();
          //                          Route route=MaterialPageRoute(builder: (context) => Onboarding());
          //                          Navigator.push(context, route);
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.all(3.0),
          //     child: Text('Logout',style: TextStyle(fontSize: 12),),
          //   ),
          //   backgroundColor: Colors.green,
          // ),
      )
    ],);
  }
 

  Widget rowCell(String count, String type) => new Expanded(child: new Column(children: <Widget>[
    new Text('$count',style: new TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
    new Text(type,style: new TextStyle(color: Colors.white, fontWeight: FontWeight.normal,fontSize: 12))
  ],));
}