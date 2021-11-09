import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Announcement/announcement.dart';
import 'package:my_app/Pages/CallForDonation/call_for_donations.dart';
import 'package:my_app/Pages/MyProfile/profile_page.dart';
import 'package:my_app/Pages/Notifications/notifications.dart';

class Home extends StatefulWidget {
  static String routeName = "/Home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlaceholderWidget(Notifications()),
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
                icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket_rounded),
                label: 'Announcements'),
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
