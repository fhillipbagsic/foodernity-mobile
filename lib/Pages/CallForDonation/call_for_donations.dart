import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/Announcement.dart';
import 'package:my_app/Models/CallForDonation.dart';
import 'package:my_app/Pages/CallForDonation/call_for_donation_item.dart';
import 'package:sizer/sizer.dart';
import 'package:my_app/Pages/CallForDonation/call_for_donation_detail.dart';
import 'package:http/http.dart' as http;

class RequestListing extends StatefulWidget {
  @override
  _RequestListingState createState() => _RequestListingState();
}

class _RequestListingState extends State<RequestListing> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<CallForDonation>> futureCallforDonations;
  @override
  void initState() {
    super.initState();
    futureCallforDonations = getCallForDonation();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Container(
            color: Colors.grey[200],
            child: FutureBuilder(
              future: futureCallforDonations,
              builder: (context, snapshot) {
                Widget ctaSliverList;
                if (snapshot.hasData) {
                  ctaSliverList = SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return CtaItem(
                        cta: snapshot.data[index],
                      );
                    }, childCount: snapshot.data.length),
                  );
                } else {
                  ctaSliverList = SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                return CustomScrollView(
                  slivers: [
                    CupertinoSliverNavigationBar(
                      automaticallyImplyLeading: false,
                      largeTitle: Text('Call for Donations'),
                    ),
                    ctaSliverList
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

// class CallForDonationData extends StatefulWidget {
//   const CallForDonationData({Key key}) : super(key: key);

//   @override
//   _CallForDonationDataState createState() => _CallForDonationDataState();
// }

// class _CallForDonationDataState extends State<CallForDonationData> {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     final double itemWidth = size.width - 30;
//     final double itemHeight = size.height - 48.h;
//     final double parentHeight = size.height / 1.2;
//     return SliverToBoxAdapter(
//       child: Sizer(builder: (context, orientation, deviceType) {
//         return SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10.0),
//             height: parentHeight,
//             child: FutureBuilder(
//               future: getCallForDonation(),
//               builder: (context, snapshot) {
//                 if (snapshot.data == null) {
//                   return Container(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 } else
//                   return ListView.builder(
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (context, i) {
//                         return Column(
//                           children: [
//                             Container(
//                               height: itemHeight,
//                               width: itemWidth,
//                               // padding: EdgeInsets.symmetric(horizontal: 20.0),
//                               // margin: EdgeInsets.only(bottom: 5),
//                               child: Card(
//                                 clipBehavior: Clip.antiAlias,
//                                 shape: RoundedRectangleBorder(
//                                     // borderRadius: BorderRadius.circular(24)
//                                     ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.only(left: 10),
//                                       child: Row(
//                                         children: [
//                                           Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 height: 12.0,
//                                               ),
//                                               CircleAvatar(
//                                                 radius: 25.0,
//                                                 backgroundImage: NetworkImage(
//                                                     'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg'),
//                                                 backgroundColor:
//                                                     Colors.transparent,
//                                               ),
//                                             ],
//                                           ),
//                                           Container(
//                                               child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 15.0, top: 5.0),
//                                                   child: Column(
//                                                     children: [
//                                                       SizedBox(
//                                                         width: 250,
//                                                         child: Text(
//                                                           'MHTP',
//                                                           maxLines: 1,
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               fontSize:
//                                                                   16.0.sp),
//                                                         ),
//                                                       ),
//                                                       SizedBox(height: 3.0),
//                                                       SizedBox(
//                                                         width: 250,
//                                                         child: Text(
//                                                             'Posted ' +
//                                                                 snapshot.data[i]
//                                                                     .date,
//                                                             maxLines: 1,
//                                                             style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w300,
//                                                                 fontSize:
//                                                                     10.sp)),
//                                                       )
//                                                     ],
//                                                   )))
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 12.0,
//                                     ),
//                                     Stack(
//                                       alignment: Alignment.center,
//                                       children: [
//                                         Ink.image(
//                                           image: NetworkImage(
//                                               snapshot.data[i].imgPath),
//                                           child: InkWell(
//                                             onTap: () async {
//                                               await showDialog(
//                                                 context: context,
//                                                 builder: (_) => Dialog(
//                                                     child: Container(
//                                                         width: 400,
//                                                         height: 400,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                                 image:
//                                                                     DecorationImage(
//                                                           image: NetworkImage(
//                                                               snapshot.data[i]
//                                                                   .imgPath),
//                                                           fit: BoxFit.cover,
//                                                         )))),
//                                               );
//                                             },
//                                           ),
//                                           height: 200,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(16.0)
//                                           .copyWith(bottom: 0),
//                                       child: Text(
//                                         snapshot.data[i].title,
//                                         style: TextStyle(
//                                             fontSize: 14.sp,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 6,
//                                     ),
//                                     Container(
//                                       height: 80,
//                                       child: IntrinsicHeight(
//                                         child: SingleChildScrollView(
//                                           scrollDirection: Axis.vertical,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(16.0)
//                                                 .copyWith(bottom: 0),
//                                             child: Text(
//                                               snapshot.data[i].description,
//                                               style: TextStyle(fontSize: 10.sp),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     _donateButton(context)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       });
//               },
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

Future<List<CallForDonation>> getCallForDonation() async {
  print('get call for donation');

  final response = await http.post(
      Uri.parse(
          "https://foodernity.herokuapp.com/donations/getCallForDonationsUnfulfilled"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}));

  List<CallForDonation> parsedCallforDonations = [];

  if (response.statusCode == 200) {
    List callforDonations = jsonDecode(response.body);

    for (var cfd in callforDonations) {
      parsedCallforDonations.add(CallForDonation.fromJSON(cfd));
    }
  }

  return parsedCallforDonations;
  // var jsonData = jsonDecode(response.body);
  // List<CallForDonation> announcements = [];

  // for (var u in jsonData) {
  //   // print(u);
  //   CallForDonation announcement = CallForDonation(u["callForDonationID"],
  //       u["title"], u["imgPath"], u["description"], u["date"]);
  //   announcements.add(announcement);
  // }
  // print(announcements.length);
  // return announcements;
}

// Widget _donationCall(profile, name, date, image, title, description, context) {
//   var callForDonationTitle = title;
//   var callForDonationDesc = description;
//   var callForDonationImage = image;
//   var orgImage = profile;
//   var orgName = name;
//   var postDate = date;
//   var size = MediaQuery.of(context).size;
//   final double itemWidth = size.width - 40;
//   final double itemHeight = size.height - 45.h;
//   // final double descHeight = size.height / 9;

//   return Sizer(builder: (context, orientation, deviceType) {
//     return Column(
//       children: [
//         Container(
//           height: itemHeight,
//           width: itemWidth,
//           // padding: EdgeInsets.symmetric(horizontal: 20.0),
//           // margin: EdgeInsets.only(bottom: 5),
//           child: Card(
//             clipBehavior: Clip.antiAlias,
//             shape: RoundedRectangleBorder(
//                 // borderRadius: BorderRadius.circular(24)
//                 ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(left: 10),
//                   child: Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 12.0,
//                           ),
//                           CircleAvatar(
//                             radius: 25.0,
//                             backgroundImage: NetworkImage(orgImage),
//                             backgroundColor: Colors.transparent,
//                           ),
//                         ],
//                       ),
//                       Container(
//                           child: Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 15.0, top: 5.0),
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     width: 250,
//                                     child: Text(
//                                       orgName,
//                                       maxLines: 1,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 16.0.sp),
//                                     ),
//                                   ),
//                                   SizedBox(height: 3.0),
//                                   SizedBox(
//                                     width: 250,
//                                     child: Text('Posted ' + postDate,
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w300,
//                                             fontSize: 13.sp)),
//                                   )
//                                 ],
//                               )))
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 12.0,
//                 ),
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Ink.image(
//                       image: NetworkImage(callForDonationImage),
//                       child: InkWell(
//                         onTap: () async {
//                           await showDialog(
//                             context: context,
//                             builder: (_) => Dialog(
//                                 child: Container(
//                                     width: 400,
//                                     height: 400,
//                                     decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                       image: NetworkImage(callForDonationImage),
//                                       fit: BoxFit.cover,
//                                     )))),
//                           );
//                         },
//                       ),
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
//                   child: Text(
//                     callForDonationTitle,
//                     style:
//                         TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Container(
//                   height: 100,
//                   child: IntrinsicHeight(
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
//                         child: Text(
//                           callForDonationDesc,
//                           style: TextStyle(fontSize: 10.sp),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 _donateButton(context)
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   });
// }

// Widget _donateButton(context) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 10),
//     child: ButtonBar(
//       alignment: MainAxisAlignment.start,
//       children: [
//         Align(
//           alignment: Alignment.bottomLeft,
//           child: FlatButton(
//             onPressed: () {
//               // showInformationDialog(context);
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CallForDonationDetails()));
//             },
//             minWidth: 55,
//             height: 35,
//             color: Colors.blue,
//             child: Text('More Details',
//                 style: TextStyle(
//                     fontSize: 13.0.sp,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.white)),
//             shape: RoundedRectangleBorder(
//                 side: BorderSide(
//                     color: Colors.blue, width: 1, style: BorderStyle.solid),
//                 borderRadius: BorderRadius.circular(2)),
//           ),
//         ),
//       ],
//     ),
//   );
// }
