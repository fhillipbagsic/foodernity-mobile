import 'package:flutter/material.dart';
import 'package:my_app/Models/AppNotification.dart';
import 'package:sizer/sizer.dart';

class NotificationItem extends StatelessWidget {
  final AppNotification notification;

  const NotificationItem({this.notification});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
        child: Row(
          children: [
            _icon(notification.notificationMessage),
            SizedBox(
              width: 15.0,
            ),
            _description(notification.notificationMessage)
          ],
        ),
      );
    });
  }
}

Widget _icon(String notificationMessage) {
  Icon icon;
  Color bgColor;
  List words = notificationMessage.split(' ');

  if (words[words.length - 1] == 'you!') {
    icon = Icon(
      Icons.done_all_rounded,
      color: Colors.green,
    );
    bgColor = Colors.green[100];
  } else {
    icon = Icon(
      Icons.inventory,
      color: Colors.blue,
    );
    bgColor = Colors.blue[100];
  }

  return Container(
    padding: EdgeInsets.all(17.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0), color: bgColor),
    child: icon,
  );
}

Widget _description(String notificationMessage) {
  String title = '';
  Color color;

  List words = notificationMessage.split(' ');

  if (words[words.length - 1] == 'donating!') {
    title = 'Donation Received';
    color = Colors.blue;
  } else {
    title = 'Donation Accepted';
    color = Colors.green;
  }

  return Expanded(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 13.sp, fontWeight: FontWeight.bold, color: color),
      ),
      SizedBox(
        height: 5,
      ),
      Text(notificationMessage)
    ],
  ));
}
