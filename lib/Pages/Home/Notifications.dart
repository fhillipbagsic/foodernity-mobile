import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:my_app/Widgets/NavigationBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // endDrawer: AccountDrawer(),
      key: scaffoldKey,
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [appBar(context), NotificationCount()],
        ),
      ),
    );
  }
}

Widget appBar(context) {
  return SliverToBoxAdapter(
      child: CupertinoNavigationBar(
    leading: CupertinoNavigationBarBackButton(
      color: Colors.black,
      onPressed: () => Navigator.pop(context),
    ),
    transitionBetweenRoutes: true,
    middle: Text('Notifications'),
  ));
}

class NotificationCount extends StatefulWidget {
  const NotificationCount({Key key}) : super(key: key);

  @override
  _NotificationCountState createState() => _NotificationCountState();
}

class _NotificationCountState extends State<NotificationCount> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 11.2;
    final double itemWidth = size.width - 1;

    return SliverPadding(
      padding: EdgeInsets.only(top: 20.0),
      sliver: (SliverGrid.count(
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        crossAxisCount: 1,
        children: [
          _buildNotification(
              // 'https://cf.shopee.com.my/file/090a18a75c04ad1d4e0f63421a5c8651',
              'Pancit Canton',
              'The foodbank accepted your donation'),
          _buildNotification(
              // 'https://cf.shopee.com.my/file/090a18a75c04ad1d4e0f63421a5c8651',
              'Pancit Canton',
              'The foodbank accepted your donation'),
          _buildNotification(
              // 'https://cf.shopee.com.my/file/090a18a75c04ad1d4e0f63421a5c8651',
              'Bread',
              'The foodbank accepted your donation'),
        ],
      )),
    );
  }
}

Widget _buildNotification(title, description) {
  // var notifImage = image;
  var notifTitle = title;
  var notifDesc = description;
  return Sizer(
    builder: (context, orientation, deviceType) {
      return Container(
        // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: ClipOval(
                  child: Container(
                    child: Image.asset(
                      'assets/images/email_open.png',
                      color: Colors.grey[400],
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(notifTitle,
                    style: TextStyle(
                        // fontFamily: 'roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
                subtitle: Text(notifDesc,
                    style: TextStyle(
                        // fontFamily: 'RobotoMono-Regular',
                        fontWeight: FontWeight.normal,
                        fontSize: 13.0,
                        color: Colors.black)),
              ),
            ],
          ),
        ),
      );
    },
  );
}
