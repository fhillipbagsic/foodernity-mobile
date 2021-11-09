import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/AppNotification.dart';
import 'package:my_app/Pages/Notifications/notification_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<AppNotification>> futureNotifications;

  @override
  void initState() {
    super.initState();
    futureNotifications = getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // endDrawer: AccountDrawer(),
      key: scaffoldKey,
      body: SafeArea(
          child: Container(
        color: Colors.grey[100],
        child: FutureBuilder(
          future: futureNotifications,
          builder: (context, snapshot) {
            Widget notificationsSliverList;

            if (snapshot.hasData) {
              notificationsSliverList = SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return NotificationItem(notification: snapshot.data[index]);
                }, childCount: snapshot.data.length),
              );
            } else {
              notificationsSliverList = SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            return CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  automaticallyImplyLeading: false,
                  largeTitle: Text('Notifications'),
                ),
                notificationsSliverList
              ],
            );
          },
        ),
      )),
    );
  }
}

Future<List<AppNotification>> getNotifications() async {
  final prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  final response =
      await http.post("https://foodernity.herokuapp.com/notif/getNotifsFor",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'donorEmail': email,
          }));

  List<AppNotification> parsedNotifications = [];

  if (response.statusCode == 200) {
    List notifications = jsonDecode(response.body);

    for (var notification in notifications) {
      parsedNotifications.add(AppNotification.fromJSON(notification));
    }
  }

  return parsedNotifications;
}
