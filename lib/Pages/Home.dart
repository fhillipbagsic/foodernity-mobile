import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:my_app/Pages/Home/Listings.dart';
import 'package:my_app/Pages/Home/Notifications.dart';
import 'package:my_app/Pages/Home/CallForDonations.dart';
import 'package:my_app/Pages/AccountPage/profilepage.dart';

class Home extends StatefulWidget {
  static String routeName = "/Home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlaceholderWidget(Listings()),
    PlaceholderWidget(RequestListing()),
    PlaceholderWidget(ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: _children[_currentIndex]),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_rounded), label: 'Inventory'),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank), label: 'Call For Donations'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'My Profile'),
          ],
        ));
  }

  void onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Widget widget;

  PlaceholderWidget(this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget,
    );
  }
}
