import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

class Others{
   Dio dio=new Dio();
   var cr;
   
   Future getCounciller(int id)async{
    var response = await dio.get("http://cms.flatbasha.com/getCounciller?id=$id");
    List counciller = json.decode(response.toString());
    return counciller;
   }
  Future getDepartment()async{
    var response = await dio.get("http://cms.flatbasha.com/getDepartment");
    List department = json.decode(response.toString());
    return department;
   }
  Future getSemester()async{
    var response = await dio.get("http://cms.flatbasha.com/getSemester");
    List semester = json.decode(response.toString());
    return semester;
   }
  Future getCategory()async{
    var response = await dio.get("http://cms.flatbasha.com/getCategory");
    List category = json.decode(response.toString());
    return category;
   }

   Future<bool> checkConection() async{
    try{
      cr = await (Connectivity().checkConnectivity());
        if (cr == ConnectivityResult.none) {
          return false;
        }if(cr== ConnectivityResult.wifi){
          return true;
        }if(cr == ConnectivityResult.mobile){
          return true;
        }
    }catch(e){
      print(e.toString());
    }
  }
}