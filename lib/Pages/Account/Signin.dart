import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/styles.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              height: height / 3,
              width: double.infinity,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                  'Sign in to Foodernity',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 45.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Container( 
                decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
                padding: EdgeInsets.only(top: 50.0, right: 30.0, left: 30.0),
                
                child: Column(
                  children: [
                    _phoneNumberField(),
                    SizedBox(height: 20.0,),
                    _passwordField(),
                    SizedBox(height: 10.0,),
                    _forgotPassword(),
                    SizedBox(height: 30.0,),
                    _signinButton(),
                    SizedBox(height: 10.0,),
                    Text('or', style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 10.0,),
                    _googleButton(),
                    SizedBox(height: 80.0,),
                    _noAccount(),
                  ],
                ),
              ),
            )
          ],
        )
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
      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.google, color: Colors.grey,),
          SizedBox(
            width: 10.0,
          ),
          Text('SIGN IN WITH GOOGLE', style: TextStyle(color: Colors.grey),)
        ],
      )));
}

Widget _noAccount() {
  return (
    RichText(
      text: TextSpan(
        text: 'No account yet? ',style: TextStyle(color: Colors.grey),
        children: [
          TextSpan(text: 'Sign up here', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))
        ]
      ),)
  );
}
