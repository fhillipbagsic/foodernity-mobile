import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:my_app/Pages/Account/numeric_pad_forgotPass.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/Pages/Account/confirmNewPass.dart';

String code = "";

class ChangePasswordCode extends StatefulWidget {
  const ChangePasswordCode({Key key}) : super(key: key);

  @override
  _ChangePasswordCodeState createState() => _ChangePasswordCodeState();
}

class _ChangePasswordCodeState extends State<ChangePasswordCode> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          home: Design(),
        );
      },
    );
  }
}

void checkCode(context) async {
  final prefs = await SharedPreferences.getInstance();
  var fpcode = prefs.getString('fpcode');
  if (code == fpcode) {
    //goods
    print("the fpcode and user input code matched");
    Navigator.push(context, MaterialPageRoute(builder: (context) => NewPass()));
  } else {
    print("the fpcode and user input code did not matched");
  }
}

class Design extends StatefulWidget {
  const Design({Key key}) : super(key: key);

  @override
  _DesignState createState() => _DesignState();
}

class _DesignState extends State<Design> {
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
                'Enter Code to Change Password',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: ElevatedButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            'Verify and ChangePassword',
                            style: TextStyle(fontSize: 13.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () {
                          print(code);
                          if (code.length == 6) {
                            checkCode(context);
                          } else {
                            print("Please complete the code.");
                          }
                        },
                      ),
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
