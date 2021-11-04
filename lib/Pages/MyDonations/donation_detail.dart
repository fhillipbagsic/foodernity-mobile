import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/Pages/MyDonations/Donation.dart';
import 'package:sizer/sizer.dart';

class DonationDetail extends StatelessWidget {
  final Donation donation;
  const DonationDetail({Key key, this.donation}) : super(key: key);

  void getDate() {
    var date = DateTime.parse(donation.dateTimePosted);

    print(date.month);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        home: Scaffold(
          appBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              color: Colors.black,
              onPressed: () => Navigator.pop(context),
            ),
            transitionBetweenRoutes: true,
            middle: Text('Donation Details'),
          ),
          body: SafeArea(
            child: Container(
              color: Color.fromRGBO(245, 245, 245, 1),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    width: 100.w,
                    height: 25.h,
                    child: Image.network(
                      donation.imgPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  _getAlert(donation.status),
                  _getDetails(donation.status),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      donation.donationName,
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Food categories to be donated:',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.0),
                            child: Text('Category',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.0),
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                  fontSize: 11.sp, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.0),
                            child: Text('Earliest Expiry',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.0),
                            child: Column(
                              children:
                                  _getCategories(donation.donationCategories),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 3.0),
                              child: Column(
                                children:
                                    _getQuantities(donation.donationQuantities),
                              )),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 3.0),
                            child: Column(
                              children: _getExpiries(
                                donation.donationExpiries,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _dateTimePosted(donation.dateTimePosted)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget _getAlert(String status) {
  switch (status) {
    case 'pending':
      return _alert(
          Color.fromRGBO(33, 150, 243, 1),
          Color.fromRGBO(33, 150, 243, .1),
          Icons.hourglass_full_rounded,
          'You will be notified once your donation has been accepted so you can proceed to deliver it');
    case 'accepted':
      return _alert(
          Color.fromRGBO(102, 187, 106, 1),
          Color.fromRGBO(102, 187, 106, .1),
          Icons.check_circle_rounded,
          'You can now proceed to deliver your donations. Please refer to the opening hours and the address below: ');
    case 'onhand':
      return _alert(
          Color.fromRGBO(255, 167, 38, 1),
          Color.fromRGBO(255, 167, 38, .1),
          Icons.inventory,
          'Your donation has already been received by the organization. You will be notified once your donation has been distributed.');
    case 'distributed':
      return _alert(
          Color.fromRGBO(229, 115, 115, 1),
          Color.fromRGBO(229, 115, 115, .1),
          Icons.volunteer_activism,
          'Your donation has been donated to Bantay Bata! We would extend our sincere');
    default:
      return _alert(Color.fromRGBO(229, 115, 115, 1),
          Color.fromRGBO(229, 115, 115, 1), Icons.warning, 'Error');
  }
}

Widget _alert(Color color, Color backgroundColor, icon, text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    padding: EdgeInsets.all(10.0),
    width: 90.w,
    decoration: BoxDecoration(
      border: Border.all(
        color: color,
      ),
      borderRadius: BorderRadius.circular(5.0),
      color: backgroundColor,
    ),
    child: Row(
      children: [
        Icon(
          icon,
          size: 17.sp,
          color: color,
        ),
        SizedBox(
          width: 5.0,
        ),
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 10.sp),
          ),
        )
      ],
    ),
  );
}

Widget _getDetails(String status) {
  if (status == 'accepted') {
    return Column(
      children: [_timeDetails(), _locationDetails()],
    );
  }

  return SizedBox();
}

List _getCategories(List donationCategories) {
  return donationCategories.map((e) => _chip(e)).toList();
}

List _getQuantities(List donationQuantities) {
  return donationQuantities.map((e) => _quantity(e)).toList();
}

List _getExpiries(List donationExpiries) {
  return donationExpiries.map((e) => _expiry(e)).toList();
}

Widget _chip(String category) {
  Color color;

  switch (category.toLowerCase()) {
    case 'canned goods':
      color = Color.fromRGBO(33, 150, 243, 1);
      break;
    case 'instant noodles':
      color = Color.fromRGBO(33, 150, 243, 1);
      break;
    default:
      color = Colors.black;
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 11.0),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: color,
    ),
    child: Center(
      child: Text(
        category,
        style: TextStyle(color: Colors.white, fontSize: 8.sp),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _quantity(count) {
  return Container(
    margin: EdgeInsets.all(5.0),
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
        style:
            TextStyle(color: Color.fromRGBO(132, 132, 132, 1), fontSize: 10.sp),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _expiry(donationExpiry) {
  return Container(
    margin: EdgeInsets.all(5.0),
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
        donationExpiry,
        style:
            TextStyle(color: Color.fromRGBO(132, 132, 132, 1), fontSize: 10.sp),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _dateTimePosted(dateTime) {
  var date = DateTime.parse(dateTime);
  var month = date.month;
  var day = date.day;
  var year = date.year;

  var hour = date.hour;
  var minute = date.minute;

  List months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  var formattedDate =
      months[month] + ' ' + day.toString() + ', ' + year.toString();

  var formattedTime = (hour > 12
          ? (hour - 12).toString()
          : hour == 0
              ? '12'
              : hour.toString()) +
      ":" +
      minute.toString() +
      (hour > 12 ? ' PM' : ' AM') +
      '.';
  return Container(
    margin: EdgeInsets.only(top: 40),
    child: Text(
      'Donation made on ' + formattedDate + ' at ' + formattedTime,
      style: TextStyle(
          color: Color.fromRGBO(170, 170, 170, 1), fontStyle: FontStyle.italic),
    ),
  );
}

Widget _locationDetails() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    width: 90.w,
    decoration: BoxDecoration(
      border: Border.all(
        color: Color.fromRGBO(102, 187, 106, 1),
      ),
      borderRadius: BorderRadius.circular(5.0),
      color: Color.fromRGBO(102, 187, 106, .1),
    ),
    child: Row(
      children: [
        Icon(
          Icons.place_rounded,
          size: 17.sp,
          color: Color.fromRGBO(102, 187, 106, 1),
        ),
        SizedBox(
          width: 5.0,
        ),
        Flexible(
          child: Text(
            'Balic-Balic, Calabash Rd, Sampaloc, Manila',
            style: TextStyle(
                color: Color.fromRGBO(102, 187, 106, 1), fontSize: 10.sp),
          ),
        )
      ],
    ),
  );
}

Widget _timeDetails() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    width: 90.w,
    decoration: BoxDecoration(
      border: Border.all(
        color: Color.fromRGBO(102, 187, 106, 1),
      ),
      borderRadius: BorderRadius.circular(5.0),
      color: Color.fromRGBO(102, 187, 106, .1),
    ),
    child: Row(
      children: [
        Icon(
          Icons.schedule,
          size: 17.sp,
          color: Color.fromRGBO(102, 187, 106, 1),
        ),
        SizedBox(
          width: 5.0,
        ),
        Flexible(
          child: Text(
            'Monday to Friday, 8AM to 5PM.',
            style: TextStyle(
                color: Color.fromRGBO(102, 187, 106, 1), fontSize: 10.sp),
          ),
        )
      ],
    ),
  );
}
