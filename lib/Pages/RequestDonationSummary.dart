import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Home.dart';

class RequestSummary extends StatefulWidget {
  static String routeName = "/RequestDonationSummary";
  @override
  _RequestSummaryState createState() => _RequestSummaryState();
}

class _RequestSummaryState extends State<RequestSummary> {
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
    largeTitle: Text('Donation Summary'),
    trailing: GestureDetector(
      onTap: () {
        showAlertDialog(context);
      },
      child: Text(
        'Done',
        style: TextStyle(color: Colors.blue),
      ),
    ),
  );
}

Widget showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context, false);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Post"),
    onPressed: () {
      Navigator.pushNamed(context, Home.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirm Post"),
    content: Text("Proceed to posting donation?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
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
                'https://c1.staticflickr.com/5/4158/33593402264_bedafb79d1_c.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pancit Canton Noodles',
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
                    // Container(
                    //   margin: EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.black,
                    //     radius: 3,
                    //   ),
                    // ),
                    // Text(
                    //   'Listed 3h ago',
                    //   style: TextStyle(
                    //       fontSize: 14.0, fontWeight: FontWeight.normal),
                    // ),
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
                  child: Text('Instant Noodles',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 5, left: 15.0),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Row(
            //       children: [
            //         Text(
            //           'The expiry date is on: ',
            //           style: TextStyle(
            //               fontSize: 14.0,
            //               color: Colors.black,
            //               fontWeight: FontWeight.normal),
            //         ),
            //         Text(
            //           'June 21, 2021',
            //           style: TextStyle(
            //               fontSize: 14.0,
            //               color: Colors.black,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
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
                  'Pancit Canton 5pcs',
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
          ],
        ),
      ),
    );
  }
}
