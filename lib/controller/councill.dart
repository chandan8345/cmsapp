import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class Councill{
  Dio dio=new Dio();
  
    Future<String> createCouncill(String reason,int categoryid,int semesterid,int departmentid,int councillerid,int postingUser,DateTime meetingDate)async{
      var teacher= await dio.get("http://flatbasha.com/getTeacher?id=$councillerid");
      List t=json.decode(teacher.toString());
      var student=await dio.get("http://flatbasha.com/getStudent?id=$postingUser");
      List s=json.decode(student.toString());
      String st=s[0]['name'];String tc=t[0]['name'];
      var response = await dio.get("http://flatbasha.com/createCouncilling?reason=$reason&categoryid=$categoryid&postinguserid=$postingUser&councillerid=$councillerid&meetingdate=$meetingDate&semesterid=$semesterid&departmentid=$departmentid&teacher=$tc&student=$st");
    return response.toString();
    }

    Future acceptCouncill(String comments,String room,DateTime meeting,int councillerId,int postId)async{
      var response =await dio.get("http://flatbasha.com/acceptCouncilling?room=$room&comments=$comments&meetingdate=$meeting&councillerid=$councillerId&postId=$postId");
      return response.toString();
    }

    Future referredCouncill(String comments,int refferedId,int postId) async{
      var teacher= await dio.get("http://flatbasha.com/getTeacher?id=$refferedId");
      List s=json.decode(teacher.toString());
      String teach=s[0]['name'];
      var response =await dio.get("http://flatbasha.com/refferedCouncilling?comments=$comments&refferedid=$refferedId&postId=$postId&teacher=$teach");
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