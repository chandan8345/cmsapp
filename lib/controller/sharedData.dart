import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedData{
SharedPreferences sp;

  Future setUserData(List user)async{
    sp=await SharedPreferences.getInstance();
    sp.setInt('id', int.parse(user[0]['id']));
    sp.setString('name', user[0]['name']);
    sp.setString('mobile', user[0]['mobile']);
    sp.setString('email', user[0]['email']);
    sp.setString('password', user[0]['password']);
    sp.setString('role', user[0]['role']);
    sp.setString('studentid', user[0]['studentid']);
    sp.setInt('departmentid', int.parse(user[0]['departmentid']));
    print('sucess store');
  }

  Future getUserData()async{
    sp=await SharedPreferences.getInstance();
    Map<String,String> user= Map();
    user['id']=sp.getInt('id').toString();
    user['name']=sp.getString('name').toString();
    user['studentid']=sp.getString('studentid').toString();
    user['mobile']=sp.getString('mobile').toString();
    user['email']=sp.getString('email').toString();
    user['role']=sp.getString('role').toString();
    user['password']=sp.getString('password').toString();
    user['department']=sp.getInt('departmentid').toString();
    return user;
  }
  Future sessionOut()async{
    sp=await SharedPreferences.getInstance();
    sp.clear();
  }

}