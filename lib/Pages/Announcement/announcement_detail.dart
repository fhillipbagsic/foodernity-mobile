import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/Announcement.dart';
import 'package:my_app/Pages/Announcement/announcement.dart';
import 'package:sizer/sizer.dart';

class ListingDetails extends StatefulWidget {
  final Announcement announcement;
  const ListingDetails({this.announcement});
  static String routeName = "/RecentDonationDetails";

  @override
  _ListingDetailsState createState() => _ListingDetailsState();
}

class _ListingDetailsState extends State<ListingDetails> {
  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _donationImage(widget.announcement.donationImage),
                    SizedBox(
                      height: 15.0,
                    ),
                    _recipients(widget.announcement.donationRecipient),
                    _date(widget.announcement.date),
                    _location(widget.announcement.recipientLocation),
                    SizedBox(
                      height: 15.0,
                    ),
                    _remarks(widget.announcement.donationRemarks),
                    _getDonations(widget.announcement.donationCategory,
                        widget.announcement.donationQuantity)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget _donationImage(String donationImage) {
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    width: 100.w,
    child: Image.network(
      donationImage,
      fit: BoxFit.fitWidth,
    ),
  );
}

Widget _recipients(String beneficiaries) {
  return Card(
    color: Colors.blue[50],
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.blue, width: 1),
      borderRadius: BorderRadius.circular(7.0),
    ),
    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
    child: Container(
      child: ListTile(
        leading: Icon(
          Icons.people_sharp,
          size: 30.0,
          color: Colors.blue[400],
        ),
        title: Text(
          'Benefiaries: Residents of ' + beneficiaries.trim() + '.',
          style: TextStyle(fontSize: 16, color: Colors.blue[400]),
        ),
      ),
    ),
  );
}

Widget _date(String date) {
  return Card(
    color: Colors.green[50],
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.green, width: 1),
      borderRadius: BorderRadius.circular(7.0),
    ),
    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
    child: Container(
      child: ListTile(
        leading: Icon(
          Icons.timer_sharp,
          size: 30.0,
          color: Colors.green[400],
        ),
        title: Text(
          'Donated on ' + date.trim() + '.',
          style: TextStyle(fontSize: 16, color: Colors.green[400]),
        ),
      ),
    ),
  );
}

Widget _location(String recipientLocation) {
  return Card(
    color: Colors.orange[50],
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.orange, width: 1),
      borderRadius: BorderRadius.circular(7.0),
    ),
    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
    child: Container(
      child: ListTile(
        leading: Icon(
          Icons.place_rounded,
          size: 30.0,
          color: Colors.orange[400],
        ),
        title: Text(
          recipientLocation.trim(),
          style: TextStyle(fontSize: 16, color: Colors.orange[400]),
        ),
      ),
    ),
  );
}

Widget _remarks(String description) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      width: 100.w,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Organization's Remarks",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 11.sp),
            // textAlign: TextAlign.start,
          )
        ],
      ),
    ),
  );
}

Widget _getDonations(List donationCategories, List donationQuantities) {
  List<Widget> donations = [];

  for (var i = 0; i < donationCategories.length; i++) {
    donations.add(_donationItems(donationCategories[i], donationQuantities[i]));
  }

  return Card(
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Donated Items",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            Column(
              children: donations,
            ),
          ],
        )),
  );
}

Widget _donationItems(String category, String quantity) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _chip(category),
      SizedBox(
        width: 15,
      ),
      _quantity(quantity)
    ],
  );
}

Widget _chip(String category) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(33, 150, 243, 1),
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(color: Colors.white, fontSize: 10.sp),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget _quantity(count) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1.0,
            offset: Offset(0, 1),
            color: Color.fromRGBO(0, 0, 0, .1),
          ),
        ],
      ),
      height: 35,
      child: Center(
        child: Text(
          count.toString() + ' pc/s',
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 10.sp),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

// // _cardView(context)
// Widget _cardView(context) {
//   var width = MediaQuery.of(context).size.width;
//   var height = MediaQuery.of(context).size.height / 4;
//   var imgHeight = MediaQuery.of(context).size.height / 3;
//   var donationGoodsHeight = MediaQuery.of(context).size.height / 6;
//   var img =
//       'https://psu.edu.ph/wp-content/uploads/2020/11/125760987_1831764043637981_8035397335388690116_n.jpg';
//   var beneficiaries = 'Barangay 403';
//   var donatedGoods = 'November 05, 2021';
//   var remarks =
//       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. ';
//   var donGoods = 'Instant Noodles';

//   return SingleChildScrollView(
//     child: Container(
//       child: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 20.0),
//             width: width,
//             height: imgHeight,
//             child: Image.network(
//               img,
//               fit: BoxFit.fitWidth,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
//             child: Column(
//               children: [
//                 Card(
//                   color: Colors.blue[50],
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.blue, width: 1.5),
//                     borderRadius: BorderRadius.circular(7.0),
//                   ),
//                   margin: EdgeInsets.all(10.0),
//                   child: Container(
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.people_sharp,
//                         size: 30.0,
//                         color: Colors.blue[400],
//                       ),
//                       title: Text(
//                         'Benefiaries: Residents of ' + beneficiaries,
//                         style: TextStyle(fontSize: 16, color: Colors.blue[400]),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Card(
//                   color: Colors.green[50],
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.green, width: 1.5),
//                     borderRadius: BorderRadius.circular(7.0),
//                   ),
//                   margin: EdgeInsets.all(10.0),
//                   child: Container(
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.timer_sharp,
//                         size: 30.0,
//                         color: Colors.green[400],
//                       ),
//                       title: Text(
//                         'Donations donated on ' + donatedGoods,
//                         style:
//                             TextStyle(fontSize: 16, color: Colors.green[400]),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: height,
//                   child: Card(
//                     margin: EdgeInsets.all(10.0),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(7.0)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 10, bottom: 10.0),
//                                 child: ListTile(
//                                   title: Text(
//                                     'Organizations Remarks',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16),
//                                   ),
//                                   subtitle: Container(
//                                     margin: const EdgeInsets.only(top: 5),
//                                     height: 120.0,
//                                     child: SingleChildScrollView(
//                                       scrollDirection: Axis.vertical,
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(top: 5),
//                                         child: Text(
//                                           remarks,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w300,
//                                               fontSize: 13.0,
//                                               color: Colors.grey[600]),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: donationGoodsHeight,
//                   child: Card(
//                     margin: EdgeInsets.all(10.0),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(7.0)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 10, bottom: 10.0),
//                                 child: ListTile(
//                                   title: Text(
//                                     'Donated Goods',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 18),
//                                   ),
//                                   subtitle: Padding(
//                                     padding: const EdgeInsets.only(top: 5),
//                                     child: Container(
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Container(
//                                                 height: 35,
//                                                 width: 110,
//                                                 margin:
//                                                     EdgeInsets.only(right: 10),
//                                                 child: Card(
//                                                   color: Colors.blue,
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10.0),
//                                                   ),
//                                                   margin: EdgeInsets.only(
//                                                       top: 10.0),
//                                                   child: Container(
//                                                     margin: EdgeInsets.only(
//                                                       top: 6,
//                                                       bottom: 6,
//                                                     ),
//                                                     child: Text(
//                                                       donGoods,
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       style: TextStyle(
//                                                           fontSize: 13,
//                                                           color: Colors.white),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
