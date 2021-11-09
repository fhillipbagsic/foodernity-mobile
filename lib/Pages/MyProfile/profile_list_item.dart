import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 30;
    var height = MediaQuery.of(context).size.height / 10.5;
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ).copyWith(
        bottom: 8,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: _getColor(text),
                borderRadius: BorderRadius.circular(30)),
            child: Icon(
              this.icon,
              size: 25,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20),
          Text(
            this.text,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(17),
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: 25,
            ),
        ],
      ),
    );
  }
}

Color _getColor(String text) {
  switch (text) {
    case 'View My Donations':
      return Colors.blue;
    case 'Edit Profile':
      return Colors.green;
    case 'Frequently Asked Questions':
      return Colors.orange;
    case 'Logout':
      return Colors.red;
  }
  return Colors.green;
}
