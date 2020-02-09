import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';

class OnScreen {
  Dio dio=new Dio();

  Future<List> getToday(int id)async{
    var response = await dio.get("http://flatbasha.com/getToday?user_id=$id");
    List result = json.decode(response.toString());
    return result;
  }

  Future<List> getWaiting(int id)async{
    var response = await dio.get("http://flatbasha.com/getWaiting?user_id=$id");
    List result = json.decode(response.toString());
    print(result);
    return result; 
  }

  Future<List> getPending(int id)async{
    var response = await dio.get("http://flatbasha.com/getPending?user_id=$id");
    List result = json.decode(response.toString());
    print(result);
    return result;
  }

  Future<List> getSettled(int id)async{
    var response = await dio.get("http://flatbasha.com/getSettled?user_id=$id");
    List result = json.decode(response.toString());
    return result;
  }
}