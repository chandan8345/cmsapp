import 'dart:async';

import 'package:cms/accept.dart';
import 'package:cms/controller/Others.dart';
import 'package:cms/controller/councill.dart';
//import 'package:flip_box_bar/flip_box_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cms/util.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:nice_button/nice_button.dart';
import 'package:cms/controller/onscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cms/Request.dart';
import 'package:cms/settleReq.dart';
import 'package:cms/refferedReq.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'ProfilePage.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
  final refreshKey = new GlobalKey<RefreshIndicatorState>();
  TextEditingController searchCtrl=new TextEditingController();
  ScrollController _controller = new ScrollController();
  OnScreen display=new OnScreen();
  int bottomNavigationBarIndex = 0;
  String postStatus="today",history;
  int councillerid,userid;
  DateTime meetingDate;
  SharedPreferences sp;
  List post;String role;List councillers,unfiltered;
  Others others=new Others();
  ProgressDialog pr;
  //ProgressDialog _progressDialog = ProgressDialog();

  @override
  void initState() {
    super.initState();
    _welcome();
    _getPostRefresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _search(String search){
    var exist=search.length>0?true:false;
    if(exist){
      var filterdData=[];
      for(int i=0;i<unfiltered.length;i++){
        String reason = unfiltered[i]['reason'].toLowerCase();
        //String solution = unfiltered[i]['solution'].toLowerCase();
        if(reason.contains(search.toLowerCase())){
          filterdData.add(unfiltered[i]);
        }
      }
      setState(() {
        this.post=filterdData;
      });
    }else{
      setState(() {
        this.post=this.unfiltered;
      });
    }
  }

  _welcome() async{
    //others=new Others();
    sp=await SharedPreferences.getInstance();
    String r=sp.getString('role');
    setState(() {
      this.role=r;
    });
  }

    _initCall(String mobile) async{
     bool res = await FlutterPhoneDirectCaller.callNumber('+88' + mobile);
    }

    Future<Null> _getPostRefresh() async{
    if(await others.checkConection() == true){
    sp=await SharedPreferences.getInstance();
    int userid=sp.getInt('id');
    //_progressDialog.showProgressDialog(context,textToBeDisplayed: 'Loading...',dismissAfter: Duration(seconds: 1));
      if(postStatus == "today"){
        List a=await display.getToday(userid,role);
        setState(() {
          this.post=a;
          this.unfiltered=a;
        });
    }else if(postStatus == "waiting"){
        List a=await display.getWaiting(userid,role);
        setState(() {
          this.post=a;
          this.unfiltered=a;
        });
    }else if(postStatus == "accepted"){
        List a=await display.getPending(userid,role);
        setState(() {
          this.post=a;
          this.unfiltered=a;
        });
    }else if(postStatus == "settled"){
        List a=await display.getSettled(userid,role);
        setState(() {
          this.post=a;
          this.unfiltered=a;
        });
    }else{
      empty();
    }
    }else{
       others.showMessage(context, "Notice", "Please check your internet connection !!!");
    }
    print(post.length);
    return null;
  }

  Future<Null> _getPost() async{
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    if(await others.checkConection() == true){
    sp=await SharedPreferences.getInstance();
    int userid=sp.getInt('id');
    try{
      pr.update(message: "Loading...");
      pr.show();
    }catch(e){
      print(e);
    }
    //_progressDialog.showProgressDialog(context,textToBeDisplayed: 'Loading...',dismissAfter: Duration(seconds: 1));
      if(postStatus == "today"){
        List a=await display.getToday(userid,role);
        setState(() {
          this.post=a;
          this.unfiltered=a;
        });
    }else if(postStatus == "waiting"){
        List a=await display.getWaiting(userid,role);
        setState(() {
          this.post=a;
          this.unfiltered=a;
        });
    }else if(postStatus == "accepted"){
        List a=await display.getPending(userid,role);
        setState(() {
          this.post=a;
          this.unfiltered=a;
        });
    }else if(postStatus == "settled"){
        List a=await display.getSettled(userid,role);
        setState(() {
          this.post=a;
          this.unfiltered=a;
        });
    }else{
      empty();
    }
    }else{
       others.showMessage(context, "Notice", "Please check your internet connection !!!");
    }
    pr.dismiss();
    print(post.length);
    return null;
  }

  _removePost(int postId) async{
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    if(await others.checkConection() == true){
    pr.update(message: "Deleting...");
    pr.show();
    //_progressDialog.showProgressDialog(context,textToBeDisplayed: 'Loading...',dismissAfter: Duration(seconds: 1));
    String a=await Councill().removeCouncill(postId);
    if(a.contains("deleted")){
 if(postStatus == "today"){ 
        List a=await display.getToday(userid,role);
        setState(() {
          this.post=a;
        });
    }else if(postStatus == "waiting"){
        List a=await display.getWaiting(userid,role);
        setState(() {
          this.post=a;
        });
    }else if(postStatus == "accepted"){
        List a=await display.getPending(userid,role);
        setState(() {
          this.post=a;
        });
    }else if(postStatus == "settled"){
        List a=await display.getSettled(userid,role);
        setState(() {
          this.post=a;
        });
    }else{
      return Container(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: empty()
    ),
  );
    }
    }
    }else{
      others.showMessage(context, "Notice", "Please check your internet connection !!!");
    }
    pr.dismiss();
    _getPostRefresh();
  }
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //_progressDialog.showProgressDialog(context,textToBeDisplayed: 'Initializing...',dismissAfter: Duration(seconds: 1));
        return Scaffold(
          appBar: //fullAppbar(context,"Northern University Bangladesh","Counselling Management System",),
          PreferredSize(
    preferredSize: Size.fromHeight(70.0),
    child: GradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              //'$name',
              'Northern University Bangladesh',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              //'$sort',
              'Counseling Management System',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        post != null ? post.length > 0 ? Container(
          margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: InkWell(
            onTap: (){
                        showDialog(context: context,builder: (context){
                          return AlertDialog(
                            title: TextFormField(
                                        controller: searchCtrl,
                                        decoration: new InputDecoration(
                                        labelText: 'Search Here',
                                        fillColor: Colors.black,
                                        //icon: Icon(Icons.border_color),
                                        hintText: '',
                                        border:  OutlineInputBorder(),
                                        suffixIcon: IconButton(
                                          //icon: Text('Go',style: TextStyle(fontSize: 14,color: Colors.red,),),
                                          icon: Icon(Icons.search,color: Colors.blue,),
                                          onPressed: (){
                                           _search(searchCtrl.text);
                                           Navigator.pop(context);
                                        }),
                                      ),
                            ),
                          );
                        });
            },
            child: Icon(Icons.search),
          ),//Image.asset('assets/images/photo.png'),
        ):SizedBox():SizedBox(),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: InkWell(
            onTap: (){
               Route route=MaterialPageRoute(builder: (context) => ProfilePage());
                                Navigator.push(context, route);
            },
            child: Icon(Icons.dashboard),
          ),//Image.asset('assets/images/photo.png'),
        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
    ),
  ),
          body: RefreshIndicator(
            child:
            (post != null)? post.length != 0?
            Stack(
              children: <Widget>[
                listView(),
                post!=null?post.length>3?
                Positioned(
                  top: size.height-270,
                  left: size.width-60,
                  child: ClipOval(
                  child: Material(
                  color: Colors.black12, // button color
                  child: InkWell(
                  splashColor: Colors.blue, // inkwell color
                  child: SizedBox(width: 46, height: 46, child: Icon(Icons.keyboard_arrow_up,color: Colors.black,)),
                  onTap: () {
                    Timer(
                    Duration(seconds: 1),
                    () => _controller.jumpTo(_controller.position.minScrollExtent),
                    );
                  },
                  ),
                  ),
                  )
                ):SizedBox():SizedBox(),
                post!=null?post.length>3?
                Positioned(
                  top: size.height-220,
                  left: size.width-60,
                  child: ClipOval(
                  child: Material(
                  color: Colors.black12, // button color
                  child: InkWell(
                  splashColor: Colors.blue, // inkwell color
                  child: SizedBox(width: 46, height: 46, child: Icon(Icons.keyboard_arrow_down,color: Colors.black,)),
                  onTap: () {
                    Timer(
                    Duration(seconds: 1),
                    () => _controller.jumpTo(_controller.position.maxScrollExtent),
                    );
                  },
                  ),
  ),
)
                ):SizedBox():SizedBox(),
              ],
            ):empty():empty(),
            onRefresh: _getPostRefresh,
            key: refreshKey,
            color: CustomColors.BlueDark,
          ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (role == 'student')? fabView() : null,
      bottomNavigationBar: (role == 'student')?BottomNavTab1(bottomNavigationBarIndex) : BottomNavTab2(bottomNavigationBarIndex),
//       bottomNavigationBar: FlipBoxBar(
//               selectedIndex: bottomNavigationBarIndex,
//               items: [
//                 (role == 'student')?FlipBarItem(icon: Icon(Icons.library_add,color:Colors.white,), text: Text("Request",style: TextStyle(color: Colors.white),), frontColor: Colors.blue, backColor: Colors.blueAccent):null,
//                 FlipBarItem(icon: Icon(Icons.airline_seat_recline_normal,color:Colors.white,), text: Text("Today",style: TextStyle(color: Colors.white),), frontColor: Colors.teal, backColor: Colors.tealAccent),
//                 FlipBarItem(icon: Icon(Icons.record_voice_over,color:Colors.white,), text: Text("Waiting",style: TextStyle(color: Colors.white),), frontColor: Colors.orange, backColor: Colors.orangeAccent),
//                 FlipBarItem(icon: Icon(Icons.streetview,color:Colors.white,), text: Text("Pending",style: TextStyle(color: Colors.white),), frontColor: Colors.purple, backColor: Colors.purpleAccent),
//                 FlipBarItem(icon: Icon(Icons.thumbs_up_down,color:Colors.white,), text: Text("Settled",style: TextStyle(color: Colors.white),), frontColor: Colors.pink, backColor: Colors.pinkAccent),
//               ],
//               onIndexChanged: (newIndex){
//                 print(newIndex);
//                 switch(newIndex){
//                   case 0:
//                   Route route=MaterialPageRoute(builder: (context) => Request());
//                   Navigator.push(context, route);
//                   break;
//                   case 1:
//                     this.postStatus="waiting";
//                     this.bottomNavigationBarIndex=1;
//                     _getPost();
//                   break;
//                   case 2:
//                     this.postStatus="accepted";
//                     this.bottomNavigationBarIndex=2;
//                     _getPost();
//                   break;
//                   case 3:
//                     this.postStatus="settled";
//                     this.bottomNavigationBarIndex=3;
//                     _getPost();
//                   break;
//                   case 4:
//                     this.postStatus="today";
//                     this.bottomNavigationBarIndex=4;
//                     _getPost();
//                   break;
//                 }
//               },
// ),
      //(role == 'student')?BottomNavTab1(bottomNavigationBarIndex):BottomNavTab2(bottomNavigationBarIndex),
    );
  }
  
    Widget listView() =>  Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: (post != null)?ListView.builder(
          controller: _controller,
          itemCount: (post != null) ? post.length : 0,
          itemBuilder: (BuildContext context,int index){
            if(postStatus == "today"){
              return todayCard(index);
            }else if(postStatus == "waiting"){
              return waitingCard(index);
            }else if(postStatus == "accepted"){
             return acceptedCard(index);
            }else if(postStatus == "settled"){
              return settledCard(index);
            }else{
              return empty();
            }
          },
        ):empty(),
      ),
    );
  
    Widget todayCard(item) => Container(
      child:Padding(
        padding: EdgeInsets.all(10.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                backgroundColor: Colors.black45,
                radius: 28.0,
                child: 
                ClipOval(
                 child: 
                 (role != 'student')?Image.network("http://cms.flatbasha.com/image/"+post[item]["postinguserid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50,):Image.network("http://cms.flatbasha.com/image/"+post[item]["councillerid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50)
                 ), 
                ),
                // new CircleAvatar(
                //   backgroundColor: Colors.white,
                //   child: //(post != null)?Image.network("http://cms.flatbasha.com/image/"+post[item]["userid"].toString()+".jpg",fit: BoxFit.fill,):Image.asset('assets/images/photo.png')
                //   (role != 'student')?Image.network("http://cms.flatbasha.com/image/"+post[item]["postinguserid"].toString()+".jpg",fit: BoxFit.fill,):Image.network("http://cms.flatbasha.com/image/"+post[item]["councillerid"].toString()+".jpg",fit: BoxFit.fill,)
                // ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(post[item]['reason']!=null?post[item]['reason']:"",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w300)),
                ),
                Icon(Icons.call_missed_outgoing,color: CustomColors.OrangeIcon,size: 18,),
                Text(post[item]['postingdate']!=null?" "+Jiffy(post[item]['postingdate']).format('MMM do yy'):"",style: TextStyle(color: CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
                      Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              //color: CustomColors.BlueIcon,
              child: Text(post[item]['comments']!=null?post[item]['comments']:"",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 0,
            ),
            Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(post[item]['category']!=null?post[item]['category']:"",style: TextStyle(color:CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                Text(post[item]['room']!=null?post[item]['room']:"",style: TextStyle(color:CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                Text(post[item]['meetingdate']!=null?Jiffy(post[item]['meetingdate']).format('MMM do yy'):"",style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                Text(post[item]['meetingdate']!=null?Jiffy(post[item]['meetingdate']).jm:"",style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
               // Text('10:00 AM',style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
              ],
            ),
            Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: (role!='student')?NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.gavel,
                  fontSize: 14,
                  gradientColors: [CustomColors.GreenIcon, CustomColors.BlueIcon],
                  onPressed: () {
                  Route route=MaterialPageRoute(builder: (context) => SettleReq(postId: post[item]['postid']));
                  Navigator.push(context, route);
                  },
                ):null,
                ),
                 Container(
                  child: (role != 'student')?NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.call,
                  fontSize: 14,
                  gradientColors: [CustomColors.OrangeIcon, CustomColors.YellowIcon],
                  onPressed: () {
                      _initCall(post[item]['studentmobile']);
                  },
                ):NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.call,
                  fontSize: 14,
                  gradientColors: [CustomColors.OrangeIcon, CustomColors.YellowIcon],
                  onPressed: () {
                      _initCall(post[item]['teachermobile']);
                  },
                ),
                ),
                Container(
                  child: (role!='student')?NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.wc,
                  fontSize: 14,
                  gradientColors: [CustomColors.TrashRed, CustomColors.PurpleLight],
                  onPressed: () {
                  Route route=MaterialPageRoute(builder: (context) => RefferedReq(postId: post[item]['postid']));
                  Navigator.push(context, route);
                  },
                ):null,
                ),
                // Container(
                //   child: (role!='student')?NiceButton(
                //   radius: 50,
                //   width: 60,
                //   padding: EdgeInsets.all(5.0),
                //   text: "",
                //   icon: Icons.clear,
                //   fontSize: 14,
                //   gradientColors: [CustomColors.TrashRed, CustomColors.PurpleLight],
                //   onPressed: () {
                //     _removePost(post[item]['id']);
                //   },
                // ):null,
                // ),
              ],
            ),          SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      //height: 200,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.015, 0.015],
          colors: [CustomColors.OrangeIcon, Colors.white],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.GreyBorder,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
    );
  
    Widget waitingCard(item) => Container(
      child:Padding(
        padding: EdgeInsets.all(10.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                backgroundColor: Colors.black45,
                radius: 28.0,
                child: 
                ClipOval(
                 child: 
                 (role != 'student')?Image.network("http://cms.flatbasha.com/image/"+post[item]["postinguserid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50,):Image.network("http://cms.flatbasha.com/image/"+post[item]["councillerid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50)
                 ),
                ),
                // new CircleAvatar(
                //   backgroundColor: Colors.white,
                //   child: //(post != null)?Image.network("http://cms.flatbasha.com/image/"+post[item]["userid"].toString()+".jpg",fit: BoxFit.fill,):Image.asset('assets/images/photo.png'),
                //   (role != 'student')?Image.network("http://cms.flatbasha.com/image/"+post[item]["postinguserid"].toString()+".jpg",fit: BoxFit.fill,):Image.network("http://cms.flatbasha.com/image/"+post[item]["councillerid"].toString()+".jpg",fit: BoxFit.fill,)
                // ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(post[item]['reason']!=null?post[item]['reason']:"",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w300)),
                ),
                Column(
                  children: <Widget>[
                   Icon(Icons.calendar_today,color: CustomColors.BlueIcon,size: 15,),
                   // Icon(Icons.watch_later,color: CustomColors.BlueIcon,size: 15,),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(post[item]['postingdate']!=null?" "+Jiffy(post[item]['postingdate']).format('MMM do yy'):"",style: TextStyle(color: CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
                    //Text(post[item]['postingdate']!=null?" "+Jiffy(post[item]['postingdate']).jm:"",style: TextStyle(color: CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
            Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(post[item]['category']!=null?post[item]['category']:"",style: TextStyle(color:CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                Text(post[item]['department']!=null?post[item]['department']:"",style: TextStyle(color:CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                //Text(post[item]['meetingdate']!=null?Jiffy(post[item]['meetingdate']).format('MMM do yy'):"",style: TextStyle(color:CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                //Text(post[item]['semester']!=null?post[item]['semester']:"",style: TextStyle(color: CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                //Text('CALL',style: TextStyle(color:CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w500)),
              ],
            ),
            Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child:  (role != 'student')?NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.check,
                  fontSize: 14,
                  gradientColors: [CustomColors.BlueDark, CustomColors.BlueIcon],
                  onPressed: () {
                  Route route=MaterialPageRoute(builder: (context) => AcceptReq(postId: post[item]['postid']));
                  Navigator.push(context, route);
                  },
                ):null,
                ),
                  Container(
                  child: (role != 'student')?NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.call,
                  fontSize: 14,
                  gradientColors: [CustomColors.OrangeIcon, CustomColors.YellowIcon],
                  onPressed: () {
                      _initCall(post[item]['studentmobile']);
                      
                  },
                ):NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.call,
                  fontSize: 14,
                  gradientColors: [CustomColors.OrangeIcon, CustomColors.YellowIcon],
                  onPressed: () {
                      _initCall(post[item]['teachermobile']);
                  },
                ),
                ),
                NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.clear,
                  fontSize: 14,
                  gradientColors: [CustomColors.TrashRed, CustomColors.PurpleLight],
                  onPressed: () {
                    _removePost(post[item]['postid']);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      //height: 200,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.015, 0.015],
          colors: [CustomColors.BlueDark, Colors.white],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.GreyBorder,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
    );
  
    Widget settledCard(item) => Container(
      child:Padding(
        padding: EdgeInsets.all(10.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                backgroundColor: Colors.black45,
                radius: 28.0,
                child: ClipOval(
                 child: 
                 (post != null)?Image.network("http://cms.flatbasha.com/image/"+post[item]["postinguserid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50,):Image.asset('assets/images/photo.png'),
                 ), 
                ),
                // new CircleAvatar(
                //   backgroundColor: Colors.white,
                //   child: (post != null)?Image.network("http://cms.flatbasha.com/image/"+post[item]["postinguserid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50,):Image.asset('assets/images/photo.png'),
                // ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(post[item]['reason']!=null?post[item]['reason']:"",style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w300)),
                ),
                Icon(Icons.call_missed_outgoing,color: CustomColors.TrashRed,size: 18,),
                Text(post[item]['postingdate']!=null?""+Jiffy(post[item]['postingdate']).format('MMM do yy'):"",style: TextStyle(color: CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
              ],
            ),
            Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                backgroundColor: Colors.black45,
                radius: 28.0,
                child: 
                ClipOval(
                 child: 
                 (post != null)?Image.network("http://cms.flatbasha.com/image/"+post[item]["councillerid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50,):Image.asset('assets/images/photo.png'),
                 ),
                ), 
                // new CircleAvatar(
                //   backgroundColor: Colors.white,
                //   child: (post != null)?Image.network("http://cms.flatbasha.com/image/"+post[item]["councillerid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50,):Image.asset('assets/images/photo.png'),
                // ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(post[item]['solution']!=null?post[item]['solution']:"",style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w300)),
                ),
                Icon(Icons.call_missed_outgoing,color: CustomColors.GreenDark,size: 18,),
                Text(post[item]['settleddate']!=null?" "+Jiffy(post[item]['settleddate']).format('MMM do yy'):"",style: TextStyle(color: CustomColors.GreenDark,fontSize: 14,fontWeight: FontWeight.w600)),
              ],
            ),
            Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(post[item]['category']!=null?post[item]['category']:"",style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
                Text(post[item]['department']!=null?post[item]['department']:"",style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
                //Text(post[item]['semester']!=null?post[item]['semester']:"",style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
                //Text('SEC A',style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
                Text(post[item]['room']!=null?post[item]['room']:"",style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
                //Text('10:00 AM',style: TextStyle(color: CustomColors.PurpleDark,fontSize: 14,fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
      //height: 200,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.015, 0.015],
          colors: [CustomColors.GreenIcon, Colors.white],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.GreyBorder,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
    );
  
    Widget acceptedCard(item) => Container(
      child:Padding(
        padding: EdgeInsets.all(10.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                backgroundColor: Colors.black45,
                radius: 28.0,
                child: 
                ClipOval(
                 child: 
                 (role != 'student')?Image.network("http://cms.flatbasha.com/image/"+post[item]["postinguserid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50,):Image.network("http://cms.flatbasha.com/image/"+post[item]["councillerid"].toString()+".jpg",fit: BoxFit.fill,height: 50,width: 50)
                 ), 
                ),
                // new CircleAvatar(
                //   backgroundColor: Colors.red,
                //   child: //(post != null)?Image.network("http://cms.flatbasha.com/image/"+post[item]["userid"].toString()+".jpg",fit: BoxFit.fill,):Image.asset('assets/images/photo.png')
                //   (role != 'student')?Image.network("http://cms.flatbasha.com/image/"+post[item]["postinguserid"].toString()+".jpg",fit: BoxFit.fill,):Image.network("http://cms.flatbasha.com/image/"+post[item]["councillerid"].toString()+".jpg",fit: BoxFit.fill,)
                // ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(post[item]['reason']!=null?post[item]['reason']:"",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w300)),
                ),
                Icon(Icons.call_missed_outgoing,color: CustomColors.OrangeIcon,size: 18,),
                Text(post[item]['postingdate']!=null?" "+Jiffy(post[item]['postingdate']).format('MMM do yy'):"",style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(
              height: 0,
            ),
            Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              //color: CustomColors.BlueIcon,
              child: Text(post[item]['comments']!=null?post[item]['comments']:"",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 0,
            ),
            Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(post[item]['category']!=null?post[item]['category']:"",style: TextStyle(color:CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                Text(post[item]['room']!=null?post[item]['room']:"",style: TextStyle(color:CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                Text(post[item]['meetingdate']!=null?Jiffy(post[item]['meetingdate']).format('MMM do yy'):"",style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
                Text(post[item]['meetingdate']!=null?Jiffy(post[item]['meetingdate']).jm:"",style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
               // Text('10:00 AM',style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
              ],
            ),
            Divider(
              color: CustomColors.GreyBorder,
              thickness: 1,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: (role != 'student')?NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.gavel,
                  fontSize: 14,
                  gradientColors: [CustomColors.GreenIcon, CustomColors.BlueIcon],
                  onPressed: () {
                  Route route=MaterialPageRoute(builder: (context) => SettleReq(postId: post[item]['postid']));
                  Navigator.push(context, route);
                  },
                ):null,
                ),
                 Container(
                  child: (role != 'student')?NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.call,
                  fontSize: 14,
                  gradientColors: [CustomColors.OrangeIcon, CustomColors.YellowIcon],
                  onPressed: () {
                    _initCall(post[item]['studentmobile']);
                  },
                ):NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.call,
                  fontSize: 14,
                  gradientColors: [CustomColors.OrangeIcon, CustomColors.YellowIcon],
                  onPressed: () {
                      _initCall(post[item]['teachermobile']);
                  },
                ),
                ),
                Container(
                  child: (role!='student')?NiceButton(
                  radius: 50,
                  width: 60,
                  padding: EdgeInsets.all(5.0),
                  text: "",
                  icon: Icons.wc,
                  fontSize: 14,
                  gradientColors: [CustomColors.TrashRed, CustomColors.PurpleLight],
                  onPressed: () {
                  Route route=MaterialPageRoute(builder: (context) => RefferedReq(postId: post[item]['postid']));
                  Navigator.push(context, route);
                  },
                ):null,
                ),
                // Container(
                //   child: (role!='student')?NiceButton(
                //   radius: 50,
                //   width: 60,
                //   padding: EdgeInsets.all(5.0),
                //   text: "",
                //   icon: Icons.clear,
                //   fontSize: 14,
                //   gradientColors: [CustomColors.TrashRed, CustomColors.PurpleLight],
                //   onPressed: () {
                //     _removePost(post[item]['id']);
                //   },
                // ):null,
                // ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      //height: 200,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.015, 0.015],
          colors: [CustomColors.OrangeIcon, Colors.white],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.GreyBorder,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
    );
  
    Widget fabView() => customFab(context);
  
    Widget customFab(context) =>FloatingActionButton(
        onPressed: () {
         //mainBottomSheet(context);
        Route route=MaterialPageRoute(builder: (context) => Request());
        Navigator.push(context, route);
        },
        elevation: 5,
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/images/fab-add.png'),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                CustomColors.PurpleLight,
                CustomColors.PurpleDark,
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColors.PurpleShadow,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
        ),
      );
  
    // void mainBottomSheet(context) =>showModalBottomSheet(
    //   context: context,
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   builder: (BuildContext context) {
    //     return Container(
    //       height: MediaQuery.of(context).size.height - 100,
    //       padding:
    //       EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    //       child: Stack(
    //         alignment: AlignmentDirectional.topCenter,
    //         children: <Widget>[
    //           Positioned(
    //             top: MediaQuery.of(context).size.height / 25,
    //             left: 0,
    //             child: Container(
    //               height: MediaQuery.of(context).size.height,
    //               width: MediaQuery.of(context).size.width,
    //               decoration: BoxDecoration(
    //                 color: Colors.black54,
    //                 borderRadius: BorderRadius.vertical(
    //                   top: Radius.elliptical(175, 30),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: MediaQuery.of(context).size.height / 2 - 340,
    //             child: Container(
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: <Widget>[
    //                   InkWell(
    //                     onTap: () {
    //                       Navigator.pop(context);
    //                     },
    //                     child: Container(
    //                       width: 50,
    //                       height: 50,
    //                       child: Icon(Icons.arrow_downward),
    //                       //Image.asset('assets/images/fab-delete.png'),
    //                       decoration: const BoxDecoration(
    //                         gradient: LinearGradient(
    //                           begin: Alignment.topLeft,
    //                           end: Alignment.bottomRight,
    //                           colors: <Color>[
    //                             CustomColors.PurpleLight,
    //                             CustomColors.PurpleDark,
    //                           ],
    //                         ),
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(50.0),
    //                         ),
    //                         boxShadow: [
    //                           BoxShadow(
    //                             color: CustomColors.PurpleShadow,
    //                             blurRadius: 10.0,
    //                             spreadRadius: 5.0,
    //                             offset: Offset(0.0, 0.0),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(height: 20,),
    //                   Container(
    //                     width: MediaQuery.of(context).size.width / 1.2,
    //                     child: TextFormField(
    //                       initialValue: '$reason',
    //                       autofocus: false,
    //                       maxLines: 2,
    //                       style: TextStyle(
    //                           fontSize: 22, fontStyle: FontStyle.normal,color: Colors.white),
    //                       decoration:
    //                       InputDecoration(border: InputBorder.none),
    //                       onChanged: (value){
    //                         this.reason=value;
    //                       },
    //                     ),
    //                   ),
    //                   SizedBox(height: 5),
    //                   //Text('You Selected $type', style: TextStyle(fontSize: 12,color: Colors.white)),
    //                   Container(
    //                     width: MediaQuery.of(context).size.width / 1.2,
    //                     height: 50,
    //                     padding: EdgeInsets.symmetric(vertical: 10),
    //                     decoration: BoxDecoration(
    //                       border: Border(
    //                         top: BorderSide(
    //                           width: 1.0,
    //                           color: CustomColors.GreyBorder,
    //                         ),
    //                         bottom: BorderSide(
    //                           width: 1.0,
    //                           color: CustomColors.GreyBorder,
    //                         ),
    //                       ),
    //                     ),
    //                     child:
    //                     ListView(
    //                       scrollDirection: Axis.horizontal,
    //                       shrinkWrap: true,
    //                       children: <Widget>[
    //                         CouncillType('Admission',type),
    //                         CouncillType('Tution Fees',type),
    //                         CouncillType('Class Schedule',type),
    //                         CouncillType('Exam Permit',type),
    //                         CouncillType('Project/Thesis',type),
    //                         CouncillType('Harresment',type),
    //                         CouncillType('Internship',type),
    //                         CouncillType('Contest',type),
    //                         CouncillType('Sports',type),
    //                         CouncillType('Others',type),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(height: 30),
    //                   Container(
    //                   width: MediaQuery.of(context).size.width / 1.2,
    //                   height: 100,
    //                   child: Row(
    //                     children: <Widget>[
    //                       Expanded(
    //                         child: 
    //                           Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: <Widget>[
    //                             Container(
    //                               child: Text(
    //                                 'Choose date',
    //                                 textAlign: TextAlign.right,
    //                                 style: TextStyle(fontSize: 12,color: Colors.white),
    //                               ),
    //                             ),
    //                             SizedBox(height: 10),
    //                             InkWell(
    //                               onTap: (){},
    //                               child: Container(
    //                               child: Row(
    //                                 children: <Widget>[
    //                                   Text(
    //                                     '$meetingDate',
    //                                     textAlign: TextAlign.left,
    //                                     style: TextStyle(
    //                                         fontSize: 12,
    //                                         fontWeight: FontWeight.w600,color: Colors.white),
    //                                   ),
    //                                   SizedBox(width: 5),
    //                                   RotatedBox(
    //                                     quarterTurns: 0,
    //                                     child: Icon(Icons.touch_app,color: Colors.white,),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ), 
    //                             ),
    //                           ],
    //                           ),
    //                         ),
    //                       Expanded(
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: <Widget>[
    //                             Container(
    //                               child: Text(
    //                                 'Assigned Request',
    //                                 textAlign: TextAlign.left,
    //                                 style: TextStyle(fontSize: 12,color: Colors.white),
    //                               ),
    //                             ),
    //                             SizedBox(height: 10),
    //                             Container(
    //                               child: Row(
    //                                 children: <Widget>[
    //                                   Text(
    //                                     'Mr. Example',
    //                                     textAlign: TextAlign.left,
    //                                     style: TextStyle(
    //                                         fontSize: 12,
    //                                         fontWeight: FontWeight.w600,color: Colors.white),
    //                                   ),
    //                                   SizedBox(width: 5),
    //                                   RotatedBox(
    //                                     quarterTurns: 0,
    //                                     child: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             SizedBox(height: 30),
    //                           ],
    //                         ),
    //                       )
    //                     ],
    //                   )
    //                   ),
    //                   RaisedButton(
    //                     onPressed: () {
    //                        Navigator.pop(context);
    //                     },
    //                     textColor: Colors.white,
    //                     padding: const EdgeInsets.all(0.0),
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(8.0),
    //                     ),
    //                     child: Container(
    //                       width: MediaQuery.of(context).size.width / 1.2,
    //                       height: 60,
    //                       decoration: const BoxDecoration(
    //                         gradient: LinearGradient(
    //                           colors: <Color>[
    //                             CustomColors.GreenLight,
    //                             CustomColors.GreenDark,
    //                           ],
    //                         ),
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(8.0),
    //                         ),
    //                         boxShadow: [
    //                           BoxShadow(
    //                             color: CustomColors.GreenShadow,
    //                             blurRadius: 2.0,
    //                             spreadRadius: 1.0,
    //                             offset: Offset(0.0, 0.0),
    //                           ),
    //                         ],
    //                       ),
    //                       padding:
    //                       const EdgeInsets.fromLTRB(20, 10, 20, 10),
    //                       child: Center(
    //                         child: const Text(
    //                           'Add Request',
    //                           style: TextStyle(
    //                               fontSize: 18,
    //                               fontWeight: FontWeight.w500),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  
    // Widget CouncillType(title,type) => InkWell(
    //   onTap: (){
    //     setState(() {
    //       this.type=title;
    //     });
    //     Navigator.pop(context);
    //     mainBottomSheet(context);
    //     },
    //   child: Center(
    //     child:
    //     Container(
    //       margin: EdgeInsets.only(right: 10),
    //       child: Text(
    //         '$title',
    //         style: TextStyle(color: Colors.white),
    //       ),
    //       padding: EdgeInsets.symmetric(
    //           vertical: 5, horizontal: 10),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(5),
    //         ),
    //         color: (type == title) ?CustomColors.GreenIcon : null,
    //         boxShadow: (type == title) ?[
    //           BoxShadow(
    //             color: CustomColors.GreenShadow,
    //             blurRadius: 5.0,
    //             spreadRadius: 3.0,
    //             offset: Offset(0.0, 0.0),
    //           ),
    //         ] : null,
    //       ),
    //     ),
    //   ),
    // );
  
    Widget Cardview(item) => Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
        padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('assets/images/checked-empty.png'),
            Text(
              '08.00 AM',
              style: TextStyle(color: CustomColors.TextGrey),
            ),
            Container(
              width: 180,
              child: Text(
                'Send project file',
                style: TextStyle(
                    color: CustomColors.TextHeader,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Image.asset('assets/images/bell-small.png'),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.015, 0.015],
            colors: [CustomColors.GreenIcon, Colors.white],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: CustomColors.GreyBorder,
              blurRadius: 10.0,
              spreadRadius: 5.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        SlideAction(
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: CustomColors.TrashRedBackground),
              child: Image.asset('assets/images/trash.png'),
            ),
          ),
          onTap: () => print('view'),
        ),
      ],
    );
  
    Widget BottomNavTab1(bottomNavigationBarIndex)=> BottomNavigationBar(
    currentIndex: bottomNavigationBarIndex,
    type: BottomNavigationBarType.fixed,
    selectedFontSize:12,
    selectedLabelStyle: TextStyle(color: CustomColors.BlueDark),
    selectedItemColor: CustomColors.BlueDark,
    unselectedFontSize: 12,
    items: [
      BottomNavigationBarItem(
        title: Text('Today',style: TextStyle(color: (bottomNavigationBarIndex==0)?CustomColors.BlueDark:CustomColors.TextGrey),),
        icon: Container(
          margin: EdgeInsets.only(bottom: 5),
          child:InkWell(
            onTap: (){
              setState(() {
                this.post=null;
                this.bottomNavigationBarIndex=0;
                this.postStatus="today";
              });
              _getPost();
            },
            child:  Icon(Icons.airline_seat_recline_normal,
              size: 30,
              color: (bottomNavigationBarIndex == 0) ? CustomColors.BlueDark : CustomColors.TextGrey,
            ),),
        ),
      ),
      //4
      BottomNavigationBarItem(
       icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: InkWell(
              onTap: (){
                setState(() {
                  this.post=null;
                  this.bottomNavigationBarIndex=1;
                  this.postStatus="waiting";
                });
                _getPost();
              },
              child: Icon(Icons.record_voice_over,
                size: 30,
                color: (bottomNavigationBarIndex == 1)
                    ? CustomColors.BlueDark
                    : CustomColors.TextGrey,
              ),
            )
        ),
        title: Text('Waiting',style: TextStyle(color: (bottomNavigationBarIndex==1)?CustomColors.BlueDark:CustomColors.TextGrey),),
      ),
  
  
     BottomNavigationBarItem(icon: Container(margin: EdgeInsets.only(bottom: 5),),title: Text(' '),),
  
    BottomNavigationBarItem(
    icon: Container(
    margin: EdgeInsets.only(bottom: 5),
    child:InkWell(
      onTap: (){
        setState(() {
          this.post=null;
          this.bottomNavigationBarIndex=2;
          this.postStatus="accepted";
        });
        _getPost();
      },
      child: Icon(Icons.streetview,
        size: 30,
    color: (bottomNavigationBarIndex == 2) ? CustomColors.BlueDark : CustomColors.TextGrey,
    ),),
    ),
      title: Text('Pending',style: TextStyle(color: (bottomNavigationBarIndex==2)?CustomColors.BlueDark:CustomColors.TextGrey),),
    ),
  
      BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(bottom: 5),
          child:InkWell(
            onTap: () async {
              setState(() {
                this.post=null;
                this.bottomNavigationBarIndex=3;
                this.postStatus="settled";
              });
              _getPost();
            },
            child: Icon(Icons.thumbs_up_down,
              size: 30,
              color: (bottomNavigationBarIndex == 3) ? CustomColors.BlueDark : CustomColors.TextGrey,
            ),),
        ),
        title: Text('Settled',style: TextStyle(color: (bottomNavigationBarIndex == 3)?CustomColors.BlueDark:CustomColors.TextGrey),),
      ),
    ],
    );
    
  Widget BottomNavTab2(bottomNavigationBarIndex)=> BottomNavigationBar(
    currentIndex: bottomNavigationBarIndex,
    type: BottomNavigationBarType.fixed,
    selectedFontSize:12,
    selectedLabelStyle: TextStyle(color: CustomColors.BlueDark),
    selectedItemColor: CustomColors.BlueDark,
    unselectedFontSize: 12,
    items: [
      BottomNavigationBarItem(
        title: Text('Today',style: TextStyle(color: (bottomNavigationBarIndex==0)?CustomColors.BlueDark:CustomColors.TextGrey),),
        icon: Container(
          margin: EdgeInsets.only(bottom: 5),
          child:InkWell(
            onTap: (){
              setState(() {
                this.post=null;
                this.bottomNavigationBarIndex=0;
                this.postStatus="today";
              });
              _getPost();
            },
            child:  Icon(Icons.airline_seat_recline_normal,
              size: 30,
              color: (bottomNavigationBarIndex == 0) ? CustomColors.BlueDark : CustomColors.TextGrey,
            ),),
        ),
      ),
      //4
      BottomNavigationBarItem(
       icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: InkWell(
              onTap: (){
                setState(() {
                  this.post=null;
                  this.bottomNavigationBarIndex=1;
                  this.postStatus="waiting";
                });
                _getPost();
              },
              child: Icon(Icons.record_voice_over,
                size: 30,
                color: (bottomNavigationBarIndex == 1)
                    ? CustomColors.BlueDark
                    : CustomColors.TextGrey,
              ),
            )
        ),
        title: Text('Waiting',style: TextStyle(color: (bottomNavigationBarIndex==1)?CustomColors.BlueDark:CustomColors.TextGrey),),
      ),
  
    BottomNavigationBarItem(
    icon: Container(
    margin: EdgeInsets.only(bottom: 5),
    child:InkWell(
      onTap: (){
        setState(() {
          this.post=null;
          this.bottomNavigationBarIndex=2;
          this.postStatus="accepted";
        });
        _getPost();
      },
      child: Icon(Icons.streetview,
        size: 30,
    color: (bottomNavigationBarIndex == 2) ? CustomColors.BlueDark : CustomColors.TextGrey,
    ),),
    ),
      title: Text('Pending',style: TextStyle(color: (bottomNavigationBarIndex==2)?CustomColors.BlueDark:CustomColors.TextGrey),),
    ),
  
      BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(bottom: 5),
          child:InkWell(
            onTap: (){
              setState(() {
                this.post=null;
                this.bottomNavigationBarIndex=3;
                this.postStatus="settled";
              });
              _getPost();
            },
            child: Icon(Icons.thumbs_up_down,
              size: 30,
              color: (bottomNavigationBarIndex == 3) ? CustomColors.BlueDark : CustomColors.TextGrey,
            ),),
        ),
        title: Text('Settled',style: TextStyle(color: (bottomNavigationBarIndex == 3)?CustomColors.BlueDark:CustomColors.TextGrey),),
      ),
    ],
    );
  
  
    Widget empty()=> Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child:   Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,//8
              child: Hero(
                tag: 'Clipboard',
                child: Image.asset('assets/images/Clipboard.png'),
              ),
            ),
            Expanded(
              flex: 1,//2
              child: Column(
                children: <Widget>[
                  Text(
                    'No Appointment',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.TextHeader),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'You have no tasks to do.',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: CustomColors.TextBody,
                        fontFamily: 'opensans'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    )
       )
    );
  }
  
  class SearchChoices {
}

Widget fullAppbar(BuildContext context,String name,String sort) {
  return PreferredSize(
    preferredSize: Size.fromHeight(70.0),
    child: GradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$name',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              '$sort',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      actions: name=="Northern University Bangladesh"?(<Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: InkWell(
            onTap: (){
            },
            child: Icon(Icons.search),
          ),//Image.asset('assets/images/photo.png'),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
          child: InkWell(
            onTap: (){
               Route route=MaterialPageRoute(builder: (context) => ProfilePage());
                                Navigator.push(context, route);
            },
            child: Icon(Icons.dashboard),
          ),//Image.asset('assets/images/photo.png'),
        ),
      ]):null,
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
    ),
  );
}


class CircleOne extends CustomPainter {
  Paint _paint;

  CircleOne() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(28.0, 0.0), 99.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  Paint _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(-30, 20), 50.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}