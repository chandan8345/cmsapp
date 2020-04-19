import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';

class OnScreen {
  Dio dio=new Dio();

  Future<List> getActiveUsers(int id)async{
    var response = await dio.get("http://cms.flatbasha.com/getActiveUser?id=$id");
    List result = json.decode(response.toString());
    return result;
  }

  Future<List> getToday(int id,String role)async{
    var response = await dio.get("http://cms.flatbasha.com/getToday?user_id=$id&role=$role");
    List result = json.decode(response.toString());
    return result;
  }

  Future<List> getWaiting(int id,String role)async{
    var response = await dio.get("http://cms.flatbasha.com/getWaiting?user_id=$id&role=$role");
    List result = json.decode(response.toString());
    return result; 
  }

  Future<List> getPending(int id,String role)async{
    var response = await dio.get("http://cms.flatbasha.com/getPending?user_id=$id&role=$role");
    List result = json.decode(response.toString());
    return result;
  }

  Future<List> getSettled(int id,String role)async{
    var response = await dio.get("http://cms.flatbasha.com/getSettled?user_id=$id&role=$role");
    List result = json.decode(response.toString());
    return result;
  }
}