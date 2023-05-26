
import 'dart:convert';

import 'package:today_my_school/data/user.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';

class DatabaseServices{
  void signUpUser(String name,String email,String password,String phoneNum,String uuid)async{
    Map data={
      "name":name,
      "email":email,
      "password":password,
      "phoneNum":phoneNum,
      "uuid":uuid
    };
    var body=json.encode(data);
    var url=Uri.parse(baseURL+'/users/signup');

    http.Response response=await http.post(
      url,
      headers: headers,
      body: body,
    );
    Map responeMap=jsonDecode(response.body);
    User user=User.fromMap(responeMap);
    //return user;
  }

  void updateUser(String uuid,String name,String email,String phoneNum)async{
    Map data={
      "uuid":uuid,
      "name":name,
      "email":email,
      "phoneNum":phoneNum,
    };
    var body=json.encode(data);
    var url=Uri.parse(baseURL+'/users/update');

    http.Response response=await http.put(
      url,
      headers: headers,
      body: body,
    );
    // Map responeMap=jsonDecode(response.body);
    // User user=User.fromMap(responeMap);
    //return user;
  }

  static Future<List<User>>getUsers()async{
    var url=Uri.parse(baseURL+'/users');
    http.Response response=await http.get(
      url,
      headers: headers,
    );
    List userList=jsonDecode(response.body);
    List<User>users=[];
    for(Map userMap in userList){
      User user=User.fromMap(userMap);
      users.add(user);
    }
    return users;
  }
}