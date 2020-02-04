import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class Councill{
  Dio dio=new Dio();
  
    Future<bool> createCouncill(String reason,int categoryid,int semesterid,int departmentid,int councillerid,int postingUser,DateTime meetingDate)async{
      var response = await dio.get("http://flatbasha.com/createCouncilling?reason=$reason&categoryid=$categoryid&postinguserid=$postingUser&councillerid=$councillerid&meetingdate=$meetingDate&semesterid=$semesterid&departmentid=$departmentid");
      if(response.toString() == "create councill successfuly"){
        return true;
      }else{
        return false;
      }
    }

    Future acceptCouncill()async{}

    Future referredCouncill()async{}

    Future settledCouncill()async{}

    Future removeCouncill()async{}
}