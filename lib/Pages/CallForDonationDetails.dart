import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:my_app/Pages/Home/CallForDonations.dart';

class CallForDonationDetails extends StatefulWidget {
  const CallForDonationDetails({Key key}) : super(key: key);
  static String routeName = "/CallForDonationDetails";

  @override
  _CallForDonationDetailsState createState() => _CallForDonationDetailsState();
}

class _CallForDonationDetailsState extends State<CallForDonationDetails> {
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
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestListing()));
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
  var height = MediaQuery.of(context).size.height / 3;
  var imgHeight = MediaQuery.of(context).size.height / 2.5;
  var btnWidth = MediaQuery.of(context).size.width - 40;
  var img = 'http://gsb.ateneo.edu/wp-content/uploads/2020/11/Rolly-1.jpg';
  var beneficiaries =
      'Call For Donation for the victims of Super Typhoon Rolly';
  var remarks =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. A mattis enim sagittis, eget ante justo massa. Duis amet eget id fames nisi, dolor et quis senectus. ';

  return SingleChildScrollView(
    child: Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            width: width,
            height: imgHeight,
            child: InkWell(
              child: Image.network(
                img,
                fit: BoxFit.cover,
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (_) => Dialog(
                      child: Container(
                          width: 500,
                          height: 600,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          )))),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              children: [
                Card(
                  color: Colors.orange[50],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange, width: 1.5),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  margin: EdgeInsets.all(10.0),
                  child: Container(
                    child: ListTile(
                      leading: Icon(
                        Icons.announcement_sharp,
                        size: 28.0,
                        color: Colors.orange[400],
                      ),
                      title: Text(
                        beneficiaries,
                        style:
                            TextStyle(fontSize: 16, color: Colors.orange[400]),
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
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10.0),
                              child: ListTile(
                                title: Text(
                                  'More Details',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10),
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                    child: FlatButton(
                  onPressed: () {
                    print('buttonclick');
                  },
                  color: Colors.blue,
                  minWidth: btnWidth,
                  height: 45,
                  child:
                      Text('Donate Now', style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.blue,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                ))
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
