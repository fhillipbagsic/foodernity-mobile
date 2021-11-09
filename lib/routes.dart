import 'package:flutter/widgets.dart';
import 'package:my_app/Pages/Announcement/FrequentlyAsk.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:my_app/Pages/Account/forgot_password.dart';
import 'package:my_app/Pages/Account/signin.dart';
import 'package:my_app/Pages/Account/signup.dart';
import 'package:my_app/Guidelines/AddListingGuidelines.dart';
import 'package:my_app/Pages/Announcement/announcement_detail.dart';
import 'package:my_app/Pages/PostDonation/post_donation.dart';
import 'package:my_app/Pages/RequestGuidelines.dart';
import 'package:my_app/Pages/splash/splash_screen.dart';
import 'package:my_app/Pages/DonationDetails.dart';
import 'package:my_app/Pages/Announcement/announcement.dart';
import 'package:my_app/Pages/RequestListingDetails.dart';
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
  RequestGuidelines.routeName: (context) => RequestGuidelines(),
  FrequentlyAsk.routeName: (context) => FrequentlyAsk(),
  RequestDetails.routeName: (context) => RequestDetails(),
  Verification.routeName: (context) => Verification()
};
