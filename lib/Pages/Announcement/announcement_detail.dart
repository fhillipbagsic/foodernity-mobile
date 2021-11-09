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
                    _recipients(widget.announcement.donationRecipient),
                    _date(widget.announcement.date),
                    _remarks(widget.announcement.donationRemarks),
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
  );
}

Widget _date(String date) {
  return Card(
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
          'Donations donated on ' + date,
          style: TextStyle(fontSize: 16, color: Colors.green[400]),
        ),
      ),
    ),
  );
}

Widget _remarks(String remarks) {
  return Card(
    child: Container(
      margin: EdgeInsets.all(15),
      width: 90.w,
      child: Column(
        children: [
          Text(
            'Organizations Remarks',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(remarks)
        ],
      ),
    ),
  );
}

// _cardView(context)
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

  return SingleChildScrollView(
    child: Container(
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
                        style:
                            TextStyle(fontSize: 16, color: Colors.green[400]),
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
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10.0),
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
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10.0),
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
                                                  margin: EdgeInsets.only(
                                                      top: 10.0),
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      top: 6,
                                                      bottom: 6,
                                                    ),
                                                    child: Text(
                                                      donGoods,
                                                      textAlign:
                                                          TextAlign.center,
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
    ),
  );
}
