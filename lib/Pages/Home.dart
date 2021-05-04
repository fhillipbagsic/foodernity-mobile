import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Account.dart';
import 'package:my_app/Pages/Forum.dart';
import 'package:my_app/Pages/Listings.dart';
import 'package:my_app/Pages/Messages.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlaceholderWidget(Listings()),
    PlaceholderWidget(Messages()),
    PlaceholderWidget(Forum()),
    PlaceholderWidget(Account())
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
                icon: Icon(Icons.shopping_basket_rounded), label: 'Donations'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded), label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_answer_rounded), label: 'Forum'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Account'),
          ],
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
