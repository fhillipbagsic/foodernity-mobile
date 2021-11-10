import 'package:flutter/material.dart';
import 'package:my_app/Pages/Account/signin.dart';
import 'package:my_app/Pages/PostDonation/numeric_pad.dart';
import 'package:sizer/sizer.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:my_app/Pages/Account/signup.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:my_app/Pages/PostDonation/verify_success.dart';

class Verification extends StatefulWidget {
  static String routeName = "/verification";
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          home: App(),
        );
      },
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Verify Email Address',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/email.png',
                width: 35.w,
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return NumericPad(
                          onNumberSelected: (value) {
                            print(value);
                            setState(() {
                              if (value != -1) {
                                if (code.length < 6) {
                                  code = code + value.toString();
                                }
                              } else {
                                code = code.substring(0, code.length - 1);
                              }
                              print(code);
                            });
                          },
                        );
                      });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildCodeNumberBox(
                        code.length > 0 ? code.substring(0, 1) : ""),
                    buildCodeNumberBox(
                        code.length > 1 ? code.substring(1, 2) : ""),
                    buildCodeNumberBox(
                        code.length > 2 ? code.substring(2, 3) : ""),
                    buildCodeNumberBox(
                        code.length > 3 ? code.substring(3, 4) : ""),
                    buildCodeNumberBox(
                        code.length > 4 ? code.substring(4, 5) : ""),
                    buildCodeNumberBox(
                        code.length > 5 ? code.substring(5, 6) : ""),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'A verification code is sent to your email address.',
                style: TextStyle(
                    color: Color.fromRGBO(129, 129, 129, 1), fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'Verify',
                          style: TextStyle(fontSize: 13.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () async {
                        DBCrypt dBCrypt = DBCrypt();
                        final prefs = await SharedPreferences.getInstance();

                        var vcode = await prefs.getString('vc');
                        print(vcode);

                        var result = dBCrypt.checkpw(code, vcode);
                        print(result);
                        if (result == true) {
                          verify();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifySuccess()));
                        } else {
                          print('result is false');
                          showError(context);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCodeNumberBox(String codeNumber) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: SizedBox(
      width: 5.h,
      height: 6.h,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(245, 245, 245, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10),
                blurRadius: 4.0,
                spreadRadius: 0,
                offset: Offset(0, 4))
          ],
        ),
        child: Center(
          child: Text(
            codeNumber,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F1F1F),
            ),
          ),
        ),
      ),
    ),
  );
}

void verify() async {
  var formatter = DateFormat('MM/dd/yyyy');
  String now = formatter.format(new DateTime.now());
  http.Response response =
      await http.post("https://foodernity.herokuapp.com/signup/verify",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': Email,
            'password': Password,
            'fullName': fullName,
            'dateOfReg': now,
            'loginMethod': 'default',
            'userType': 'user',
            'userStatus': 'active',
          }));
  print(response.body);
}

Widget showError(BuildContext context) {
  // set up the buttons
  Widget continueButton = FlatButton(
    child: Text(
      "Close",
      style: TextStyle(color: Colors.blue),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Row(
      children: [
        Text("Verification Error", style: TextStyle(color: Colors.redAccent)),
      ],
    ),
    content: Text(
      "Invalid code please try again",
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      continueButton,
    ],
    backgroundColor: Colors.white,
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
