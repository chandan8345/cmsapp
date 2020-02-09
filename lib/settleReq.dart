import 'package:flutter/material.dart';
import 'package:cms/appBars.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:cms/util.dart';
import 'package:cms/controller/councill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class SettleReq extends StatefulWidget {
  int postId;
  SettleReq({Key key,this.postId}) : super(key: key);  
  @override
  _SettleReqState createState() => _SettleReqState(this.postId);
}

class _SettleReqState extends State<SettleReq> {
  int postId;
  _SettleReqState(this.postId);
final _formKey = GlobalKey<FormState>();
  TextEditingController commentsCtrl=new TextEditingController();
  TextEditingController roomCtrl=new TextEditingController();
  TextEditingController meetingDateCtrl=new TextEditingController();
  TextEditingController meetingTimeCtrl=new TextEditingController();
  ProgressDialog pr;var meetingDate,councillerId,summary;
  SharedPreferences sp;

  @override
  void initState(){
   super.initState();
   _getUserData();
  }

  _submit() async{
   if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      pr.update(message: "Please wait...");
      pr.show();
      var result =await Councill().settledCouncill(summary, councillerId, postId);
      pr.hide();
      if(result.contains("Settled councill successfuly")){
        alertSucess("Alert","Councill Settled Already.");
      }else{
        alertError("Alert","Something Went Wrong");
      }
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
       appBar: fullAppbar(context,"Settle Form","Settle the councill"),
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
                  labelText: 'Wtite down solution',
                  fillColor: Colors.white,
                  icon: Icon(Icons.border_color),
                  hintText: 'Write down solutions...',
                  border:  OutlineInputBorder(),
                  //fillColor: Colors.green
                ),
                validator:  (value) {
                  if (value.isEmpty) {
                    return 'Solution summary is required';
                  }else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                onSaved: (String val){
                  this.summary=val;
                },
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
   void alertSucess(String title,String body){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RichAlertDialog(
            alertTitle: richTitle(title),
            alertSubtitle: richSubtitle(body),
            alertType: RichAlertType.SUCCESS,
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: (){Navigator.pop(context);},
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: (){Navigator.pop(context);},
              ),
            ],
          );
        }
    );
  }

  void alertError(String title,String body){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RichAlertDialog(
            alertTitle: richTitle(title),
            alertSubtitle: richSubtitle(body),
            alertType: RichAlertType.ERROR,
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: (){Navigator.pop(context);},
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: (){Navigator.pop(context);},
              ),
            ],
          );
        }
    );
  }
}