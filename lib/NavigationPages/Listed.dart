import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Widgets/NavigationBar.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/Pages/Home/FrequentlyAsk.dart';
import 'package:my_app/NavigationPages/ReceivedDonations.dart';
import 'package:my_app/NavigationPages/RequestedDonation.dart';

class Listed extends StatefulWidget {
  static String routeName = "/Listed";
  @override
  _ListedState createState() => _ListedState();
}

class _ListedState extends State<Listed> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: MyDonations()),
    );
  }
}

var postedTitle = [
  "Butter Sticks",
  "Canned Goods",
];

var postedDesc = [
  "You have messages from donee",
  "You have messages from donee",
];

var postedImg = [
  "assets/images/image5.jpg",
  "assets/images/image2.jpg",
];

var ongoingTitle = [
  "Purefoods Corned Beef",
  // "Canned Goods",
];

var ongoingDesc = [
  "Pick up on",
  // "Pick up on"
];

var ongoingImg = [
  "assets/images/cornedbeef.jpg",
  // "assets/images/image2.jpg",
];

var claimedTitle = [
  "Ligo Sardines",
  // "Canned Goods",
];

var claimedDesc = [
  "Successfully picked up!",
  // "Pick up on"
];

var claimedImg = [
  "assets/images/image3.jpg",
  // "assets/images/image2.jpg",
];

var unPostedTitle = [
  "Nissin Cup Noodles",
  // "Canned Goods",
];

var unPostedDesc = [
  "No one attempted to receive the listing",
  // "Pick up on"
];

var unPostedImg = [
  "assets/images/nissin.jpg",
  // "assets/images/image2.jpg",
];

