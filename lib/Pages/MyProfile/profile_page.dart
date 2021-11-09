import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Account/signin.dart';
import 'package:my_app/Pages/MyDonations/my_donations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/Pages/MyProfile/profile_list_item.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'edit_profile.dart';

var refreshKey = GlobalKey<RefreshIndicatorState>();

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(body: ProfileScreen());
    });
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var fullName = "";
  var email = "";
  var dateOfReg = "";
  var img = "";
  @override
  void initState() {
    super.initState();

    preLoad();
    // displayDetails();
  }

  void preLoad() async {
    print("my profile preload");
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      fullName = prefs.getString('fullName');
      img = prefs.getString("profilePicture");
      dateOfReg = prefs.getString('dateOfReg');
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            margin: EdgeInsets.only(top: 40),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(img),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text(
            fullName ?? "Your name",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 13),
          Text(
            email,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(13),
              fontWeight: FontWeight.w100,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Joined on ' + dateOfReg,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(13),
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 13),
        profileInfo,
        SizedBox(width: 13),
      ],
    );

    Future<void> refreshMyProfile() async {
      refreshKey.currentState?.show(atTop: false);
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        preLoad();
      });
    }

    return Builder(
      builder: (context) {
        return Scaffold(
          body: Container(
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshMyProfile,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30),
                  header,
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyDonations()));
                    },
                    splashColor: Colors.blue.withAlpha(30),
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.user_shield,
                      text: 'View my donation',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.history,
                      text: 'Edit profile',
                    ),
                  ),
                  ProfileListItem(
                    icon: LineAwesomeIcons.question_circle,
                    text: 'Frequently Asked Questions',
                  ),
                  InkWell(
                    onTap: () {
                      _confirmLogoutDialog(context);
                    },
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.alternate_sign_out,
                      text: 'Logout',
                      hasNavigation: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

void _confirmLogoutDialog(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Confirm Logout', style: TextStyle(color: Colors.redAccent)),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            logout();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Signin()));
          },
          child: Text("Confirm"),
        ),
      ],
    ),
  );
}
