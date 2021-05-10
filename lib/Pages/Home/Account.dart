import 'package:flutter/material.dart';
import 'package:my_app/Widgets/NavigationBar.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
              title: 'Account',
              scaffold: scaffoldKey,
            )
          ],
        ),
      ),
    );
  }
}
