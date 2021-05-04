import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Widgets/NavigationBar.dart';
import 'package:my_app/styles.dart';

class Listings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            NavigationBar(
              title: 'Donations',
            ),
            _container(),
            ListingsContainer()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: ColorPrimary,
      ),
    );
  }
}

Widget _container() {
  return (SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _filter(),
          _listingCount(),
        ],
      ),
    ),
  ));
}

Widget _filter() {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [Text('Available Now'), Icon(Icons.arrow_drop_down)],
      ),
      TextButton(onPressed: () {}, child: Text('FILTER')),
    ],
  ));
}

Widget _listingCount() {
  return (Text(
    '18 listings near you',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
  ));
}

class ListingsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 3.9;
    final double itemWidth = size.width / 2;
    return SliverPadding(
      padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      sliver: (SliverGrid.count(
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        crossAxisCount: 2,
        children: [
          _listingItem(),
          _listingItem(),
          _listingItem(),
          _listingItem(),
          _listingItem(),
          _listingItem(),
          _listingItem(),
          _listingItem(),
          _listingItem()
        ],
      )),
    );
  }
}

// Widget _listingsContainer() {
//   return SliverPadding(
//     padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
//     sliver: (SliverGrid.count(
//       crossAxisSpacing: 5.0,
//       mainAxisSpacing: 5.0,
//       crossAxisCount: 2,
//       children: [_listingItem(), _listingItem(), _listingItem()],
//     )),
//   );
// }

Widget _listingItem() {
  // name, image, distance, time
  // var donationImage = image;
  // var donationName = name;
  // var donationDistance = distance;
  // var donationTime = time;

  return (Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Image(
            fit: BoxFit.fitWidth,
            height: 130,
            width: double.infinity,
            image: NetworkImage(
                'https://c1.staticflickr.com/5/4158/33593402264_bedafb79d1_c.jpg'),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          padding: EdgeInsets.only(left: 7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pancit Canton Noodles',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 3.0,
              ),
              Wrap(
                children: [
                  Icon(
                    Icons.place_sharp,
                    size: 14.0,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    '3 kilometers away',
                    style: TextStyle(fontSize: 13.0),
                  )
                ],
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                'Posted 3h ago',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
            ],
          ),
        )
      ],
    ),
  ));
}
