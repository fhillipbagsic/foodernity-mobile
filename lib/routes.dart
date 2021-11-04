import 'package:flutter/widgets.dart';
import 'package:my_app/Pages/Home/FrequentlyAsk.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:my_app/Pages/Account/ForgotPassword.dart';
import 'package:my_app/Pages/Account/Signin.dart';
import 'package:my_app/Pages/Account/Signup.dart';
import 'package:my_app/Guidelines/AddListingGuidelines.dart';
import 'package:my_app/Pages/RecentDonationDetails.dart';
import 'package:my_app/Pages/PostDonation/PostDonation.dart';
import 'package:my_app/Pages/RequestDonation.dart';
import 'package:my_app/Pages/RequestGuidelines.dart';
import 'package:my_app/Pages/splash/splash_screen.dart';
import 'package:my_app/Pages/DonationDetails.dart';
import 'package:my_app/Pages/Home/Listings.dart';
import 'package:my_app/Pages/RequestListingDetails.dart';
import 'package:my_app/Pages/RequestDonationSummary.dart';
import 'package:my_app/Pages/PostDonation/verification.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  Signin.routeName: (context) => Signin(),
  Signup.routeName: (context) => Signup(),
  Home.routeName: (context) => Home(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
  AddListing.routeName: (context) => AddListing(),
  PostDonation.routeName: (context) => PostDonation(),
  PostDonationSummary.routeName: (context) => PostDonationSummary(),
  ListingDetails.routeName: (context) => ListingDetails(),
  Listings.routeName: (context) => Listings(),
  RequestDonation.routeName: (context) => RequestDonation(),
  RequestGuidelines.routeName: (context) => RequestGuidelines(),
  FrequentlyAsk.routeName: (context) => FrequentlyAsk(),
  RequestDetails.routeName: (context) => RequestDetails(),
  RequestSummary.routeName: (context) => RequestSummary(),
  Verification.routeName: (context) => Verification()
};