class MyDonations extends StatefulWidget {
  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width * 0.6;
    final double itemHeight = (size.height);
    final double itemWidth = size.width * 0.6;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          title: const Text('My Donations',
              style: TextStyle(color: Colors.blue, fontSize: 25.0)),
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                child: Text(
                  "To be Accepted",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  "To be Claimed",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  "Claimed",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  "Donated",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ],
          ),
          iconTheme: IconThemeData(color: Colors.blue),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListView.builder(
            itemCount: postedImg.length,
            itemBuilder: (context, index) {
              return Container(
                width: itemWidth,
                margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 11.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(postedImg[index]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  postedTitle[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Container(
                                  width: itemWidth,
                                  child: Wrap(children: [
                                    Icon(
                                      Icons.message,
                                      size: 17.0,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      postedDesc[index],
                                      maxLines: 10,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  height: 22.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _viewDetails(context, index),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          ListView.builder(
            itemCount: ongoingImg.length,
            itemBuilder: (context, index) {
              return Container(
                width: itemWidth,
                margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 11.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(ongoingImg[index]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  ongoingTitle[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: itemWidth,
                                  child: Wrap(children: [
                                    Text(
                                      ongoingDesc[index],
                                      maxLines: 10,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    Text(
                                      ' June 19, 2021',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' at SM Manila',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _viewDetails2(context, index),
                                    _messageButton(context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          ListView.builder(
            itemCount: claimedImg.length,
            itemBuilder: (context, index) {
              return Container(
                width: itemWidth,
                margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 11.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(claimedImg[index]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  claimedTitle[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Container(
                                  width: itemWidth,
                                  child: Wrap(children: [
                                    Icon(
                                      Icons.check,
                                      size: 17.0,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      claimedDesc[index],
                                      maxLines: 10,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.green),
                                    ),
                                  ]),
                                ),
                                SizedBox(
                                  height: 22.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _viewDetails3(context, index),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          ListView.builder(
            itemCount: unPostedImg.length,
            itemBuilder: (context, index) {
              return Container(
                width: itemWidth,
                margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 11.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 10.0, left: 10.0, right: 10.0, top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(unPostedImg[index]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  unPostedTitle[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Container(
                                //   width: itemWidth,
                                //   child: Wrap(children: [
                                //     Text(
                                //       unPostedDesc[index],
                                //       maxLines: 10,
                                //       style: TextStyle(
                                //           fontSize: 12, color: Colors.red),
                                //     ),
                                //   ]),
                                // ),
                                SizedBox(
                                  height: 22.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _viewDetails4(context, index),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: AccountDrawer(),
      ),
    );
  }
}

Widget _viewDetails(context, index) {
  return Container(
    margin: EdgeInsets.only(left: 180),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
            onPressed: () {
              showDialogFunc(context, postedImg[index], postedTitle[index],
                  postedDesc[index]);
            },
            color: Colors.blue[500],
            minWidth: 10.0,
            height: 32,
            child: Text('View Details',
                style: TextStyle(color: Colors.white, fontSize: 10.0)))
      ],
    ),
  );
}

Widget _viewDetails2(context, index) {
  return Container(
    margin: EdgeInsets.only(right: 5.0, left: 120),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
            onPressed: () {
              showDialogFunc(context, ongoingImg[index], ongoingTitle[index],
                  postedDesc[index]);
            },
            color: Colors.blue[500],
            minWidth: 5.0,
            height: 32,
            child: Text('View Details',
                style: TextStyle(color: Colors.white, fontSize: 10.0)))
      ],
    ),
  );
}

Widget _viewDetails3(context, index) {
  return Container(
    margin: EdgeInsets.only(left: 180),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
            onPressed: () {
              showDialogFunc(context, claimedImg[index], claimedTitle[index],
                  postedDesc[index]);
            },
            color: Colors.blue[500],
            minWidth: 5.0,
            height: 32,
            child: Text('View Details',
                style: TextStyle(color: Colors.white, fontSize: 10.0)))
      ],
    ),
  );
}

Widget _viewDetails4(context, index) {
  return Container(
    margin: EdgeInsets.only(left: 180),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
            onPressed: () {
              showDialogFunc(context, unPostedImg[index], unPostedTitle[index],
                  postedDesc[index]);
            },
            color: Colors.blue[500],
            minWidth: 5.0,
            height: 32,
            child: Text('View Details',
                style: TextStyle(color: Colors.white, fontSize: 10.0)))
      ],
    ),
  );
}

Widget _messageButton(context) {
  return Container(
    // margin: EdgeInsets.only(left: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
            onPressed: () {
              // Navigator.pushNamed(context, ChatDetailPage.routeName);
            },
            color: Colors.grey,
            minWidth: 30.0,
            height: 32,
            child: Text('Message',
                style: TextStyle(color: Colors.black, fontSize: 10.0)))
      ],
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
                ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Kenneth Dela Cruz',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FrequentlyAsk()));
            },
            leading: Icon(Icons.contact_support_sharp),
            title: Text('Frequently Asked Questions'),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Listed()));
            },
            leading: Icon(Icons.add_shopping_cart),
            title: Text('My Donations'),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReceivedDonations()));
            },
            leading: Icon(Icons.check_circle),
            title: Text('Received Donations'),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RequestedDonation()));
            },
            leading: Icon(Icons.question_answer),
            title: Text('Requested Donations'),
          ),
          Container(
            margin: EdgeInsets.only(top: 250.0),
            child: ListTile(
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => RequestedDonation()));
              },
              leading: Icon(Icons.arrow_back),
              title: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}

showDialogFunc(context, img, title, desc) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    img,
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(children: [
                  // Icon(
                  //   Icons.place_sharp,
                  //   size: 14.0,
                  //   color: Colors.red,
                  // ),
                  SizedBox(
                    width: 2.0,
                  ),
                  // Text(
                  //   '3 kilometers away',
                  //   style: TextStyle(fontSize: 13.0),
                  // ),
                  SizedBox(
                    width: 5.0,
                  ),
                  // Text(
                  //   'Posted 3h ago',
                  //   style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                  // ),
                  // Container(
                  //   // width: 200,
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       'desc',
                  //       maxLines: 3,
                  //       style: TextStyle(fontSize: 13, color: Colors.black),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                ]),
              ],
            ),
          ),
        ),
      );
    },
  );
}
