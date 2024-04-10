import 'dart:convert';
import 'package:bookify/Services/GlobalVars.dart';
import 'package:http/http.dart' as http;

class LoginService
{
  Future<int> login(var _Email , var _Password)
  async {

    print(_Email);

    var user = {"email" : _Email , "password" : _Password};
    print(jsonEncode(user));

    var url = Uri.http(localhost, "/users/login");

    var response = await http.post(url,headers: {
      'Content-Type': 'application/json', // Set the Content-Type header
    },body: jsonEncode(user));

    if(response.statusCode==200)
    {

      print("You are Logged in");
      return 200;
    }
    else if(response.statusCode == 404)
    {
      print("No such Email Exist");
      return 404;
    }
    else if(response.statusCode==409)
    {
      print("Wrong Password");
      return 409;
    }
    else
      print("Unexpected Error");
    return -1;

  }
}