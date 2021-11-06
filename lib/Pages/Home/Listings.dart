import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/Item.dart';
import 'package:my_app/Pages/PostDonation/PostDonation.dart';
import 'package:my_app/Pages/RecentDonationDetails.dart';
import 'package:my_app/Widgets/NavigationBar.dart';
import 'package:my_app/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class Listings extends StatefulWidget {
  static String routeName = "/Listings";
  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  // var imageStocks = ['assets/images/instant-noodles.png'];
  var email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    preLoad();
  }

  void preLoad() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
    getUserDetails();
  }

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    http.Response response =
        await http.post("https://foodernity.herokuapp.com/user/getUserDetails",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': email,
            }));
    print(response.body + 'from listing');
    Map<String, dynamic> map = json.decode(response.body);
    print("Dissected in listings page");
    print(map["userID"]);
    print(map["email"]);
    print(map["password"]);
    print(map["dateOfReg"]);
    print(map["loginMethod"]);

    prefs.setInt('userID', map["userID"]);
    prefs.setString('email', map["email"]);
    prefs.setString('password', map["password"]);
    prefs.setString('fullName', map["fullName"]);
    prefs.setString('profilePicture', map["profilePicture"]);
    prefs.setString('dateOfReg', map["dateOfReg"]);
    prefs.setString('loginMethod', map["loginMethod"]);
    prefs.setString('userType', map["userType"]);
    prefs.setString('userStatus', map["userStatus"]);
    prefs.setString('changePasswordCode', map["changePasswordCode"]);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        key: scaffoldKey,
        body: Container(
          height: 100.h,
          width: 100.w,
          child: SafeArea(
            child: CustomScrollView(
              //physics: ClampingScrollPhysics(),
              slivers: [
                NavigationBar(
                  title: 'Donations',
                  scaffold: scaffoldKey,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _filter(context),
                        // _currentStocks(),
                        // _Inventory(context),
                        SizedBox(
                          height: 20.0,
                        ),
                        _recentDonations(),
                      ],
                    ),
                  ),
                ),
               Notification(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.pushNamed(context, AddListing.routeName);
            showInformationDialog(context);
          },
          child: Icon(Icons.add),
          backgroundColor: ColorPrimary,
        ),
      );
    });
  }
}

List<Item> agreementItems = [
  Item(
    headerValue:
        'I acknowledge that I am donating foods that are in the following:',
    expandedValue:
        'Canned Goods - Canned fruits and vegetables, milks and sauces, meat and fish.',
    expandedValue2:
        'Instant Noodles - Instant Noodles sush as soups noodles, fried noodles, non-fried noodles.',
    expandedValue3:
        'Snacks & Biscuits - Any kinds of snacks and biscuits and the.',
    expandedValue4:
        'Beverages - Water, tea, coffee, soft drinks, juice drinks (alcoholic are prohibited).',
    expandedValue5:
        "Others - Other non-perishable foods that don't require refrigeration (e.g., condiments).",
    expandedValue6: '',
  ),
  Item(
    headerValue:
        'I acknowledge that I am not donating foods that are in the following:',
    expandedValue:
        'Home-cooked-foods - Foods prepared, cooked, cooled, or reheated at home.',
    expandedValue2:
        'Expired Foods - Foods that are past a "use by / consume by" date.',
    expandedValue3:
        'Foods in containers - Foods taken out of their original packaging and placed into containers.',
    expandedValue4:
        'Opened Foods - Foods in opened or torn containers exposing the food to potential contamination.',
    expandedValue5:
        "Raw foods - Meat, beef, pork, poultry, and other considered raw foods.",
    expandedValue6:
        "Others - Other perishables such as fruits, vegetables, dairy products, eggs, meat, poultry, and seafood.",
  ),
  Item(
    headerValue:
        'I acknowledge that I am donating foods that are in the following:',
    expandedValue:
        'Canned Goods - Canned fruits and vegetables, milks and sauces, meat and fish.',
    expandedValue2:
        'Instant Noodles - Instant Noodles sush as soups noodles, fried noodles, non-fried noodles.',
    expandedValue3:
        'Snacks & Biscuits - Any kinds of snacks and biscuits and the.',
    expandedValue4:
        'Beverages - Water, tea, coffee, soft drinks, juice drinks (alcoholic are prohibited).',
    expandedValue5:
        "Others - Other non-perishable foods that don't require refrigeration (e.g., condiments).",
    expandedValue6: '',
  ),
  Item(
    headerValue:
        'I acknowledge that I am not donating foods that are in the following:',
    expandedValue:
        'Home-cooked-foods - Foods prepared, cooked, cooled, or reheated at home.',
    expandedValue2:
        'Expired Foods - Foods that are past a "use by / consume by" date.',
    expandedValue3:
        'Foods in containers - Foods taken out of their original packaging and placed into containers.',
    expandedValue4:
        'Opened Foods - Foods in opened or torn containers exposing the food to potential contamination.',
    expandedValue5:
        "Raw foods - Meat, beef, pork, poultry, and other considered raw foods.",
    expandedValue6:
        "Others - Other perishables such as fruits, vegetables, dairy products, eggs, meat, poultry, and seafood.",
  ),
  Item(
    headerValue:
        'I acknowledge that I am donating foods that are in the following:',
    expandedValue:
        'Canned Goods - Canned fruits and vegetables, milks and sauces, meat and fish.',
    expandedValue2:
        'Instant Noodles - Instant Noodles sush as soups noodles, fried noodles, non-fried noodles.',
    expandedValue3:
        'Snacks & Biscuits - Any kinds of snacks and biscuits and the.',
    expandedValue4:
        'Beverages - Water, tea, coffee, soft drinks, juice drinks (alcoholic are prohibited).',
    expandedValue5:
        "Others - Other non-perishable foods that don't require refrigeration (e.g., condiments).",
    expandedValue6: '',
  ),
];

