import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Home/FrequentlyAsk.dart';
import 'package:my_app/NavigationPages/Listed.dart';
import 'package:my_app/NavigationPages/RequestedDonation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pie_chart/pie_chart.dart';

class Account extends StatefulWidget {
  @override
  _Account createState() => _Account();
}

class _Account extends State<Account> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: MyDonations()),
    );
  }
}

enum LegendShape { Circle, Rectangle }

class MyDonations extends StatefulWidget {
  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations>
    with TickerProviderStateMixin {
  TabController _tabController;
  File _image;
  final picker = ImagePicker();
  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null && pickedFile.path != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  ChartType _chartType = ChartType.disc;
  bool _showCenterText = true;
  double _ringStrokeWidth = 32;
  double _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  LegendShape _legendShape = LegendShape.Circle;
  LegendPosition _legendPosition = LegendPosition.right;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
          ? 300
          : MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType,
      centerText: _showCenterText ? "HYBRID" : null,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth,
      emptyColor: Colors.grey,
    );
    var size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width * 0.6;
    final double itemHeight = (size.height);
    final double itemWidth = size.width * 0.6;
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        endDrawer: Homepage(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Account',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                child: Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  "My Profile",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ],
          ),
          iconTheme: IconThemeData(color: Colors.blue),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: Form(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 55.0),
                      child: SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          fit: StackFit.expand,
                          overflow: Overflow.visible,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/profile.jpg"),
                            ),
                            Positioned(
                              right: -16,
                              bottom: 0,
                              child: SizedBox(
                                height: 46,
                                width: 46,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  color: Color(0xFFF5F6F9),
                                  onPressed: () {
                                    getImage();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/Camera Icon.svg"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    _firstNameField(context),
                    _lastNameField(context),
                    emailField(context),
                    _currentPass(context),
                    _newPass(context),
                    Container(
                      margin: EdgeInsets.only(
                          top: 20.0, left: 80.0, bottom: 12.0, right: 20.0),
                      child: Row(
                        children: [
                          FlatButton(
                            onPressed: () {
                              // Navigator.pushNamed(
                              //     context, PostDonationSummary.routeName);
                            },
                            minWidth: 55,
                            height: 45,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Cancel Change',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.blue)),
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: FlatButton(
                                onPressed: () {
                                  // Navigator.pushNamed(
                                  //     context, PostDonationSummary.routeName);
                                },
                                minWidth: 55,
                                height: 45,
                                color: Colors.green,
                                child: Text('Save Changes',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white)),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.blue,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        overflow: Overflow.visible,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/profile.jpg"),
                          ),
                          Positioned(
                            right: -16,
                            bottom: 0,
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.white),
                                ),
                                color: Color(0xFFF5F6F9),
                                onPressed: () {
                                  getImage();
                                },
                                child: SvgPicture.asset(
                                    "assets/icons/Camera Icon.svg"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (_, constraints) {
                      if (constraints.maxWidth >= 600) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: chart,
                            ),
                            Flexible(
                              flex: 1,
                              // child: settings,
                            )
                          ],
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: chart,
                                margin: EdgeInsets.symmetric(
                                  vertical: 32,
                                ),
                              ),
                              // settings,
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        // endDrawer: Drawer(
        //   child: AccountDrawer(),
        // ),
      );
    });
  }
}

Widget _firstNameField(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(top: 10.0),
    width: width,
    child: (TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'First Name is required';
        }
        return null;
      },
      onSaved: (value) {
        // firstName = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Mark Kenneth',
        hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    )),
  );
}

Widget _lastNameField(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(top: 15.0),
    width: width,
    child: (TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is required';
        } else if (value.length < 2) {
          return 'must be more than 1 character';
        }
        return null;
      },
      onSaved: (value) {
        // lastName = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Dela Cruz',
        hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    )),
  );
}

Widget emailField(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(top: 15.0),
    width: width,
    child: (TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is required';
        } else if (value.length < 2) {
          return 'must be more than 1 character';
        }
        return null;
      },
      onSaved: (value) {
        // lastName = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'markennethdelacruz04@gmail.com',
        hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    )),
  );
}

Widget _currentPass(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(top: 15.0),
    width: width,
    child: (TextFormField(
      obscureText: true,
      // validator: passwordValidator,
      onSaved: (value) {
        // password = value;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(), labelText: 'Current Password'),
    )),
  );
}

Widget _newPass(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(top: 15),
    width: width,
    child: (TextFormField(
      obscureText: true,
      // validator: passwordValidator,
      onSaved: (value) {
        // password = value;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(), labelText: 'New Password'),
    )),
  );
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
              accountName: Text(
                "John Paul",
                style: Theme.of(context).textTheme.headline6,
              ),
              accountEmail: Text(
                "johnpaul@example.com",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          ListTile(
            title: Text('My Files'),
            leading: Icon(Icons.folder),
            onTap: () {
              print("Clicked");
            },
          ),
          ListTile(
            title: Text('Shared with me'),
            leading: Icon(Icons.people),
            onTap: () {
              print("Clicked");
            },
          ),
          ListTile(
            title: Text('Starred'),
            leading: Icon(Icons.star),
            onTap: () {
              print("Clicked");
            },
          ),
          ListTile(
            title: Text('Recent'),
            leading: Icon(Icons.timer),
            onTap: () {
              print("Clicked");
            },
          ),
          ListTile(
            title: Text('Offline'),
            leading: Icon(Icons.offline_pin),
            onTap: () {
              print("Clicked");
            },
          ),
          ListTile(
            title: Text('Uploads'),
            leading: Icon(Icons.file_upload),
            onTap: () {
              print("Clicked");
            },
          ),
          ListTile(
            title: Text('Backups'),
            leading: Icon(Icons.backup),
            onTap: () {
              print("Clicked");
            },
          ),
        ],
      ),
    );
  }
}
