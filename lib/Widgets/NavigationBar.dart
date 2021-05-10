import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/AddListing.dart';
import 'package:my_app/Pages/FAQs.dart';
import 'package:my_app/Pages/Guidelines.dart';
import 'package:my_app/styles.dart';

class NavigationBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  final String title;
  NavigationBar({this.title, this.scaffold});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      automaticallyImplyLeading: false,
      largeTitle: Text(widget.title),
      trailing: _avatar(widget.scaffold),
    );
  }
}

Widget _avatar(scaffold) {
  return GestureDetector(
    onTap: () {
      scaffold.currentState.openEndDrawer();
    },
    child: CircleAvatar(
      backgroundColor: ColorPrimary,
      child: Text('FB'),
    ),
  );
}

class AccountDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   child: Text('FB'),
                // ),
                // Text(
                //   'Fhillip Bagsic',
                //   style: TextStyle(fontSize: 18.0, color: Colors.white),
                // ),
                // RichText(
                //     text: TextSpan(children: [
                //   WidgetSpan(
                //       child: Icon(
                //     Icons.star_rate_rounded,
                //     size: 18.0,
                //     color: Colors.orange[300],
                //   )),
                //   TextSpan(text: '5.0')
                // ]))
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddListing()));
            },
            leading: Icon(Icons.message),
            title: Text('Frequently Asked Questions'),
          ),
        ],
      ),
    );
  }
}

class NavigationBar2 extends StatelessWidget {
  final String title;
  NavigationBar2({this.title});
  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(title),
    );
  }
}
