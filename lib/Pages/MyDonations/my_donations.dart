import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/Donation.dart';
import 'package:my_app/Pages/MyDonations/donation_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Pages/PostDonation/post_donation.dart';

class MyDonations extends StatefulWidget {
  @override
  _MyDonationsState createState() => _MyDonationsState();
}

class _MyDonationsState extends State<MyDonations> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        home: App(),
      );
    });
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future<List<Donation>> futureDonations;

  @override
  void initState() {
    super.initState();
    futureDonations = fetchDonations();
  }

  List values = [
    'Pending Donations',
    'Accepted Donations',
    'Received Donations',
  ];

  int selectedValue = 0;

  Future<List<Donation>> fetchDonations() async {
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("userID");
    print(userID);
    print('fetch');
    final response = await http.post(
        Uri.parse(
          'https://foodernity.herokuapp.com/donations/getDonationsFor',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, int>{
            'donorID': userID,
          },
        ));

    List<Donation> parsedDonations = [];
    if (response.statusCode == 200) {
      List donations = jsonDecode(response.body);
      print(donations.length);
      for (var donation in donations) {
        donation['donationCategories'] = donation['donationCategories']
            .toString()
            .substring(1, donation['donationCategories'].toString().length - 1)
            .split(', ');
        donation['donationQuantities'] = donation['donationQuantities']
            .toString()
            .substring(1, donation['donationQuantities'].toString().length - 1)
            .split(', ');

        parsedDonations.add(Donation.fromJSON(donation));
      }
    }

    return parsedDonations;
  }

  // sortDonations(String value) {
  //   Future<List<Donation>> newDonations = [];

  //   var sortWord = value.split(' ')[0].toLowerCase();

  //   print(sortWord);
  //   futureDonations.then((value) => value.forEach((element) {
  //         if (element.status == sortWord) {
  //           newDonations.add(element);
  //         }
  //       }));

  //   futureDonations.then((value) => value.forEach((element) {
  //         if (element.status != sortWord) {
  //           newDonations.add(element);
  //         }
  //       }));

  //   futureDonations = newDonations;
  // }

  // showPicker() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CupertinoPicker(
  //             itemExtent: 32.0,
  //             onSelectedItemChanged: (value) {
  //               setState(() {
  //                 print(value);
  //                 selectedValue = value;
  //                 sortDonations(values[value]);
  //               });
  //             },
  //             children: const [
  //               Text('Pending Donations'),
  //               Text('Accepted Donations'),
  //               Text('Received Donations'),
  //               Text('Distributed Donations'),
  //             ]);
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(238, 238, 238, 1),
          child: FutureBuilder<List<Donation>>(
            future: futureDonations,
            builder: (context, snapshot) {
              Widget donationsSliverList;
              if (snapshot.hasData) {
                donationsSliverList = SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return DonationItem(
                      donation: snapshot.data[index],
                    );
                  }, childCount: snapshot.data.length),
                );
              } else {
                donationsSliverList = SliverToBoxAdapter(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    leading: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Back'),
                    ),
                    largeTitle: Text('My Donations'),
                  ),
                  donationsSliverList
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
