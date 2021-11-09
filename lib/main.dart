import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:my_app/Pages/Account/signin.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
InitializationSettings initializationSettings;
const MethodChannel platform =
    MethodChannel('dexterous.com/flutter/local_notifications');

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
  return CupertinoAlertDialog(
    title: Text(title),
    content: Text(body),
    actions: <Widget>[
      CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            print("");
          },
          child: Text("Okay")),
    ],
  );
}

Future<void> showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'your channel id', 'channel name', 'channeldescription',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

var isLoggedInVar = false;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasInternet = false;

  void initState() {
    super.initState();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet);

      print(hasInternet);

      if (hasInternet) {
        // Navigator.of(context).pop(true);
        print('Connected to internet');
      } else {
        print('No internet');
        _showdialog(context);
      }
    });
    initializing();
    isLoggedIn();
  }

  void initializing() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
  }

  void isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("userID");
    if (userID != null) {
      isLoggedInVar = true;
    } else {
      isLoggedInVar = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      title: 'Foodernity',
      home: isLoggedInVar ? Home() : Signin(),
      routes: routes,
    );
  }

  void _showdialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.wifi_off,
              size: 20.0,
              color: Colors.redAccent,
            ),
            Text('ERROR'),
          ],
        ),
        content: Text(
          "No Internet Detected.",
          style: TextStyle(color: Colors.redAccent),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => SystemNavigator.pop(),
            child: Text("Exit"),
          ),
        ],
      ),
    );
  }
}