Future<void> showInformationDialog(BuildContext context) async {
  var size = MediaQuery.of(context).size;
  final double height = (size.height) / 2.0;
  final double width = size.width / 1;
  final List<Item> _data = agreementItems;
  const description =
      "Before proceeding to post a donation, you must adhere to the guidelines first to protect you and the safety of the others as we. The guidelines to acknowledge are as follows.";

  return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Container(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Guidelines For Donating',
                            style: TextStyle(color: Colors.blue)),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(description,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 30,
                      ),
                      ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            _data[index].isExpanded = !isExpanded;
                          });
                        },
                        children: _data.map<ExpansionPanel>((Item item) {
                          return ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text(
                                  item.headerValue,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              );
                            },
                            body: ListTile(
                              title: Column(
                                children: [
                                  Text(item.expandedValue,
                                      style: TextStyle(fontSize: 10.0)),
                                  SizedBox(height: 10.0),
                                  Text(item.expandedValue2,
                                      style: TextStyle(fontSize: 10.0)),
                                  SizedBox(height: 10.0),
                                  Text(item.expandedValue3,
                                      style: TextStyle(fontSize: 10.0)),
                                  SizedBox(height: 10.0),
                                  Text(item.expandedValue4,
                                      style: TextStyle(fontSize: 10.0)),
                                  SizedBox(height: 10.0),
                                  Text(item.expandedValue5,
                                      style: TextStyle(fontSize: 10.0)),
                                  SizedBox(height: 10.0),
                                  Text(item.expandedValue6,
                                      style: TextStyle(fontSize: 10.0)),
                                ],
                              ),
                            ),
                            isExpanded: item.isExpanded,
                          );
                        }).toList(),
                      )
                    ],
                  ),
                )),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Text(
                        "Close",
                      )),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostDonation()));
                    },
                    child:
                        Text("Proceed", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          );
        });
      });
}

class InventoryContainer extends StatelessWidget {
  const InventoryContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget _Inventory(context) {
  int _index;
  var width = MediaQuery.of(context).size.width - 200;
  var height = MediaQuery.of(context).size.height / 7;
  final categories = [
    "Eggs",
    "Canned goods",
    "Instant Noodles",
    "Rice",
    "Cereals",
    "Tea, Coffee, Milk, Sugar, etc.",
    "Biscuits",
    "Condiments and sauces",
    "Beverages",
    "Snacks",
  ];
  final image = [
    'assets/images/eggs.png',
    'assets/images/canned-food.png',
    'assets/images/instant-noodles.png',
    'assets/images/canned-food.png',
    'assets/images/bakery.png',
    'assets/images/canned-food.png',
    'assets/images/snack.png',
    'assets/images/canned-food.png',
    'assets/images/snack.png',
    'assets/images/snack.png',
  ];

  final stocks = ['40', '50', '60', '70', '80', '20', '10', '5', '23', '16'];
  return Container(
    child: Center(
      child: SizedBox(
          // height: 120, // card height
          height: height,
          // width: width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Row(
                              children: [
                                Image(image: AssetImage(image[index])),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          categories[index],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          stocks[index],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              );
            },
          )),
    ),
  );
}

Widget _filter(context) {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return _filterPicker();
              });
        },
        child: Row(
          children: [Text('Available Now'), Icon(Icons.arrow_drop_down)],
        ),
      ),
      TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return (_filterSheet());
                });
          },
          child: Text('FILTER')),
    ],
  ));
}

Widget _filterPicker() {
  return Container(
    height: 250.0,
    child: (CupertinoPicker(
      useMagnifier: true,
      onSelectedItemChanged: (index) {},
      itemExtent: 50.0,
      backgroundColor: Colors.white,
      children: [
        Center(child: Text('Available Now')),
        Center(child: Text('Suggested')),
        Center(child: Text('Nearest')),
      ],
    )),
  );
}

