import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:my_app/Pages/Account/Signup.dart';
import 'package:my_app/Pages/Account/enterCode.dart';
import 'package:my_app/Pages/Home/Listings.dart';
import 'package:my_app/Pages/Home/Notifications.dart';
import 'package:my_app/Pages/PostDonation/PostDonation.dart';
import 'package:my_app/Pages/splash/components/body.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:my_app/Pages/Account/Signin.dart';
import 'package:my_app/Pages/Account/Signin.dart';
import 'package:my_app/Pages/Account/ForgotPassword.dart';
import 'package:my_app/Pages/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_app/Pages/DonationDetails.dart';
import 'package:my_app/Pages/RecentDonationDetails.dart';
import 'package:my_app/NavigationPages/Listed.dart';
import 'package:my_app/Pages/Home/CallForDonations.dart';
import 'package:my_app/NavigationPages/ReceivedDonations.dart';
import 'package:my_app/NavigationPages/RequestedDonation.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:my_app/Pages/AccountPage/profilepage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'Pages/PostDonation/step_three.dart';
import 'Pages/PostDonation/verification.dart';
import 'Pages/AccountPage/EditProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

var isLoggedInVar = false;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternet = false;

  void initState() {
    super.initState();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet);

      print(hasInternet);

      if (hasInternet) {
        // Navigator.pop(context, false);
        print('Connected to internet');
      } else {
        print('No internet');
        _showdialog(context);
      }
    });
    isLoggedIn();
  }

  void isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("userID");
    if (userID != null) {
      isLoggedInVar = true;
    } else {
      isLoggedInVar = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      title: 'Foodernity',
      home: isLoggedInVar ? Home() : Signin(),
      routes: routes,
    );
  }

  void _showdialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.wifi_off,
              size: 20.0,
              color: Colors.redAccent,
            ),
            Text('ERROR'),
          ],
        ),
        content: Text(
          "No Internet Detected.",
          style: TextStyle(color: Colors.redAccent),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => SystemNavigator.pop(),
            child: Text("Exit"),
          ),
        ],
      ),
    );
  }
}
