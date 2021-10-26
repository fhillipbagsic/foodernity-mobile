import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StepThree extends StatelessWidget {
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
                  'assets/images/donations.png',
                  width: 50.w,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Thank You!',
                  style:
                      TextStyle(fontSize: 27.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please wait for the organization to accept your donation. You will be notified once accepted so you can proceed to deliver your donation.',
                  style: TextStyle(
                      fontSize: 12.sp, color: Color.fromRGBO(111, 111, 111, 1)),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            'Go to Home',
                            style: TextStyle(
                                color: Color.fromRGBO(139, 139, 139, 1)),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    ElevatedButton(
                        onPressed: () {},
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            'View My Donations',
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
