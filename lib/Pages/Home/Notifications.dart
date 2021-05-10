import 'package:flutter/material.dart';
import 'package:my_app/Widgets/NavigationBar.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AccountDrawer(),
      key: scaffoldKey,
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            NavigationBar(
              title: 'Notifications',
              scaffold: scaffoldKey,
            )
          ],
        ),
      ),
    );
  }
}
