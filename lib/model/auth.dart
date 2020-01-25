import 'dart:convert';
import 'dart:async';
import 'package:cms/model/sharedData.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Auth{
  Dio dio=new Dio();
  SharedData sharedData=new SharedData();
  //Users
  Future<bool> registerUser() async{

    return true;
  }
  Future<bool> updateUser() async{

    return true;
  }
  Future<bool> loginUser(String mobile,String password,ProgressDialog p) async{
    var response = await dio.get("http://flatbasha.com/loginUser?mobile=$mobile&password=$password");
    if(response.data.toString().length > 2){
    List user = json.decode(response.toString());
    sharedData.setUserData(user);
    p.hide();
    return true;
    }else{ 
    p.hide();
    return false;
    }
  }
  Future<bool> logoutUser() async{
    sharedData.sessionOut();
    return true;
  }
  
}