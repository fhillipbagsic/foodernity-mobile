import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/styles.dart';

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
              _phoneNumberField(),
              _passwordField(),
              _forgotPassword(),
              _signinButton(),
              Text('or'),
              _googleButton(),
              _noAccount(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _phoneNumberField() {
  return (TextField(
    decoration: InputDecoration(
        border: OutlineInputBorder(), labelText: 'Phone Number'),
  ));
}

Widget _passwordField() {
  return (TextField(
    decoration:
        InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
  ));
}

Widget _forgotPassword() {
  return (Align(
    alignment: Alignment.centerRight,
    child: Text(
      'Forgot Password?',
      style: TextStyle(color: ColorPrimary),
    ),
  ));
}

Widget _signinButton() {
  return (ElevatedButton(
    onPressed: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('SIGN IN')],
    ),
  ));
}

Widget _googleButton() {
  return (OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(side: BorderSide(color: ColorPrimary)),
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

Widget _noAccount() {
  return (Text('No account yet? Sign up here'));
}
