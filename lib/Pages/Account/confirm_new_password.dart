import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/Pages/Account/signin.dart';

var _newpassController = TextEditingController();
var _confirmNewPass = TextEditingController();
GlobalKey<FormState> _homeKey = GlobalKey<FormState>();

class NewPass extends StatelessWidget {
  const NewPass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _homeKey,
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
                _newPassTextField(),
                SizedBox(
                  height: 20.0,
                ),
                _confirmPassTextfield(),
                SizedBox(
                  height: 50.0,
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
  return Align(
    alignment: Alignment.topCenter,
    child: (Text(
      'Enter your New Password',
      style: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue),
    )),
  );
}

Widget _description() {
  return Align(
    alignment: Alignment.topCenter,
    child: (Text(
      'Enter new password to access your account',
      style: TextStyle(color: Colors.grey),
    )),
  );
}

Widget _newPassTextField() {
  return (TextFormField(
    obscureText: true,
    validator: passwordValidator,
    controller: _newpassController,
    decoration: InputDecoration(
        border: OutlineInputBorder(), labelText: 'Enter new password'),
  ));
}

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'^[a-zA-Z0-9]+$',
      errorText: 'passwords must not have special character')
]);

Widget _confirmPassTextfield() {
  return (TextFormField(
    obscureText: true,
    validator: (String value) {
      if (value.isEmpty) {
        return 'Need to re-type password for confirmation';
      } else if (value != _newpassController.text) {
        return 'Password and confirm password does not match';
      }
      return null;
    },
    controller: _confirmNewPass,
    decoration: InputDecoration(
        border: OutlineInputBorder(), labelText: 'Confirm password'),
  ));
}

void updatePassword(context) async {
  final prefs = await SharedPreferences.getInstance();

  var email = prefs.getString('fpemail');
  if (_confirmNewPass.text != _newpassController.text) {
    print("Password and confirm password does not match");
  } else {
    http.Response response = await http.post(
        "https://foodernity.herokuapp.com/forgotPassword/updatePassword",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': _newpassController.text,
        }));

    print(response.body);
    successfulPassUpdate(context);
    //password update popup here
  }
}

Widget _sendButton(context) {
  return (ElevatedButton(
    onPressed: () {
      if (!_homeKey.currentState.validate()) {
        return;
      }
      updatePassword(context);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => ChangePasswordCode()));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('SUBMIT')],
    ),
  ));
}

void successfulPassUpdate(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Password updated successfully! ',
          style: TextStyle(color: Colors.greenAccent)),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signin()));
            //   Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text("Proceed to Sing In"),
        ),
      ],
    ),
  );
}
