import 'dart:async';
import 'package:dio/dio.dart';

class Councill{
  Dio dio=new Dio();
  
    Future<String> createCouncill(String reason,int categoryid,int semesterid,int departmentid,int councillerid,int postingUser,DateTime meetingDate)async{
      var response = await dio.get("http://flatbasha.com/createCouncilling?reason=$reason&categoryid=$categoryid&postinguserid=$postingUser&councillerid=$councillerid&meetingdate=$meetingDate&semesterid=$semesterid&departmentid=$departmentid");
    return response.toString();
    }

    Future acceptCouncill(String comments,String room,DateTime meeting,int councillerId,int postId)async{
      var response =await dio.get("http://flatbasha.com/acceptCouncilling?room=$room&comments=$comments&meetingdate=$meeting&councillerid=$councillerId&postId=$postId");
      return response.toString();
    }

    Future referredCouncill(String comments,int refferedId,int postId) async{
      var response =await dio.get("http://flatbasha.com/refferedCouncilling?comments=$comments&refferedid=$refferedId&postId=$postId");
      return response.toString();
    }

    Future settledCouncill(String summary,int councillerId,int postId)async{
      var response =await dio.get("http://flatbasha.com/settledCouncilling?solution=$summary&councillerid=$councillerId&postId=$postId");
      return response.toString();
    }

    Future removeCouncill(int postId)async{
      var response =await dio.get("http://flatbasha.com/removePost?id=$postId");
      return response.toString();
    }
}