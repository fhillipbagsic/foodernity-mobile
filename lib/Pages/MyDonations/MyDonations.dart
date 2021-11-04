import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:my_app/Pages/MyDonations/Donation.dart';
import 'package:my_app/Pages/MyDonations/donation_item.dart';

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
  List<Donation> donations = [
    Donation(
        donationID: 1,
        donationName: 'Pancit Canton',
        dateTimePosted: '2021-10-17 19:53:57.175818',
        donationCategories: ['Instant Noodles', 'Canned Goods'],
        donationQuantities: [5, 10],
        donationExpiries: ['2021-10-17', '2021-10-17'],
        imgPath:
            'https://upload.wikimedia.org/wikipedia/commons/b/b0/Lucky_Me%21_Pancit_Canton_instant_noodles_%28Philippines%29.jpg',
        status: 'pending'),
    Donation(
        donationID: 2,
        donationName: 'Assorted Canned Goods',
        dateTimePosted: '2021-10-17 19:53:57.175818',
        donationCategories: ['Canned Goods'],
        donationQuantities: [5],
        donationExpiries: ['2021-10-17'],
        imgPath:
            'https://ph-test-11.slatic.net/p/7375d11f5a5c0384da4acda3c7b66c8f.jpg',
        status: 'accepted'),
    Donation(
        donationID: 3,
        donationName: 'Assorted Canned Goods',
        dateTimePosted: '2021-10-17 19:53:57.175818',
        donationCategories: ['Instant Noodles'],
        donationQuantities: [5],
        donationExpiries: ['2021-10-17'],
        imgPath:
            'https://ph-test-11.slatic.net/p/7375d11f5a5c0384da4acda3c7b66c8f.jpg',
        status: 'onhand'),
    Donation(
        donationID: 4,
        donationName: 'Assorted Canned Goods',
        dateTimePosted: '2021-10-17 19:53:57.175818',
        donationCategories: ['Instant Noodles'],
        donationQuantities: [5],
        donationExpiries: ['2021-10-17'],
        imgPath:
            'https://ph-test-11.slatic.net/p/7375d11f5a5c0384da4acda3c7b66c8f.jpg',
        status: 'distributed'),
  ];
  List values = [
    'Pending Donations',
    'Accepted Donations',
    'Received Donations',
    'Distributed Donations'
  ];

  int selectedValue = 0;

  void sortDonations(String value) {
    List<Donation> newDonations = [];

    var sortWord = value.split(' ')[0].toLowerCase();

    print(sortWord);
    donations.forEach((element) {
      if (element.status == sortWord) {
        newDonations.add(element);
      }
    });

    donations.forEach((element) {
      if (element.status != sortWord) {
        newDonations.add(element);
      }
    });

    donations = newDonations;
  }

  showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (value) {
                setState(() {
                  print(value);
                  selectedValue = value;
                  sortDonations(values[value]);
                });
              },
              children: const [
                Text('Pending Donations'),
                Text('Accepted Donations'),
                Text('Received Donations'),
                Text('Distributed Donations'),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(238, 238, 238, 1),
          child: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text('My Donations'),
              ),
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: GestureDetector(
                    onTap: showPicker,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromRGBO(33, 150, 243, 1),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 1.0,
                                color: Color.fromRGBO(0, 0, 0, .1))
                          ]),
                      child: Text(
                        'Sort by: ' + values[selectedValue],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              _getSlivers(donations, context)
            ],
          ),
        ),
      ),
    );
  }
}

SliverList _getSlivers(List<Donation> donations, BuildContext context) {
  return SliverList(
    delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return DonationItem(
        donation: donations[index],
      );
    }, childCount: donations.length),
  );
}
