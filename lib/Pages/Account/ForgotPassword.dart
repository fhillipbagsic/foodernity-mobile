import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  static String routeName = "/ForgotPass";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _sendButton(),
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
    'Enter the phone number associated with your account and we\'ll send a code with instructions to reset your password.',
    style: TextStyle(color: Colors.grey),
  ));
}

Widget _phoneNumberField() {
  return (TextField(
    decoration: InputDecoration(
        border: OutlineInputBorder(), labelText: 'Phone Number'),
  ));
}

Widget _sendButton() {
  return (ElevatedButton(
    onPressed: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('SEND CODE')],
    ),
  ));
}
