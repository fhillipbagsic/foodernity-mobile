import 'package:flutter/material.dart';
import 'package:my_app/Pages/AddListing.dart';
import 'package:my_app/Pages/FAQs.dart';
import 'package:my_app/Pages/Account/ForgotPassword.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:my_app/Pages/Home/Listings.dart';
import 'package:my_app/Pages/Account/Signin.dart';
import 'package:my_app/Pages/Account/Signup.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    routes: {'/faqs': (context) => FAQs()},
  ));
}
