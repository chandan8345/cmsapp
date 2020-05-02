import 'package:cms/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'util.dart';

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
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(10),
      //   child: Container(
      //     color: Colors.transparent,
      //     child: Padding(
      //       padding: EdgeInsets.only(left: 15,right: 15,bottom: 5,top: 0),
      //       child: Container(
      //        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      //        decoration: BoxDecoration(
      //        color: CustomColors.HeaderGreyLight,
      //        borderRadius: BorderRadius.circular(5.0),),
      //        child: TextFormField(
      //             decoration: new InputDecoration(
      //             labelText: '',
      //             fillColor: Colors.white,
                  
      //             //icon: Icon(Icons.search,color: Colors.white,),
      //             hintText: 'Search Here',
      //             suffixIcon: IconButton(
      //                 icon: Icon(Icons.search,color: Colors.white,),
      //                 onPressed: () {
                       
      //                 }),
      //             //border:  OutlineInputBorder(),
      //             //fillColor: Colors.green
      //           ),
      //        ),
      //       )
      //     ),
      //   ),
      // ),
    //  bottom: PreferredSize(
    //    preferredSize: Size.fromHeight(10),
    //    child: Container(
    //      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    //      padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
    //      decoration: BoxDecoration(
    //        color: CustomColors.HeaderGreyLight,
    //        borderRadius: BorderRadius.circular(5.0),
    //      ),
    //      child: Row(
    //        mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //        children: <Widget>[
    //          Column(
    //            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //            crossAxisAlignment: CrossAxisAlignment.start,
    //            children: <Widget>[
    //              TextFormField(
    //            // controller: reasonCtrl,
    //             decoration: new InputDecoration(
    //               labelText: 'Reason',
    //               fillColor: Colors.white,
    //               icon: Icon(Icons.border_color),
    //               hintText: 'Write down your reason',
    //               border:  UnderlineInputBorder(),
    //               //fillColor: Colors.green
    //             ),
    //             validator:  (value) {
    //               if (value.isEmpty) {
    //                 return 'Reason is required';
    //               }else if(value.length <= 25){
    //                 return 'Reason atleast 25 character';
    //               }
    //               else {
    //                 return null;
    //               }
    //             },
    //             keyboardType: TextInputType.text,
    //             style: new TextStyle(
    //               fontFamily: "Poppins",
    //             ),
    //             onSaved: (String val){
    //               //this.reason=val;
    //             },
    //           ),
    //             //  Text(
    //             //    'Today Reminder',
    //             //    style: TextStyle(
    //             //        color: Colors.white,
    //             //        fontSize: 17,
    //             //        fontWeight: FontWeight.w600),
    //             //  ),
    //             //  SizedBox(
    //             //    height: 3,
    //             //  ),
    //             //  Text(
    //             //    'Meeting with client',
    //             //    style: TextStyle(
    //             //        color: Colors.white,
    //             //        fontSize: 10,
    //             //        fontWeight: FontWeight.w300),
    //             //  ),
    //             //  SizedBox(
    //             //    height: 3,
    //             //  ),
    //             //  Text(
    //             //    '13.00 PM',
    //             //    style: TextStyle(
    //             //        color: Colors.white,
    //             //        fontSize: 10,
    //             //        fontWeight: FontWeight.w300),
    //             //  ),
    //            ],
    //          ),
    //          Container(
    //            width: MediaQuery.of(context).size.width / 3.0,
    //          ),
    //         //  Image.asset(
    //         //    'assets/images/bell-left.png',
    //         //    scale: 1.3,
    //         //  ),
    //          Container(
    //            margin: EdgeInsets.only(bottom: 80),
    //            child: Icon(
    //              Icons.clear,
    //              color: Colors.white,
    //              size: 18.0,
    //            ),
    //          ),
    //        ],
    //      ),
    //    ),
    //  ),
//boot
    ),
  );
}

class PopupDialog {
}

Widget emptyAppbar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(75.0),
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
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello Brenda!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              'Today you have no tasks',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
          child: Icon(Icons.ac_unit),
          //Image.asset('assets/images/photo.png'),
        ),
      ],
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
