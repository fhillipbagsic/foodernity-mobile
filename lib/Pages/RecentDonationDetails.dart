import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/Home/Listings.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:sizer/sizer.dart';

class ListingDetails extends StatefulWidget {
  const ListingDetails({Key key}) : super(key: key);
  static String routeName = "/RecentDonationDetails";

  @override
  _ListingDetailsState createState() => _ListingDetailsState();
}

class _ListingDetailsState extends State<ListingDetails> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height / 3;
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: 100.h,
            width: 100.w,
            child: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                leading: GestureDetector(
                  onTap: () {
                    debugPrint('Back button tapped');
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => Listings()));
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(CupertinoIcons.left_chevron,
                          color: CupertinoColors.activeBlue),
                      Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 13,
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                middle: Text(
                  'Title',
                ),
              ),
              child: Container(child: _cardView(context)),
            ),
          ),
        ),
      );
    });
  }
}

Widget _cardView(context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height / 4;
  var imgHeight = MediaQuery.of(context).size.height / 3;
  var donationGoodsHeight = MediaQuery.of(context).size.height / 6;
  var img =
      'https://psu.edu.ph/wp-content/uploads/2020/11/125760987_1831764043637981_8035397335388690116_n.jpg';
  var beneficiaries = 'Barangay 403';
  var donatedGoods = 'November 05, 2021';
  var remarks =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. ';
  var donGoods = 'Instant Noodles';

  return Container(
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.0),
          width: width,
          height: imgHeight,
          child: Image.network(
            img,
            fit: BoxFit.fitWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: [
              Card(
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 1.5),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                margin: EdgeInsets.all(10.0),
                child: Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.people_sharp,
                      size: 30.0,
                      color: Colors.blue[400],
                    ),
                    title: Text(
                      'Benefiaries: Residents of ' + beneficiaries,
                      style: TextStyle(fontSize: 16, color: Colors.blue[400]),
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.green[50],
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green, width: 1.5),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                margin: EdgeInsets.all(10.0),
                child: Container(
                  child: ListTile(
                    leading: Icon(
                      Icons.timer_sharp,
                      size: 30.0,
                      color: Colors.green[400],
                    ),
                    title: Text(
                      'Donations donated on ' + donatedGoods,
                      style: TextStyle(fontSize: 16, color: Colors.green[400]),
                    ),
                  ),
                ),
              ),
              Container(
                height: height,
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10.0),
                              child: ListTile(
                                title: Text(
                                  'Organizations Remarks',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  height: 120.0,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        remarks,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13.0,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                  ),
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
                height: donationGoodsHeight,
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10.0),
                              child: ListTile(
                                title: Text(
                                  'Donated Goods',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: 110,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Card(
                                                color: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    top: 6,
                                                    bottom: 6,
                                                  ),
                                                  child: Text(
                                                    donGoods,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

// class ListingDetails extends StatefulWidget {
//   @override
//   static String routeName = "/ListingDetails";
//   _ListingDetailsState createState() => _ListingDetailsState();
// }

// class _ListingDetailsState extends State<ListingDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: CustomScrollView(
//           physics: ClampingScrollPhysics(),
//           slivers: [_navigationBar(context), Details()],
//         ),
//       ),
//     );
//   }
// }

// Widget _navigationBar(context) {
//   return CupertinoSliverNavigationBar(
//     largeTitle: Text('Donation Details'),
//     trailing: GestureDetector(
//       onTap: () => Navigator.pushNamed(context, Listings.routeName),
//       child: Text(
//         'Back',
//         style: TextStyle(color: Colors.blue),
//       ),
//     ),
//   );
// }

// class Details extends StatefulWidget {
//   @override
//   _DetailsState createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height / 3;
//     return SliverToBoxAdapter(
//       child: Container(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 20.0),
//               width: width,
//               height: height,
//               child: Image.network(
//                 'https://c1.staticflickr.com/5/4158/33593402264_bedafb79d1_c.jpg',
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 20.0, left: 15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Lucky me pancit canton noodles',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 21.0,
//                       color: Colors.black),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 15.0, left: 15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Wrap(
//                   children: [
//                     Icon(
//                       Icons.place_sharp,
//                       size: 17.0,
//                       color: Colors.red,
//                     ),
//                     SizedBox(
//                       width: 2.0,
//                     ),
//                     Text(
//                       '3 kilometers away',
//                       style: TextStyle(
//                           fontSize: 14.0, fontWeight: FontWeight.normal),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 5.0, left: 6.0, right: 6.0),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.black,
//                         radius: 3,
//                       ),
//                     ),
//                     Text(
//                       'Listed 3h ago',
//                       style: TextStyle(
//                           fontSize: 14.0, fontWeight: FontWeight.normal),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 15.0, left: 15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Donation Details',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18.0,
//                       color: Colors.black),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 5, left: 15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: FlatButton(
//                   onPressed: () {},
//                   color: Colors.blue,
//                   minWidth: 30,
//                   height: 28,
//                   child: Text('Instant Noodles',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 13,
//                           fontWeight: FontWeight.normal)),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40)),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 5, left: 15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Row(
//                   children: [
//                     Text(
//                       'The expiry date is on: ',
//                       style: TextStyle(
//                           fontSize: 14.0,
//                           color: Colors.black,
//                           fontWeight: FontWeight.normal),
//                     ),
//                     Text(
//                       'June 21, 2021',
//                       style: TextStyle(
//                           fontSize: 14.0,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 12, left: 15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Notes',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18.0,
//                       color: Colors.black),
//                 ),
//               ),
//             ),
//             Container(
//               margin:
//                   EdgeInsets.only(top: 7, left: 15.0, right: 12.0, bottom: 7),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'If you are interested, text me on my number 09123456789 or ' +
//                       'email me at kennethDelaCruz@gmail.com',
//                   style: TextStyle(
//                       fontWeight: FontWeight.normal,
//                       fontSize: 14.0,
//                       color: Colors.black),
//                 ),
//               ),
//             ),
//             const Divider(
//               height: 25,
//               thickness: 3,
//               indent: 10,
//               endIndent: 10,
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 7.0, left: 14.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Pickup Details',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18.0,
//                       color: Colors.black),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 9, left: 15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Wrap(
//                   children: [
//                     Icon(Icons.place_sharp, size: 20.0, color: Colors.green),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Text(
//                         'Jhocson St., Sampaloc Manila',
//                         style: TextStyle(
//                             fontSize: 17.0, fontWeight: FontWeight.normal),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 9, left: 15.0),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Wrap(
//                   children: [
//                     Icon(Icons.calendar_today,
//                         size: 20.0, color: Colors.yellow),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Text(
//                         'June 06, 2021',
//                         style: TextStyle(
//                             fontSize: 17.0, fontWeight: FontWeight.normal),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Container(
//             //   margin: EdgeInsets.only(top: 9, left: 15.0, bottom: 7),
//             //   child: Align(
//             //     alignment: Alignment.centerLeft,
//             //     child: Wrap(
//             //       children: [
//             //         Icon(Icons.lock_clock, size: 20.0, color: Colors.purple),
//             //         Padding(
//             //           padding: const EdgeInsets.only(left: 10.0),
//             //           child: Text(
//             //             '3:30PM',
//             //             style: TextStyle(
//             //                 fontSize: 17.0, fontWeight: FontWeight.normal),
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//             const Divider(
//               height: 25,
//               thickness: 3,
//               indent: 10,
//               endIndent: 10,
//             ),
//             // Container(
//             //   margin: EdgeInsets.only(
//             //       top: 7.0, left: 14.0, bottom: 12.0, right: 15.0),
//             //   child: FlatButton(
//             //     onPressed: () {
//             //       Navigator.pushNamed(context, ChatDetailPage.routeName);
//             //     },
//             //     minWidth: width,
//             //     height: 45,
//             //     child: Wrap(
//             //       children: [
//             //         Icon(Icons.message, size: 20.0, color: Colors.blue),
//             //         Padding(
//             //           padding: const EdgeInsets.only(left: 10.0),
//             //           child: Text('Send Message',
//             //               style: TextStyle(
//             //                   fontSize: 18.0,
//             //                   fontWeight: FontWeight.normal,
//             //                   color: Colors.blue)),
//             //         ),
//             //       ],
//             //     ),
//             //     shape: RoundedRectangleBorder(
//             //         side: BorderSide(
//             //             color: Colors.blue, width: 1, style: BorderStyle.solid),
//             //         borderRadius: BorderRadius.circular(8)),
//             //   ),
//             // ),
//             Container(
//               margin: EdgeInsets.only(
//                   top: 7.0, left: 14.0, bottom: 12.0, right: 15.0),
//               child: FlatButton(
//                 onPressed: () {
//                   showAlertDialog(context);
//                 },
//                 minWidth: width,
//                 height: 45,
//                 color: Colors.green,
//                 child: Text('Receive Listing',
//                     style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.normal,
//                         color: Colors.white)),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(
//                         color: Colors.green,
//                         width: 1,
//                         style: BorderStyle.solid),
//                     borderRadius: BorderRadius.circular(8)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget showAlertDialog(BuildContext context) {
//   // set up the buttons
//   Widget continueButton = FlatButton(
//     child: Text(
//       "Okay",
//       style: TextStyle(color: Colors.blue),
//     ),
//     onPressed: () {
//       Navigator.pushNamed(context, Home.routeName);
//     },
//   );

//   AlertDialog alert = AlertDialog(
//     title: Row(
//       children: [
//         Text("Receive Ongoing! ", style: TextStyle(color: Colors.green)),
//       ],
//     ),
//     content: Text(
//       "You can view the listing you receive in Received Donations tab",
//       style: TextStyle(color: Colors.black),
//     ),
//     actions: [
//       continueButton,
//     ],
//     backgroundColor: Colors.white,
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
