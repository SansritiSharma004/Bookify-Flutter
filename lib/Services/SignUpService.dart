import 'dart:convert';
import 'package:bookify/Services/GlobalVars.dart';
import 'package:http/http.dart' as http;

class SignUpService{
  Future<int> signup(String _name, String _email, String _password) async{
    var user = {"email" : _email, "password" : _password, "name" : _name};
    print(jsonEncode(user));

    var url = Uri.http(localhost, "/users/signup");

    var response = await http.post(url, headers: {
      'Content-Type' : 'application/json'
    },
      body: jsonEncode(user),
    );

    if(response.statusCode == 200){
      print("Successfully Signed Up.");
      return 200;
    }

    else if(response.statusCode == 406){
      print("email already exists.");
      return 406;
    }

    else{
      print("network error");
      return -1;
    }


  }
}