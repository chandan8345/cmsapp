import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:cms/controller/sharedData.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Auth{
  Dio dio=new Dio();
  var postURL ="http://flatbasha.com/registerUser";

  //Users
  Future<bool> registerUser(String name,String studentid,String mobile,String email,String password,String department,String semester,File image) async{
    var fileContent = image.readAsBytesSync();
    var base64image = base64.encode(fileContent);
    try{
      FormData formData = new FormData.fromMap(<String, dynamic>{
        "name" : name,
        "studentid" : studentid,
        "mobile" : mobile,
        "email" : email,
        "password" : password,
        "department" : department,
        "semester" : semester,
        "image" : base64image
       });
      Response response = await dio.post(postURL, data: formData);
      print(response);
      if(response.toString() != null){
        return true;
      }else{
        return false;
      }
      }catch (e){
        print(e);
    }
  }
  Future<bool> updateUser() async{

    return true;
  }
  Future<bool> loginUser(String mobile,String password,ProgressDialog p) async{
    var response = await dio.get("http://flatbasha.com/loginUser?mobile=$mobile&password=$password");
    if(response.data.toString().length > 2){
    List user = json.decode(response.toString());
    SharedData().setUserData(user);
    p.hide();
    return true;
    }else{ 
    p.hide();
    return false;
    }
  }
  Future<bool> logoutUser() async{
    SharedData().sessionOut();
    return true;
  }
  
}