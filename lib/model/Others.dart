import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';

class Others{
   Dio dio=new Dio();
   
   Future getCounciller()async{

   }
   Future getCouncillingType()async{

   }
  Future getDepartment()async{
    var response = await dio.get("http://flatbasha.com/getDepartment");
    List department = json.decode(response.toString());
    return department;
   }
  Future getSemester()async{
    var response = await dio.get("http://flatbasha.com/getSemester");
    List semester = json.decode(response.toString());
    return semester;
   }
}