import 'package:flutter/material.dart';
import 'package:cms/appBars.dart';
import 'package:cms/controller/Others.dart';
import 'package:cms/controller/councill.dart';
import 'package:cms/util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class RefferedReq extends StatefulWidget {
  int postId;
  RefferedReq({Key key,this.postId}) : super(key: key);
  @override
  _RefferedReqState createState() => _RefferedReqState(this.postId);
}

class _RefferedReqState extends State<RefferedReq> {
  int postId;
  _RefferedReqState(this.postId); 
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentsCtrl=new TextEditingController();
  TextEditingController roomCtrl=new TextEditingController();
  TextEditingController meetingDateCtrl=new TextEditingController();
  TextEditingController meetingTimeCtrl=new TextEditingController();
  ProgressDialog pr;var comments,room,meetingDate,meetingTime,councillerId,refferedId,counciller;
  SharedPreferences sp;List councillers;
  Others others=new Others();

@override
void initState(){
  super.initState();
  _getCounciller(0);
  _getUserData();
}

_submit() async{
  if(await others.checkConection()==true){
   if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      pr.update(message: "Please wait...");
      pr.show();
      var result =await Councill().referredCouncill(comments, refferedId, postId);
      pr.hide();
      print(result);
      if(result.contains("reffered councill successfuly")){
        //alertSucess("Alert","Your Councill Reffered Submited.");
        toast("Refferd successfully");
      }else{
        //alertError("Alert","Something Went Wrong");
        toast("Something Went Wrong");
      }
   }}else{
     others.showMessage(context, "Notice", "Please check your internet connection !!!");
   }
}

  void toast(String text) {
    Fluttertoast.showToast(
        msg: text,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }
  _getCounciller(int id) async{
    List c=await Others().getCounciller(id);
    setState(() {
      this.councillers=c;
    });
  }

 _setCouncillerId(String value){
    for(var item in councillers){
      if(item['name']==value){
         setState(() {
           this.refferedId=item['id'];
         });
      }
    }
  }

  _getUserData() async{
    sp=await SharedPreferences.getInstance();
    int postinguserid=sp.getInt('id');
    //int studentid=sp.getInt('studentid');
    setState(() {
      this.councillerId=postinguserid;
      //this.studentId=studentid;
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: fullAppbar(context,"Reffered Form","Reffer the post"),
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
                  labelText: 'Comments',
                  fillColor: Colors.white,
                  icon: Icon(Icons.border_color),
                  hintText: 'Write down comments for refferd',
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
                      DropdownButtonFormField(
                          decoration: new InputDecoration(
                            labelText: 'Select Counciller',
                            fillColor: Colors.white,
                            icon: Icon(Icons.school),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          onChanged: (value){
                            setState((){
                              this.counciller=value;
                            });
                            _setCouncillerId(counciller);
                          },
                          value: (councillers != null)?counciller:null,
                          items: (councillers != null)?councillers.map((array){
                            return DropdownMenuItem(
                              value: array['name'].toString(), 
                              child: Text("Mr. "+array['name']),
                            );
                          }).toList():null,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please select the counciller';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                height: 15,
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

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];

