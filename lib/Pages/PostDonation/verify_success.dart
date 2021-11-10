import 'package:flutter/material.dart';
import 'package:my_app/Pages/Account/signin.dart';
import 'package:sizer/sizer.dart';

class VerifySuccess extends StatelessWidget {
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

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Image.asset(
                  'assets/images/verify.png',
                  width: 50.w,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Success!',
                  style:
                      TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Proceed to Sign in to login your account',
                  style: TextStyle(
                      fontSize: 12.sp, color: Color.fromRGBO(111, 111, 111, 1)),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signin()));
                        },
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            'Sign In',
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
