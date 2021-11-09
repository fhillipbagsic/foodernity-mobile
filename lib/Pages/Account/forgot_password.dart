import 'package:flutter/material.dart';
import 'package:my_app/Pages/Account/signin.dart';
import 'package:my_app/Pages/Account/enter_code.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

var _emailController = TextEditingController();

class ForgotPassword extends StatelessWidget {
  static String routeName = "/ForgotPass";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SafeArea(
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
  return (TextFormField(
    validator: (String value) {
      if (value.isEmpty) {
        return 'Please input email address';
      }
      return null;
    },
    controller: _emailController,
    decoration:
        InputDecoration(border: OutlineInputBorder(), labelText: 'Email'),
  ));
}

bool isValid() {
  if (_emailController.text.length != 0) {
    return true;
  } else {
    return false;
  }
}

void getCode(context) async {
  final prefs = await SharedPreferences.getInstance();
  http.Response response = await http.post(
      "https://foodernity.herokuapp.com/forgotPassword/getChangePasswordCode",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
      }));

  // alertNoAcc(context);
  print(response.body);

  if (response.body == "No existing account.") {
    alertNoAcc(context);
  } else {
    prefs.setString('fpemail', _emailController.text);
    prefs.setString('fpcode', response.body);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordCode()),
    );
  }
}

Widget _sendButton(context) {
  return (ElevatedButton(
    onPressed: () {
      //validation trigger
      if (!_formKey.currentState.validate()) {
        return;
      }
      //func
      if (isValid()) {
        //goods
        getCode(context);
      } else {
        print("Email field cannot be empty");
      }
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('SEND CODE')],
    ),
  ));
}

void alertNoAcc(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Email not exist', style: TextStyle(color: Colors.redAccent)),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            //   Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text("Close"),
        ),
      ],
    ),
  );
}
