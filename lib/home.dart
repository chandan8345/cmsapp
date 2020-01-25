import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cms/appBars.dart';
import 'package:cms/util.dart';
import 'package:nice_button/nice_button.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomNavigationBarIndex = 0;
  int userStatus=1;
  String postStatus="today";
  String type="Admission",reason="I Have a Reason for Councill";
  var post=[{
    'name':"chandan Kumar",
    'id':"2017004",
    'Class':"first"
  }];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullAppbar(context,"Hello Chandan"),
      body: listView(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (userStatus == 1)? fabView() : null,
      bottomNavigationBar: BottomNavTab(bottomNavigationBarIndex),
    );
  }

  
  Widget listView() =>  Container(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child:post != null ? ListView.builder(
        itemCount: (post == null) ? 0 : post.length,
        itemBuilder: (BuildContext context,int index){
          if(postStatus == "today"){
            return todayCard();
          }else if(postStatus == "waiting"){
            return waitingCard();
          }else if(postStatus == "accepted"){
           return acceptedCard();
          }else{
            return settledCard();
          }
        },
      ):empty(),
    ),
  );

  Widget todayCard() => Container(
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
              new CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/photo.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text('We have reason for make a solution for tution fees & permission ',style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w300)),
              ),
              Icon(Icons.call_missed_outgoing,color: CustomColors.TrashRed,size: 18,),
              Text(' 12 June',style: TextStyle(color: CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
            ],
          ),
          Divider(
            color: CustomColors.GreyBorder,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Education',style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w500)),
              Text('Room 501',style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w500)),
              Text('15 June',style: TextStyle(color: CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w500)),
              Text('10:00 AM',style: TextStyle(color: CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w500)),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NiceButton(
                radius: 50,
                width: 80,
                padding: EdgeInsets.all(10.0),
                text: "Settled",
                fontSize: 14,
                gradientColors: [CustomColors.GreenIcon, CustomColors.BlueIcon],
                onPressed: () {},
              ),
              NiceButton(
                radius: 50,
                width: 80,
                padding: EdgeInsets.all(10.0),
                text: "Reffered",
                fontSize: 14,
                gradientColors: [CustomColors.OrangeIcon, CustomColors.YellowIcon],
                onPressed: () {},
              ),
              NiceButton(
                radius: 50,
                width: 80,
                padding: EdgeInsets.all(10.0),
                text: "Remove",
                fontSize: 14,
                gradientColors: [CustomColors.TrashRed, CustomColors.PurpleLight],
                onPressed: () {},
              ),
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
        colors: [CustomColors.TrashRed, Colors.white],
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

  Widget waitingCard() => Container(
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
              new CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/photo.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text('We have reason for make a solution for tution fees & permission ',style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w300)),
              ),
              Icon(Icons.call_missed_outgoing,color: CustomColors.BlueIcon,size: 18,),
              Text(' 12 June',style: TextStyle(color: CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w600)),
            ],
          ),
          Divider(
            color: CustomColors.GreyBorder,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Education',style: TextStyle(color:CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w500)),
              Text('ECSE',style: TextStyle(color:CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w500)),
              Text('SEM 8th',style: TextStyle(color: CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w500)),
              Text('SEC A',style: TextStyle(color:CustomColors.BlueIcon,fontSize: 14,fontWeight: FontWeight.w500)),
            ],
          ),
          Divider(
            color: CustomColors.GreyBorder,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              NiceButton(
                radius: 50,
                width: 80,
                padding: EdgeInsets.all(10.0),
                text: "Procced",
                fontSize: 14,
                gradientColors: [CustomColors.BlueDark, CustomColors.BlueIcon],
                onPressed: () {},
              ),
              NiceButton(
                radius: 50,
                width: 80,
                padding: EdgeInsets.all(10.0),
                text: "Remove",
                fontSize: 14,
                gradientColors: [CustomColors.TrashRed, CustomColors.PurpleLight],
                onPressed: () {},
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

  Widget settledCard() => Container(
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
              new CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/photo.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text('We have reason for make a solution for tution fees & permission ',style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w300)),
              ),
              Icon(Icons.call_missed_outgoing,color: CustomColors.GreenDark,size: 18,),
              Text(' 12 June',style: TextStyle(color: CustomColors.GreenDark,fontSize: 14,fontWeight: FontWeight.w600)),
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
              new CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/photo.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text('We have reason for make a solution for tution fees & permission ',style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w300)),
              ),
              Icon(Icons.call_missed_outgoing,color: CustomColors.GreenDark,size: 18,),
              Text(' 12 June',style: TextStyle(color: CustomColors.GreenDark,fontSize: 14,fontWeight: FontWeight.w600)),
            ],
          ),
          Divider(
            color: CustomColors.GreyBorder,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Education',style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
              Text('CSE',style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
              Text('SEM 8TH',style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
              Text('SEC A',style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
              Text('501',style: TextStyle(color:CustomColors.TrashRed,fontSize: 14,fontWeight: FontWeight.w600)),
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

  Widget acceptedCard() => Container(
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
              new CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/photo.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text('We have reason for make a solution for tution fees & permission ',style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w300)),
              ),
              Icon(Icons.call_missed_outgoing,color: CustomColors.OrangeIcon,size: 18,),
              Text(' 12 June',style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            color: CustomColors.BlueIcon,
            child: Text('We have reason for make a solution for tution fees & permission ',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400)),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: CustomColors.GreyBorder,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Education',style: TextStyle(color:CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
              Text('Room 501',style: TextStyle(color:CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
              Text('15 June',style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
              Text('10:00 AM',style: TextStyle(color: CustomColors.OrangeIcon,fontSize: 14,fontWeight: FontWeight.w500)),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              NiceButton(
                radius: 50,
                width: 80,
                padding: EdgeInsets.all(10.0),
                text: "Settled",
                fontSize: 14,
                gradientColors: [CustomColors.GreenIcon, CustomColors.BlueIcon],
                onPressed: () {},
              ),
              NiceButton(
                radius: 50,
                width: 80,
                padding: EdgeInsets.all(10.0),
                text: "Reffered",
                fontSize: 14,
                gradientColors: [CustomColors.OrangeIcon, CustomColors.YellowIcon],
                onPressed: () {},
              ),
              NiceButton(
                radius: 50,
                width: 80,
                padding: EdgeInsets.all(10.0),
                text: "Remove",
                fontSize: 14,
                gradientColors: [CustomColors.TrashRed, CustomColors.PurpleLight],
                onPressed: () {},
              ),
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
       mainBottomSheet(context);
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

  void mainBottomSheet(context) =>showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height - 100,
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height / 25,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(175, 30),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 340,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.arrow_downward),
                        //Image.asset('assets/images/fab-delete.png'),
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
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextFormField(
                        initialValue: '$reason',
                        autofocus: false,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 22, fontStyle: FontStyle.normal,color: Colors.white),
                        decoration:
                        InputDecoration(border: InputBorder.none),
                        onChanged: (value){
                          this.reason=value;
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    //Text('You Selected $type', style: TextStyle(fontSize: 12,color: Colors.white)),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1.0,
                            color: CustomColors.GreyBorder,
                          ),
                          bottom: BorderSide(
                            width: 1.0,
                            color: CustomColors.GreyBorder,
                          ),
                        ),
                      ),
                      child:
                      ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: <Widget>[
                          CouncillType('Admission',type),
                          CouncillType('Tution Fees',type),
                          CouncillType('Class Schedule',type),
                          CouncillType('Exam Permit',type),
                          CouncillType('Project/Thesis',type),
                          CouncillType('Harresment',type),
                          CouncillType('Internship',type),
                          CouncillType('Contest',type),
                          CouncillType('Sports',type),
                          CouncillType('Others',type),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Choose date',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 12,color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Today, 19: - 21:00',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,color: Colors.white),
                                    ),
                                    SizedBox(width: 5),
                                    RotatedBox(
                                      quarterTurns: 0,
                                      child: Icon(Icons.touch_app,color: Colors.white,),
                                    ),
                                  ],
                                ),

                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Assigned Request',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 12,color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Mr. Example',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,color: Colors.white),
                                    ),
                                    SizedBox(width: 5),
                                    RotatedBox(
                                      quarterTurns: 0,
                                      child: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        )
                      ],
                    )
                    ),
                    RaisedButton(
                      onPressed: () {
                         Navigator.pop(context);
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
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
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                        ),
                        padding:
                        const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Center(
                          child: const Text(
                            'Add Request',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  Widget CouncillType(title,type) => InkWell(
    onTap: (){
      setState(() {
        this.type=title;
      });
      Navigator.pop(context);
      mainBottomSheet(context);
      },
    child: Center(
      child:
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Text(
          '$title',
          style: TextStyle(color: Colors.white),
        ),
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: (type == title) ?CustomColors.GreenIcon : null,
          boxShadow: (type == title) ?[
            BoxShadow(
              color: CustomColors.GreenShadow,
              blurRadius: 5.0,
              spreadRadius: 3.0,
              offset: Offset(0.0, 0.0),
            ),
          ] : null,
        ),
      ),
    ),
  );

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

  Widget BottomNavTab(bottomNavigationBarIndex)=> BottomNavigationBar(
  currentIndex: bottomNavigationBarIndex,
  type: BottomNavigationBarType.fixed,
  selectedFontSize:12,
  selectedLabelStyle: TextStyle(color: CustomColors.BlueDark),
  selectedItemColor: CustomColors.BlueDark,
  unselectedFontSize: 12,
  items: [
    BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(bottom: 5),
        child:InkWell(
          onTap: (){
            setState(() {
              this.bottomNavigationBarIndex=0;
              this.postStatus="today";
            });
          },
          child:  Icon(Icons.airline_seat_recline_normal,
            size: 30,
            color: (bottomNavigationBarIndex == 0) ? CustomColors.BlueDark : CustomColors.TextGrey,
          ),),
      ),
      title: Text('Today (20)',style: TextStyle(color: (bottomNavigationBarIndex==0)?CustomColors.BlueDark:CustomColors.TextGrey),),
    ),
    //4
    BottomNavigationBarItem(
      icon: Container(
          margin: EdgeInsets.only(bottom: 5),
          child: InkWell(
            onTap: (){
              setState(() {
                this.bottomNavigationBarIndex=1;
                this.postStatus="waiting";
              });
            },
            child: Icon(Icons.record_voice_over,
              size: 30,
              color: (bottomNavigationBarIndex == 1)
                  ? CustomColors.BlueDark
                  : CustomColors.TextGrey,
            ),
          )
      ),
      title: Text('Waiting (20)',style: TextStyle(color: (bottomNavigationBarIndex==1)?CustomColors.BlueDark:CustomColors.TextGrey),),
    ),

    (userStatus == 1) ? BottomNavigationBarItem(icon: Container(margin: EdgeInsets.only(bottom: 5),), title: Text(''),) : null ,

  BottomNavigationBarItem(
  icon: Container(
  margin: EdgeInsets.only(bottom: 5),
  child:InkWell(
    onTap: (){
      setState(() {
        this.bottomNavigationBarIndex=2;
        this.postStatus="accepted";
      });
    },
    child: Icon(Icons.streetview,
      size: 30,
  color: (bottomNavigationBarIndex == 2) ? CustomColors.BlueDark : CustomColors.TextGrey,
  ),),
  ),
    title: Text('Pending (20)',style: TextStyle(color: (bottomNavigationBarIndex==2)?CustomColors.BlueDark:CustomColors.TextGrey),),
  ),

    BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(bottom: 5),
        child:InkWell(
          onTap: (){
            setState(() {
              this.bottomNavigationBarIndex=3;
              this.postStatus="settled";
            });
          },
          child: Icon(Icons.thumbs_up_down,
            size: 30,
            color: (bottomNavigationBarIndex == 3) ? CustomColors.BlueDark : CustomColors.TextGrey,
          ),),
      ),
      title: Text('Settled (20)',style: TextStyle(color: (bottomNavigationBarIndex == 3)?CustomColors.BlueDark:CustomColors.TextGrey),),
    ),
  ],
  );

  Widget empty()=> Center(
    child: Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Hero(
              tag: 'Clipboard',
              child: Image.asset('assets/images/Clipboard-empty.png'),
            ),
          ),
          Expanded(
            flex: 3,
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
  );
}