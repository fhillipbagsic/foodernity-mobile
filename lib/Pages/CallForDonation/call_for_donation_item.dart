import 'package:flutter/material.dart';
import 'package:my_app/Models/CallForDonation.dart';
import 'package:my_app/Pages/CallForDonation/call_for_donation_detail.dart';
import 'package:sizer/sizer.dart';

class CtaItem extends StatefulWidget {
  final CallForDonation cta;

  const CtaItem({this.cta});

  @override
  State<CtaItem> createState() => _CtaItemState();
}

class _CtaItemState extends State<CtaItem> {
  Image myImage;

  @override
  void initState() {
    myImage = Image.network(widget.cta.imgPath);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(myImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CallForDonationDetails(
                      callForDonation: widget.cta,
                    )),
          );
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 13),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                Image.network(
                  widget.cta.imgPath,
                  width: 100.w,
                ),
                _details(widget.cta.title, widget.cta.description)
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget _header() {
  return Container(
    margin: EdgeInsets.all(15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
              'https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg'),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MHTP',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              'November 03, 2021',
              style: TextStyle(fontSize: 11.sp),
            )
          ],
        )
      ],
    ),
  );
}

Widget _details(String title, String description) {
  return Container(
    margin: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 5,
        ),
        Text(
          description,
          style: TextStyle(fontSize: 11.sp),
          maxLines: 3,
        )
      ],
    ),
  );
}
