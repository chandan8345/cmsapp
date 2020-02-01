import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';

class OnScreen {
  Dio dio=new Dio();

  Future getToday(int id)async{
    var response = await dio.get("http://flatbasha.com/getToday?user_id=$id");
    List result = json.decode(response.toString());
    return result;
  }

  Future getWaiting(int id)async{
    var response = await dio.get("http://flatbasha.com/getWaiting?user_id=$id");
    List result = json.decode(response.toString());
    return result;
  }

  Future getPending(int id)async{
    var response = await dio.get("http://flatbasha.com/getPending?user_id=$id");
    List result = json.decode(response.toString());
    return result;
  }

  Future getSettled(int id)async{
    var response = await dio.get("http://flatbasha.com/getSettled?user_id=$id");
    List result = json.decode(response.toString());
    return result;
  }
}