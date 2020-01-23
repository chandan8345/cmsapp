import 'package:flutter/material.dart';
import 'package:cms/home.dart';
import 'util.dart';

class Modal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 80,
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
                          child: Image.asset('assets/images/fab-delete.png'),
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 0),
//                          Text(
//                            'Add new task',
//                            style: TextStyle(
//                                fontSize: 13, fontWeight: FontWeight.w600,color: Colors.white),
//                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              initialValue: 'Book a table for dinner ',
                              autofocus: true,
                              style: TextStyle(
                                  fontSize: 22, fontStyle: FontStyle.normal,color: Colors.white),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 60,
                            padding: EdgeInsets.symmetric(vertical: 15),
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
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: <Widget>[
                                CouncillType('Admission',false),
                                CouncillType('Tution Fees',true),
                                CouncillType('Class Schedule',false),
                                CouncillType('Exam Permit',false),
                                CouncillType('Project/Thesis',false),
                                CouncillType('Harresment',false),
                                CouncillType('Contest',false),
                                CouncillType('Sports',false),
                                CouncillType('Others',false),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Choose date',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12,color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
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
                                  quarterTurns: 1,
                                  child: Icon(Icons.chevron_right),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                              // Navigator.pop(context);
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
                                    CustomColors.BlueLight,
                                    CustomColors.BlueDark,
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomColors.BlueShadow,
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
                                  'Add task',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
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
  }
  Widget CouncillType(title,bgColor) =>InkWell(
    onTap: (){

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
          color: (bgColor == true) ?CustomColors.GreenIcon : null,
          boxShadow: (bgColor == true) ?[
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
