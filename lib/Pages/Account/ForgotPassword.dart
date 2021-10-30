import 'package:flutter/material.dart';
import 'package:my_app/Pages/Account/enterCode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var _emailController = TextEditingController();

class ForgotPassword extends StatelessWidget {
  static String routeName = "/ForgotPass";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120.0,
              ),
              _title(),
              SizedBox(
                height: 10.0,
              ),
              _description(),
              SizedBox(
                height: 30.0,
              ),
              _phoneNumberField(),
              SizedBox(
                height: 30.0,
              ),
              _sendButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _title() {
  return (Text(
    'Reset your password',
    style: TextStyle(
        fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue),
  ));
}

Widget _description() {
  return (Text(
    'Enter the Email associated with your account and we\'ll send a code with instructions to reset your password.',
    style: TextStyle(color: Colors.grey),
  ));
}

Widget _phoneNumberField() {
  return (TextField(
    controller: _emailController,
    decoration: InputDecoration(
        border: OutlineInputBorder(), labelText: 'Email'),
  ));
}

bool isValid(){
  if(_emailController.text.length!=0){
    return true;
  }else{
    return false;
  }
}

void getCode()async{
  final prefs = await SharedPreferences.getInstance();
  http.Response response = await http.post(
      "https://foodernity.herokuapp.com/forgotPassword/getChangePasswordCode",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
      }));

  print(response.body);
  prefs.setString('fpemail', _emailController.text);
  prefs.setString('fpcode', response.body);
}

Widget _sendButton(context) {
  return (ElevatedButton(
    onPressed: () {

      //func
        if(isValid()){
          //goods
          getCode();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChangePasswordCode()),);
        }else{
          print("Email field cannot be empty");
        }





    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('SEND CODE')],
    ),
  ));
}
