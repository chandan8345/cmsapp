import 'dart:convert';
import 'package:cms/ProfileUpdate.dart';
import 'package:cms/controller/auth.dart';
import 'package:cms/controller/onscreen.dart';
import 'package:cms/councillerPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
import 'onboarding.dart';
import 'package:avatar_glow/avatar_glow.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>{
  bool _status = true;SharedPreferences sp;
  final FocusNode myFocusNode = FocusNode();
  String name,department,semester,mobile,role,id;
  List today,waiting,pending,settled,users;int sid,s=0;
  Auth auth=new Auth();OnScreen onScreen=new OnScreen();

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
      this.sid=i;
    });
    _getUsers(sid);
    _today();
    _waiting();
    _pending();
    _settled();
  }

  _getUsers(id) async{
    List a=await onScreen.getActiveUsers(id);
    setState(() {
      this.users=a;
    });
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
          backgroundColor: Colors.transparent,
          body:
          Column(
            children: <Widget>[
              new Center(
            child: new Column(
              children: <Widget>[
                new SizedBox(height: _height/12,),
              // CircleAvatar(
              // backgroundColor: Colors.white,
              // radius: 100.0,
              //     child:
              //     new CircleAvatar(radius:_width<_height? _width/4:_height/4,
              //   backgroundImage: NetworkImage(
              //     (sid != null) ? "http://cms.flatbasha.com/image/$sid.jpg" :
              //           "https://i7.pngguru.com/preview/136/22/549/user-profile-computer-icons-girl-customer-avatar.jpg",
              //   ),),
              //   ),
              AvatarGlow(
    startDelay: Duration(milliseconds: 1000),
    glowColor: Colors.white,
    endRadius: 90.0,
    duration: Duration(milliseconds: 2000),
    repeat: true,
    showTwoGlows: true,
    repeatPauseDuration: Duration(milliseconds: 100),
    child: Material(
      elevation: 8.0,
      shape: CircleBorder(),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 69.0,
          backgroundImage: NetworkImage(
                  (sid != null) ? "http://cms.flatbasha.com/image/$sid.jpg" :
                        "https://i7.pngguru.com/preview/136/22/549/user-profile-computer-icons-girl-customer-avatar.jpg",
                ),
        ),
        //child: Image.asset('assets/images/flutter.png',height: 60,),
        //shape: BoxShape.circle
      ),
    ),
    shape: BoxShape.circle,
    animate: true,
    curve: Curves.fastOutSlowIn,
  ),
                new SizedBox(height: 5,),
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
          // CategoryHorizontal(),
          // Padding(
          // padding: EdgeInsets.only(top: 10.0,bottom: 20.0),
          // child: (users  != null && 1<users.length)?Text('(^_^) Active Councillers (~.~)',style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 16.0),):SizedBox()
          // ),
          Container(
          height: 110.0,
           child: (users != null)?ListView.builder(
           scrollDirection: Axis.horizontal,
           itemCount: (users != null) ? users.length : 0,
           itemBuilder: (BuildContext context,int index)=> 
           Category(
             imgCaption: users[index]['name'],
             imgLocation: "http://cms.flatbasha.com/image/"+users[index]["id"].toString()+".jpg",
           ),
          ):
      ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // Category(
          //   imgCaption: 'demoz',
          //   imgLocation: 'assets/images/collaboration.png',
          // ),
        ],
      ),
    ),
            ],
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
          Route route=MaterialPageRoute(builder: (context) => CouncillerPage());
          Navigator.push(context, route);
        },
        heroTag: null,
      ),
      ):SizedBox(),
       Padding(
        padding: EdgeInsets.all(10.0),
        child: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.camera_front,color: Colors.blueAccent,
        ),
        onPressed: () async {
          Route route=MaterialPageRoute(builder: (context) => ProfileUpdate());
          Navigator.push(context, route);
        },
        heroTag: null,
      ),
      ),
      Padding(
        padding: EdgeInsets.all(10.0),
        child: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.power_settings_new,color: Colors.blueAccent,
        ),
        onPressed: () async {  
          var a = auth.logoutUser(sid);
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

class Category extends StatelessWidget {
  final String imgLocation;
  final String imgCaption;
  Category({
    this.imgCaption,
    this.imgLocation
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
      child:
      InkWell(
        onTap: (){},
        child:
        // Container(
        //   width: 120.0,
        //   height: 120.0,
        //   child: ListTile(
        //     title: Image.network(imgLocation),
        //     subtitle: Text(imgCaption,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12)),
        //   ),
        // ),
      Padding(
        padding: EdgeInsets.only(left:10.0),
        child:Column(
        children: <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 0.0),
        child: 
        Container(
        width: 85.0,
        height: 75.0,
        child:
      CircleAvatar(
       backgroundColor: Colors.white,
       radius: 0.0,
       child: 
       ClipOval(
       child:
           Image.network(imgLocation,fit: BoxFit.fill,height: 70,width: 70)
        ),
       ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
        Text(imgCaption,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12),softWrap: true,),
      SizedBox(
        height: 2,
      ),
        Text('(Online)',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 10),softWrap: true,),
        ],
      ),
      ),
      )
      );
  }
}