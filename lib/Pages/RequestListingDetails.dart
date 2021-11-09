import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Announcement/announcement.dart';
import 'package:my_app/Pages/Home.dart';

class RequestDetails extends StatefulWidget {
  @override
  static String routeName = "/RequestDetails";
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [_navigationBar(context), Details()],
        ),
      ),
    );
  }
}

Widget _navigationBar(context) {
  return CupertinoSliverNavigationBar(
    largeTitle: Text('Request Details'),
    trailing: GestureDetector(
      onTap: () => Navigator.pushNamed(context, Listings.routeName),
      child: Text(
        'Back',
        style: TextStyle(color: Colors.blue),
      ),
    ),
  );
}

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height / 3;
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.0),
              width: width,
              height: height,
              child: Image.network(
                'https://cdn.shopify.com/s/files/1/0374/6293/3644/products/7DC134E9-2464-4D8E-A2EA-64BF6099C1B8_1024x1024@2x.jpg?v=1585715574',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hunts Pork and Bean',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21.0,
                      color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  children: [
                    Icon(
                      Icons.place_sharp,
                      size: 17.0,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Text(
                      '3 kilometers away',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.normal),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 3,
                      ),
                    ),
                    Text(
                      'Listed 3h ago',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Donation Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  onPressed: () {},
                  color: Colors.blue,
                  minWidth: 30,
                  height: 28,
                  child: Text('Canned Goods',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Quantity: ',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '5',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notes',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 7, left: 15.0, right: 12.0, bottom: 7),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '5pcs of Pancit Canton Noodles regular flavor',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                      color: Colors.black),
                ),
              ),
            ),
            const Divider(
              height: 25,
              thickness: 3,
              indent: 10,
              endIndent: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 7.0, left: 14.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pickup Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 9, left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  children: [
                    Icon(Icons.place_sharp, size: 20.0, color: Colors.green),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Jhocson St., Sampaloc Manila',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 9, left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 20.0, color: Colors.yellow),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'June 06, 2021',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 9, left: 15.0, bottom: 7),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Wrap(
            //       children: [
            //         Icon(Icons.lock_clock, size: 20.0, color: Colors.purple),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 10.0),
            //           child: Text(
            //             '3:30PM',
            //             style: TextStyle(
            //                 fontSize: 17.0, fontWeight: FontWeight.normal),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const Divider(
              height: 25,
              thickness: 3,
              indent: 10,
              endIndent: 10,
            ),
            // Container(
            //   margin: EdgeInsets.only(
            //       top: 7.0, left: 14.0, bottom: 12.0, right: 15.0),
            //   child: FlatButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, ChatDetailPage.routeName);
            //     },
            //     minWidth: width,
            //     height: 45,
            //     child: Wrap(
            //       children: [
            //         Icon(Icons.message, size: 20.0, color: Colors.blue),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 10.0),
            //           child: Text('Send Message',
            //               style: TextStyle(
            //                   fontSize: 18.0,
            //                   fontWeight: FontWeight.normal,
            //                   color: Colors.blue)),
            //         ),
            //       ],
            //     ),
            //     shape: RoundedRectangleBorder(
            //         side: BorderSide(
            //             color: Colors.blue, width: 1, style: BorderStyle.solid),
            //         borderRadius: BorderRadius.circular(8)),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(
                  top: 7.0, left: 14.0, bottom: 12.0, right: 15.0),
              child: FlatButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                minWidth: width,
                height: 45,
                color: Colors.green,
                child: Text('Donate',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white)),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.green,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget continueButton = FlatButton(
    child: Text(
      "Okay",
      style: TextStyle(color: Colors.blue),
    ),
    onPressed: () {
      Navigator.pushNamed(context, Home.routeName);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Row(
      children: [
        Text("Donation Ongoing! ", style: TextStyle(color: Colors.green)),
      ],
    ),
    content: Text(
      "You can view your donation in Requested Donation tab",
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      continueButton,
    ],
    backgroundColor: Colors.white,
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
