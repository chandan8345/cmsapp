import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:cms/controller/sharedData.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth{
  Dio dio=new Dio();
  var postURL ="http://cms.flatbasha.com/registerUser";
  SharedPreferences sp;

  //Users
  Future<bool> registerUser(String name,String studentid,String mobile,String email,String password,int department,File image) async{
    var fileContent = image.readAsBytesSync();
    var base64image = base64.encode(fileContent);
    var response;
    //print(name+""+studentid+" "+mobile+" "+email+" "+password+" "+department+" "+semester+" "+base64image);
    try{
      FormData formData = new FormData.fromMap(<String, dynamic>{
        "name" : name,
        "studentid" : studentid,
        "mobile" : mobile,
        "email" : email,
        "password" : password,
        "department" : department,
        //"semester" : semester,
        "image" : base64image
       });
      response = await dio.post(postURL, data: formData);
      print(response);
      }catch (e){
        print(e);
     }
     if(response.toString().contains("data saved with image") || response.toString().contains("data saved without image")){
        return true;
      }else{
        return false;
      }
  }

  Future<bool> registerCounciller(String name,String studentid,String mobile,String email,String password,int department,File image) async{
    var fileContent = image.readAsBytesSync();
    var base64image = base64.encode(fileContent);
    var response;
    //print(name+""+studentid+" "+mobile+" "+email+" "+password+" "+department+" "+semester+" "+base64image);
    try{
      FormData formData = new FormData.fromMap(<String, dynamic>{
        "name" : name,
        "studentid" : studentid,
        "mobile" : mobile,
        "email" : email,
        "password" : password,
        "department" : department,
        //"semester" : semester,
        "image" : base64image
       });
      response = await dio.post("http://cms.flatbasha.com/registerCounciller", data: formData);
      }catch (e){
        print(e);
     }
     if(response.toString().contains("data saved with image") || response.toString().contains("data saved without image")){
        return true;
      }else{
        return false;
      }
  }

  Future<bool> logoutUser(int id) async{
      var response = await dio.get("http://cms.flatbasha.com/logoutUser?id=$id");
      if(response.toString().contains("done")){
        return true;
      }else{
        return false;
      }
  }

  Future<bool> updateUserWithImage(int id,String name,String studentid,String mobile,String email,String password,File image) async{
    var fileContent = image.readAsBytesSync();
    var base64image = base64.encode(fileContent);
    var response;
    try{
      FormData formData = new FormData.fromMap(<String, dynamic>{
        "id" : id,
        "name" : name,
        "studentid" : studentid,
        "mobile" : mobile,
        "email" : email,
        "password" : password,
        "image" : base64image
       });
      response = await dio.post("http://cms.flatbasha.com/updateUserWithImage", data: formData);
      }catch (e){
        print(e);
     }
      if(response.toString().contains("data update1")){
        return true;
      }else{
        return false;
      }
  }  

  Future<bool> updateUserWithoutImage(int id,String name,String studentid,String mobile,String email,String password) async{
   var response;
      response = await dio.get("http://cms.flatbasha.com/updateUserWithoutImage?id=$id&name=$name&studentid=$studentid&mobile=$mobile&email=$email&password=$password");
      if(response.toString().contains("data update2")){
        return true;
      }else{
        return false;
      }   
  }

  Future<bool> loginUser(String mobile,String password,ProgressDialog p) async{
    var response = await dio.get("http://cms.flatbasha.com/loginUser?mobile=$mobile&password=$password");
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
}