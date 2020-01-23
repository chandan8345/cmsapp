import 'package:flutter/material.dart';
import 'package:cms/util.dart';

class CouncillType extends StatefulWidget {
  CouncillType(String title, String cType, {Key key}) : super(key: key);
  String title,cType;
  @override
  _CouncillTypeState createState() => _CouncillTypeState(this.title,this.cType);
}

class _CouncillTypeState extends State<CouncillType> {
  String title,cType;
  _CouncillTypeState(this.title,this.cType);

  void onChanged(){
    setState(() {
      this.cType=title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onChanged();
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
            color: (cType == title) ?CustomColors.GreenIcon : null,
            boxShadow: (cType == title) ?[
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
  }
}