Widget _filterSheet() {
  return Container(
    height: 500.0,
    child: (Column(
      children: [
        Text('My Location'),
        ListTile(
          leading: Icon(
            Icons.location_on_rounded,
          ),
          title: Text('Bali Oasis, Pasig'),
          trailing: Icon(Icons.edit_rounded),
        )
      ],
    )),
  );
}

Widget _currentStocks() {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: (Text(
      'MHTP Current Stocks',
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.blue),
    )),
  );
}

Widget _recentDonations() {
  return (Text(
    'Recent Donations from Donors',
    style: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.blue),
  ));
}
class Notification extends StatefulWidget {
  const Notification({Key key}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return Container(
            height: 1000,
            child: FutureBuilder(
              future: getAnnouncements(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading Notifications..."),
                    ),
                  );
                } else
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(snapshot.data[i].notif),
                        );
                      });
              },
            ),
          );
        },
      ),
    );
  }
}

Future getAnnouncements() async {
  // final prefs = await SharedPreferences.getInstance();
  // var email= prefs.getString('email');


  http.Response response =
  await http.post("https://foodernity.herokuapp.com/donations/getDistributedDonations",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

      }));

  print(response.body);
  // var jsonData = jsonDecode(response.body);
  // List<AppNotification> notifications = [];
  //
  // for (var u in jsonData) {
  //
  //   // print(u);
  //   AppNotification notification =
  //   AppNotification(u["notificationMessage"]);
  //   notifications.add(notification);
  // }
  // print(notifications.length);
  // return notifications;
}




// class ListingsContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final double itemHeight = (size.height) / 6.5;
//     final double itemWidth = size.width / 2;
//     return SliverPadding(
//       // padding: EdgeInsets.symmetric(horizontal: 20.0),
//       padding:
//           EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 15.0),
//       sliver: (SliverGrid.count(
//         childAspectRatio: (itemWidth / itemHeight),
//         crossAxisSpacing: 5.0,
//         mainAxisSpacing: 5.0,
//         crossAxisCount: 1,
//         children: [
//           _listingItem(
//               'Donation Drive to the residents of Barangay 403 ',
//               'November 05, 2021',
//               'https://psu.edu.ph/wp-content/uploads/2020/11/125760987_1831764043637981_8035397335388690116_n.jpg',
//               context),
//           _listingItem(
//               'Donation Drive to the residents of Barangay 403',
//               'November 05, 2021',
//               'http://static1.squarespace.com/static/55f9afdfe4b0f520d4e4ff43/55f9b97fe4b0241b81b0cbe4/5eb092883c9e9c74eb3c23fa/1594661924914/OC+AOT+food+donation.jpg?format=1500w',
//               context),
//           _listingItem(
//               'Donation Drive to the residents of Barangay 403',
//               'November 05, 2021',
//               'https://psu.edu.ph/wp-content/uploads/2020/11/125760987_1831764043637981_8035397335388690116_n.jpg',
//               context),
//         ],
//       )),
//     );
//   }
// }

Widget _listingItem(title, date, image, context) {
  var donationImage = image;
  var donationDate = date;
  var donationTitle = title;

  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height / 5;

  return InkWell(
    splashColor: Colors.blue.withAlpha(30),
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ListingDetails()));
    },
    child: (Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image(
              fit: BoxFit.fitWidth,
              height: height,
              width: double.infinity,
              image: NetworkImage(donationImage),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      donationDate,
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                    ),
                    subtitle: Text(
                      donationTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.grey[600]),
                    ),
                    trailing: Wrap(
                      spacing: 1,
                      children: <Widget>[
                        Icon(Icons.navigate_next_sharp, color: Colors.blue)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )),
  );
}


          // Container(
          //   padding: EdgeInsets.only(left: 10.0),
          //   child: Row(
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SizedBox(
          //             height: 12.0,
          //           ),
          //           // CircleAvatar(
          //           //   radius: 20.0,
          //           //   backgroundImage: NetworkImage(donatorImage),
          //           //   backgroundColor: Colors.transparent,
          //           // ),
          //         ],
          //       ),
          //       Container(
          //         child: Padding(
          //           padding: const EdgeInsets.only(left: 8.0, top: 11),
          //           child: Column(
          //             children: [
          //               SizedBox(
          //                 width: 120,
          //                 child: Text(
          //                   donatorName,
          //                   maxLines: 1,
          //                   overflow: TextOverflow.clip,
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 12.0,
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 3.0,
          //               ),
          //               SizedBox(
          //                   width: 120,
          //                   child: Text(
          //                     donationDesc,
          //                     maxLines: 1,
          //                     overflow: TextOverflow.ellipsis,
          //                     style: TextStyle(
          //                         fontWeight: FontWeight.w300, fontSize: 10),
          //                   ))
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 10.0,
          // ),
