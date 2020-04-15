import 'package:cms/controller/Others.dart';
import 'package:flutter/material.dart';
import 'package:cms/appBars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cms/util.dart';
import 'package:cms/controller/councill.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:date_format/date_format.dart';

class AcceptReq extends StatefulWidget {
  int postId;
  AcceptReq({Key key,this.postId}) : super(key: key);
  @override
  _AcceptReqState createState() => _AcceptReqState(this.postId);
}

class _AcceptReqState extends State<AcceptReq> {
  int postId;
  _AcceptReqState(this.postId);
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentsCtrl=new TextEditingController();
  TextEditingController roomCtrl=new TextEditingController();
  TextEditingController meetingDateCtrl=new TextEditingController();
  TextEditingController meetingTimeCtrl=new TextEditingController();
  ProgressDialog pr;var comments,room,meetingDate,meetingTime,councillerId;
  SharedPreferences sp;
  Others others=new Others();

  @override
  void initState(){
   super.initState();
   _getUserData();
  }

  void toast(String text) {
    Fluttertoast.showToast(
        msg: text,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  _submit() async{
  if(await others.checkConection() == true){
   if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      pr.update(message: "Please wait...");
      pr.show();
      var result =await Councill().acceptCouncill(comments, room, meetingDate, councillerId, postId);
      pr.hide();
      if(result.contains("accept councill successfuly")){
        toast("councill accepted");
      }else{
        toast("Something Went Wrong");
      }
   }}else{
     others.showMessage(context, "Notice", "Please check your internet connection !!!");
   }
}

  _getUserData() async{
    sp=await SharedPreferences.getInstance();
    int userid=sp.getInt('id');
    setState(() {
      this.councillerId=userid;
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: fullAppbar(context,"Approve Form","approve the councill"),
       body: 
       ListView(
         children: <Widget>[
        Form(
        key: _formKey, 
        child: 
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
          children: <Widget>[
            TextFormField(
                controller: commentsCtrl,
                decoration: new InputDecoration(
                  labelText: 'Wtite down comments...',
                  fillColor: Colors.white,
                  icon: Icon(Icons.border_color),
                  hintText: 'Write down comments',
                  border:  OutlineInputBorder(),
                  //fillColor: Colors.green
                ),
                validator:  (value) {
                  if (value.isEmpty) {
                    return 'Comments is required';
                  }else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                onSaved: (String val){
                  this.comments=val;
                },
              ),
             SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: roomCtrl,
                decoration: new InputDecoration(
                  labelText: 'Room No',
                  fillColor: Colors.white,
                  icon: Icon(Icons.event_seat),
                  hintText: 'Room no for councill',
                  border:  OutlineInputBorder(),
                  //fillColor: Colors.green
                ),
                validator:  (value) {
                  if (value.isEmpty) {
                    return 'Room No is required';
                  }else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                onSaved: (String val){
                  this.room=val;
                },
              ),
             SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: meetingDateCtrl,
                onChanged: (val){
                  setState(() {
                    this.meetingDate=val;
                  });
                },
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Meeting Date',
                  fillColor: Colors.white,
                  icon: Icon(Icons.access_time),
                  hintText: (meetingDate!=null)?formatDate(DateTime(meetingDate.year, meetingDate.month, meetingDate.day), [dd, '-', mm, '-', yyyy]).toString():"",
                  border:  OutlineInputBorder(),
                  //fillColor: Colors.green
                ),
                onTap: (){
                  DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2050, 12, 12), onChanged: (date) {
                              setState(() {
                                this.meetingDate=date;
                              });
                          }, onConfirm: (date) {
                            setState(() {
                              this.meetingDate=date;
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                validator: (value) {
                  if (meetingDate == null) {
                    return 'MeetingDate is required';
                  }else {
                    return null;
                  }
                },
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
                                      SizedBox(
                height: 25,
              ),
                        RaisedButton(
                      onPressed: () {
                         _submit();
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.0,
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
                            'Submit Request',
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
       ) 
    );
  }
  //  void alertSucess(String title,String body){
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return RichAlertDialog(
  //           alertTitle: richTitle(title),
  //           alertSubtitle: richSubtitle(body),
  //           alertType: RichAlertType.SUCCESS,
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text("OK"),
  //               onPressed: (){Navigator.pop(context);},
  //             ),
  //             FlatButton(
  //               child: Text("Cancel"),
  //               onPressed: (){Navigator.pop(context);},
  //             ),
  //           ],
  //         );
  //       }
  //   );
  // }

  // void alertError(String title,String body){
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return RichAlertDialog(
  //           alertTitle: richTitle(title),
  //           alertSubtitle: richSubtitle(body),
  //           alertType: RichAlertType.ERROR,
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text("OK"),
  //               onPressed: (){Navigator.pop(context);},
  //             ),
  //             FlatButton(
  //               child: Text("Cancel"),
  //               onPressed: (){Navigator.pop(context);},
  //             ),
  //           ],
  //         );
  //       }
  //   );
  // }
}