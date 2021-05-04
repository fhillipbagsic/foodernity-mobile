import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/styles.dart';

class NavigationBar extends StatelessWidget {
  final String title;

  NavigationBar({this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(title),
      trailing: _avatar(),
    );
  }
}

Widget _notification() {
  return (Icon(Icons.notifications_rounded));
}

Widget _avatar() {
  return (CircleAvatar(
    backgroundColor: ColorPrimary,
    child: Text('FB'),
  ));
}
