import 'package:flutter/material.dart';
import 'util.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key key,this.bottomNavigationBarIndex,this.context}) : super(key:key);
   int bottomNavigationBarIndex;
   BuildContext context;

  @override
  _BottomNavState createState() => _BottomNavState(bottomNavigationBarIndex: bottomNavigationBarIndex,context: context);
}

class _BottomNavState extends State<BottomNav> {
  int bottomNavigationBarIndex;
  final BuildContext context;
  _BottomNavState({this.bottomNavigationBarIndex,this.context});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: bottomNavigationBarIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize:12,
        selectedLabelStyle: TextStyle(color: CustomColors.BlueDark),
    selectedItemColor: CustomColors.BlueDark,
    unselectedFontSize: 10,
    items: [
    BottomNavigationBarItem(
    icon: Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Image.asset(
    'assets/images/home.png',
    color: (bottomNavigationBarIndex == 0)
    ? CustomColors.BlueDark
        : CustomColors.TextGrey,
    ),
    ),
    title: Text('Today (5)'),
    ),
    BottomNavigationBarItem(
    icon: Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Image.asset(
    'assets/images/home.png',
    color: (bottomNavigationBarIndex == 1)
    ? CustomColors.BlueDark
        : CustomColors.TextGrey,
    ),
    ),
    title: Text('Waiting (0)'),
    ),
    BottomNavigationBarItem(
    icon: Container(
    margin: EdgeInsets.only(bottom: 5),
    ),
    title: Text(''),
    ),
    BottomNavigationBarItem(
    icon: Container(
    margin: EdgeInsets.only(bottom: 5),
    child: Image.asset(
    'assets/images/home.png',
    color: (bottomNavigationBarIndex == 2)
    ? CustomColors.BlueDark
        : CustomColors.TextGrey,
    ),
    ),
    title: Text('Pending (20)'),
    ),
    BottomNavigationBarItem(
    icon: Container(
    margin: EdgeInsets.only(bottom: 5),
    child: InkWell(
      onTap: (){

      },
      child: Image.asset(
        'assets/images/task.png',
        color: (bottomNavigationBarIndex == 3)
            ? CustomColors.BlueDark
            : CustomColors.TextGrey,
      ),
    )
    ),
    title: Text('Setteled (12)'),
    ),
    ],
    );
  }
}