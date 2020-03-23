import 'package:flutter/material.dart';
import 'package:cms/appBars.dart';
import 'package:cms/controller/Others.dart';
import 'package:cms/controller/councill.dart';
import 'package:cms/util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class Request extends StatefulWidget {

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
final _formKey = GlobalKey<FormState>();
TextEditingController reasonCtrl=new TextEditingController();
TextEditingController dateCtrl=new TextEditingController();
var reason,counciller,councillerId,postingUserId,type,categoryId,semesterId,departmentId,studentId,department;
SharedPreferences sp;
DateTime meetingDate;
List councillers,types,departments;
ProgressDialog pr;

@override
void initState(){
  super.initState();
  //_getCounciller();
  _getUserData();
  _Others();
  _getCategory();
}

_submit() async{
  Others others=new Others();
  if(await others.checkConection() == true){
   if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      pr.update(message: "Please wait...");
      pr.show();
      var result =await Councill().createCouncill(reason, categoryId, semesterId, departmentId, councillerId, postingUserId, meetingDate);
      pr.hide();
      print(result);
      if(result.contains("create councill successfuly")){
        alertSucess("Alert","Your Councill Request Submited.");
      }else{
        alertError("Alert","Something Went Wrong");
      }
   }
  }else{
    others.showMessage(context, "Notice", "Please check your internet connection !!!");
  }
}

  _getCounciller(int id) async{
    List c=await Others().getCounciller(id);
    setState(() {
      this.councillers=c;
    });
  }

   _setDepartment(String value){
     var id;
    for(var item in departments){
       if(item['name']==value){
         setState(() {
           id=item['id'];
         });
         _getCounciller(id);
      }
    }
  }

  _getCategory() async{
    List c=await Others().getCategory();
    setState(() {
      this.types=c;
    });
  }

    _Others()async{
    Others others=new Others();
    this.departments=await others.getDepartment();
    setState((){
    });
  }

  _setCategoryId(value)async{
    for(var item in types){
      if(item['name']==value){
         setState(() {
           this.categoryId=item['id'];
         });
      }
    } 
  }

 _setCouncillerId(String value){
    for(var item in councillers){
      if(item['name']==value){
         setState(() {
           this.councillerId=item['id'];
         });
      }
    }
  }

  _getUserData() async{
    sp=await SharedPreferences.getInstance();
    int semesterid=sp.getInt('semesterid');
    int departmentid=sp.getInt('departmentid');
    int postinguserid=sp.getInt('id');
    //int studentid=sp.getInt('studentid');
    setState(() {
      this.semesterId=semesterid;
      this.departmentId=departmentid;
      this.postingUserId=postinguserid;
      //this.studentId=studentid;
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: fullAppbar(context,"Create Request","add new councill"),
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
                controller: reasonCtrl,
                decoration: new InputDecoration(
                  labelText: 'Reason',
                  fillColor: Colors.white,
                  icon: Icon(Icons.border_color),
                  hintText: 'Write down your reason',
                  border:  OutlineInputBorder(),
                  //fillColor: Colors.green
                ),
                validator:  (value) {
                  if (value.isEmpty) {
                    return 'Reason is required';
                  }else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
                onSaved: (String val){
                  this.reason=val;
                },
              ),
              DropdownButtonFormField(
                          decoration: new InputDecoration(
                            labelText: 'Select Category',
                            fillColor: Colors.white,
                            icon: Icon(Icons.developer_board),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          onChanged: (value){
                            setState((){
                              this.type=value;
                            });
                            _setCategoryId(value);
                          },
                          value: (type != null)?type:null,
                          items: (types != null)?types.map((array){
                            return DropdownMenuItem(
                              value: array['name'].toString(), 
                              child: Text(array['name']),
                            );
                          }).toList():null,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please select the councilling type';
                            }
                            return null;
                          },
                        ),
                        DropdownButtonFormField(
                          decoration: new InputDecoration(
                            labelText: 'Select Department',
                            fillColor: Colors.white,
                            icon: Icon(Icons.import_contacts),
                            border: UnderlineInputBorder(),
                            //fillColor: Colors.green
                          ),
                          value: (department != null)?department:null,
                          items: (departments != null)?departments.map((array){
                            return DropdownMenuItem(
                              value: array['name'].toString(),
                              child: Text(array['name']),
                            );
                          }).toList():null,
                          onChanged: (value){
                            setState((){
                              this.department=value;
                            });
                            _setDepartment(department);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please select department for get counciller';
                            }
                            return null;
                          },
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
              TextFormField(
                controller: dateCtrl,
                onChanged: (val){
                  setState(() {
                    dateCtrl.text=val;
                  });
                },
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Meeting Date Time',
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

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];

