import 'dart:convert';
import 'package:cms/ProfilePage.dart';
import 'package:cms/onboarding.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cms/appBars.dart';
import 'package:cms/register.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ProgressDialog pr;SharedPreferences sp;
  String name,role;List today,waiting,pending,settled;int no;

  @override
  void initState(){
    super.initState();
    _welcome();
  }

  _welcome() async{
    sp=await SharedPreferences.getInstance();
    String r=sp.getString('role');
    String n=sp.getString('name');
    int i=sp.getInt('id');
    setState(() {
      this.name=n;
      this.role=r;
      this.no=i;
    });
    _today();
    _waiting();
    _pending();
    _settled();
  }

   Future _today() async {
    Dio dio = new Dio();
    Response r1 = await dio.get("http://cms.flatbasha.com/totaltoday?id=$no");
    setState(() {
    this.today = json.decode(r1.toString());
    });
    print(no);
  }
  Future _waiting() async{
    Dio dio = new Dio();
    Response r2 =await dio.get("http://cms.flatbasha.com/totalwaiting?id=$no");
        setState(() {
    this.waiting = json.decode(r2.toString());
        });
  }
    Future _pending() async{
    Dio dio = new Dio();
    Response r3 =await dio.get("http://cms.flatbasha.com/totalpending?id=$no");
        setState(() {
    this.pending = json.decode(r3.toString());
        });
        print(pending[0]['total']);
  }
    Future _settled() async{
    Dio dio = new Dio();
    Response r4 =await dio.get("http://cms.flatbasha.com/totalsettled?id=$no");
    setState(() {
    this.settled = json.decode(r4.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: fullAppbar(context,"Dashboard","information center"),
       body:
        Padding(
        padding: EdgeInsets.only(top: 5,left: 5,right: 5),
         child:
          ListView(
           children: <Widget>[
             Padding(
             padding: EdgeInsets.only(bottom: 0,left: 0),
               child: Text('',textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontSize: 0),),
             ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: Colors.blueAccent,
                child: Padding(
                  padding: EdgeInsets.only(top: 40,bottom: 10),
                  child: Container(
                    height: 220,
                    child:
                    ListView(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                         child:ClipOval(
                        child: SizedBox(
                        width: 120,
                        height: 120,
                        child:(no != null) ? Image.network("http://cms.flatbasha.com/image/$no.jpg",fit: BoxFit.fill,) :
                        Image.network("https://i7.pngguru.com/preview/136/22/549/user-profile-computer-icons-girl-customer-avatar.jpg",fit: BoxFit.fill)),
                  )
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(name==null?"Username":name,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:3),
                              child: Text(role==null?"Role":role,textAlign: TextAlign.center,style: TextStyle(color:  Colors.white70,fontSize: 14),),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(top: 2),
                            //   child: Text('Active',textAlign: TextAlign.center,style: TextStyle(color:  Colors.white70,fontSize: 12),),
                            // )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child:
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(today!=null?today[0]['total'].toString():"0",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 25),),
                              ),
                              Expanded(
                                child: Text(waiting!=null?waiting[0]['total'].toString():"0",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 25),),
                              ),
                              Expanded(
                                child: Text(pending!=null?pending[0]['total'].toString():"0",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 25),),
                              ),
                              Expanded(
                                child: Text(settled!=null?settled[0]['total'].toString():"0",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 25),),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child:
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text('Today',textAlign: TextAlign.center,style: TextStyle(color: Colors.white70,fontSize: 14),),
                              ),
                              Expanded(
                                child: Text('Waiting',textAlign: TextAlign.center,style: TextStyle(color: Colors.white70,fontSize: 14),),
                              ),
                              Expanded(
                                child: Text('Pending',textAlign: TextAlign.center,style: TextStyle(color: Colors.white70,fontSize: 14),),
                              ),
                              Expanded(
                                child: Text('Settled',textAlign: TextAlign.center,style: TextStyle(color: Colors.white70,fontSize: 14),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
//             Padding(
//               padding: EdgeInsets.only(top: 20),
//               child:
//               Text('Actions',textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontSize: 20),),
//             ),
            //  Padding(
            //    padding:EdgeInsets.only(top:25),
            //    child:
            //     Container(
            //       height: 100,
            //       child: ListView(
            //         children: <Widget>[
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: <Widget>[

            //               Row(
            //                 children: <Widget>[
            //                   Expanded(
            //                       child:InkWell(
            //                           onTap: (){
            //                             // Route route=MaterialPageRoute(builder: (context) => Profile());
            //                             // Navigator.push(context, route);
            //                           },
            //                           child:
            //                       CircleAvatar(
            //                         radius: 35,
            //                         backgroundColor: Colors.brown,
            //                         child: Icon(Icons.add_shopping_cart,color: Colors.white,),
            //                       )
            //                   ),),
            //                   Expanded(
            //                       child:
            //                       InkWell(
            //                         onTap: (){
            //                           // Route route=MaterialPageRoute(builder: (context) => Profile());
            //                           // Navigator.push(context, route);
            //                         },
            //                         child:
            //                           CircleAvatar(
            //                             radius: 35,
            //                             backgroundColor: Colors.pink,
            //                             child: Icon(Icons.person,color: Colors.white,),
            //                           )
            //                       )
            //                   ),
            //                   Expanded(
            //                       child:  CircleAvatar(
            //                         radius: 35,
            //                         backgroundColor: Colors.pink,
            //                         child: Icon(Icons.account_balance_wallet,color: Colors.white,),
            //                       )
            //                   ),
            //                   Expanded(
            //                       child:  CircleAvatar(
            //                         radius: 35,
            //                         backgroundColor: Colors.pink,
            //                         child: Icon(Icons.forum,color: Colors.white,),
            //                       )
            //                   ),
            //                 ],
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.only(top: 5),
            //                 child:
            //                 Row(
            //                   children: <Widget>[
            //                     Expanded(
            //                       child: Text('My Ads',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 14),),
            //                     ),
            //                     Expanded(
            //                       child: Text('Profile',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 14),),
            //                     ),
            //                     Expanded(
            //                       child: Text('Category',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 14),),
            //                     ),
            //                     Expanded(
            //                       child: Text('Department',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 14),),
            //                     )
            //                   ],

            //                 ),
            //               )
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //     ),
             Padding(
               padding:EdgeInsets.only(top:20),
               child:
               Container(
                 height: 100,
                 child: ListView(
                   children: <Widget>[
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[

                         Row(
                           children: <Widget>[
                            //  Expanded(
                            //    child:InkWell(
                            //        onTap: (){
                            //         //  Route route=MaterialPageRoute(builder: (context) => AdsSubmit());
                            //         //  Navigator.push(context, route);
                            //        },
                            //        child:
                            //        CircleAvatar(
                            //          radius: 35,
                            //          backgroundColor: Colors.pink,
                            //          child: Icon(Icons.add_shopping_cart,color: Colors.white,),
                            //        )
                            //    ),
                            //  ),
                             Expanded(
                                 child:  InkWell(
                                   onTap: (){
                                   Route route=MaterialPageRoute(builder: (context) => ProfilePage());
                                   Navigator.push(context, route);
                                   },
                                   child:
                                   CircleAvatar(
                                   radius: 35,
                                   backgroundColor: Colors.deepOrange,
                                   child: Icon(Icons.person,color: Colors.white,),
                                 )
                             )
                             ),
                             Expanded(
                                 child:  InkWell(
                                   onTap: (){
                                   Route route=MaterialPageRoute(builder: (context) => register());
                                   Navigator.push(context, route);
                                   },
                                   child:
                                   CircleAvatar(
                                   radius: 35,
                                   backgroundColor: Colors.green,
                                   child: Icon(Icons.laptop,color: Colors.white,),
                                 )
                             )),
                             Expanded(
                               child:InkWell(
                                   onTap: () async {
                                    sp=await SharedPreferences.getInstance();
                                    await sp.clear();
                                   Route route=MaterialPageRoute(builder: (context) => Onboarding());
                                   Navigator.push(context, route);
                                   },
                                   child:
                                   CircleAvatar(
                                     radius: 35,
                                     backgroundColor: Colors.pink,
                                     child: Icon(Icons.phonelink_erase,color: Colors.white,),
                                   )
                               ),
                             ),
                           ],
                         ),
                         Padding(
                           padding: EdgeInsets.only(top: 5),
                           child:
                           Row(
                             children: <Widget>[
                              //  Expanded(
                              //    child: Text('Semester',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 14),),
                              //  ),
                               Expanded(
                                 child: Text('My Profile',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 14),),
                               ),
                               Expanded(
                                 child: Text('Sign Up',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 14),),
                               ),
                               Expanded(
                                   child:
                                   Text("Sign Out",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 14),),
                               )
                             ],

                           ),
                         )
                       ],
                     )
                   ],
                 ),
               ),
             ),
          ],
          ),
      ),
    );
  }
}