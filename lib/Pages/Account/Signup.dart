import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                height: height / 6,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Sign up to Foodernity',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
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
                  padding: EdgeInsets.only(top: 70.0, right: 30.0, left: 30.0),
                  child: Column(
                    children: [
                      _nameField(width),
                      SizedBox(
                        height: 20.0,
                      ),
                      _phoneNumberField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _passwordField(),
                      _passwordHelper(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _confirmPasswordField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _agreement(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _signupButton(),
                      SizedBox(height: 10.0,),
                      Text('or', style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 10.0,),
                      _googleButton(),
                      SizedBox(
                        height: 50.0,
                      ),
                      _hasAccount()
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

Widget _nameField(width) {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [_firstNameField(width), _lastNameField(width)],
  ));
}

Widget _firstNameField(width) {
  return Container(
    width: width / 2.4,
    child: (TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(), labelText: 'First Name'),
    )),
  );
}

Widget _lastNameField(width) {
  return Container(
    width: width / 2.4,
    child: (TextField(
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: 'Last Name'),
    )),
  );
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

Widget _passwordHelper() {
  return Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Must be at least 8 characters',
        style: TextStyle(color: Colors.grey),
      ));
}

Widget _confirmPasswordField() {
  return (TextField(
    decoration: InputDecoration(
        border: OutlineInputBorder(), labelText: 'Confirm Password'),
  ));
}

Widget _agreement() {
  return (RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'By creating an account, you accept our ',
        style: TextStyle(color: Colors.grey),
        children: [
          TextSpan(
              text: 'Terms of Service',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: ', ',
              style: TextStyle(color: Colors.grey),
          ),
          TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: ', and our default ',
              style: TextStyle(color: Colors.grey),
          ),
          TextSpan(
              text: 'Notification Settings.',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ]),
  ));
}

Widget _signupButton() {
  return (ElevatedButton(
    onPressed: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('SIGN UP')],
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
          Text('SIGN UP WITH GOOGLE', style: TextStyle(color: Colors.grey),)
        ],
      )));
}
Widget _hasAccount() {
  return (
    RichText(
      text: TextSpan(
        text: 'Already have an account? ',style: TextStyle(color: Colors.grey),
        children: [
          TextSpan(text: 'Sign in here', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold))
        ]
      ),)
  );
}