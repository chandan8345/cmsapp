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
  Future<bool> updateUser() async{

    return true;
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
  Future<bool> logoutUser() async{
    sp=await SharedPreferences.getInstance();
    await sp.clear();
    
    return true;
  }
}