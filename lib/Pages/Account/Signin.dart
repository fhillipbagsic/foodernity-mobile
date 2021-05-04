import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          width: width,
          child: Column(
            children: [
              Text('Sign in to Foodernity'),
              phoneNumberField(),
              passwordField(),
              forgotPassword(),
              signinButton(),
              Text('or'),
              googleButton(),
              noAccount(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget phoneNumberField() {
  return (TextField(
    decoration: InputDecoration(
        border: OutlineInputBorder(), labelText: 'Phone Number'),
  ));
}

Widget passwordField() {
  return (TextField(
    decoration:
        InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
  ));
}

Widget forgotPassword() {
  return (Align(
    alignment: Alignment.centerRight,
    child: Text('Forgot Password?'),
  ));
}

Widget signinButton() {
  return (ElevatedButton(
    onPressed: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('SIGN IN')],
    ),
  ));
}

Widget googleButton() {
  return (OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.google),
          SizedBox(
            width: 10.0,
          ),
          Text('SIGN IN WITH GOOGLE')
        ],
      )));
}

Widget noAccount() {
  return (Text('No account yet? Sign up here'));
}
