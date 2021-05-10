import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Widgets/NavigationBar.dart';
import 'package:my_app/styles.dart';

class Listings extends StatefulWidget {
  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AccountDrawer(),
      key: scaffoldKey,
      body: SafeArea(
        child: CustomScrollView(
          //physics: ClampingScrollPhysics(),
          slivers: [
            NavigationBar(
              title: 'Donations',
              scaffold: scaffoldKey,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _filter(context),
                    _listingCount(),
                  ],
                ),
              ),
            ),
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

Widget _filter(context) {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return _filterPicker();
              });
        },
        child: Row(
          children: [Text('Available Now'), Icon(Icons.arrow_drop_down)],
        ),
      ),
      TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return (_filterSheet());
                });
          },
          child: Text('FILTER')),
    ],
  ));
}

Widget _filterPicker() {
  return Container(
    height: 250.0,
    child: (CupertinoPicker(
      useMagnifier: true,
      onSelectedItemChanged: (index) {},
      itemExtent: 50.0,
      backgroundColor: Colors.white,
      children: [
        Center(child: Text('Available Now')),
        Center(child: Text('Suggested')),
        Center(child: Text('Nearest')),
      ],
    )),
  );
}

Widget _filterSheet() {
  return Container(
    height: 500.0,
    child: (Column(
      children: [
        // Text('My Location'),
        // ListTile(
        //   leading: Icon(
        //     Icons.location_on_rounded,
        //   ),
        //   title: Text('Bali Oasis, Pasig'),
        //   trailing: Icon(Icons.edit_rounded),
        // )
      ],
    )),
  );
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
          _listingItem('Pancit Canton Noodles',
              'https://c1.staticflickr.com/5/4158/33593402264_bedafb79d1_c.jpg'),
          _listingItem('Assorted Canned Goods',
              'https://cf.shopee.com.my/file/090a18a75c04ad1d4e0f63421a5c8651'),
          _listingItem('Ligo Sardines',
              'https://i.ebayimg.com/images/g/pz8AAOSwIt5enLLV/s-l300.jpg'),
          _listingItem('1 sack rice',
              'https://media.karousell.com/media/photos/products/2020/8/7/oishi_japanese_rice_1_sack_25k_1596774674_9992bf29_progressive.jpg'),
          _listingItem('Butter Sticks',
              'https://ph-test-11.slatic.net/p/abada0fd5d956a99f99d0f2ebebdd974.jpg'),
          _listingItem('Vegetables',
              'https://cdn.shopify.com/s/files/1/1533/6775/products/stjune11_grande.jpg?v=1613709550'),
          _listingItem('1 tray of eggs',
              'https://www.bultuhan.com/images/detailed/10/ZAY---F0001.jpg'),
          _listingItem('Pancit Canton Noodles',
              'https://c1.staticflickr.com/5/4158/33593402264_bedafb79d1_c.jpg'),
          _listingItem('Assorted Canned Goods',
              'https://cf.shopee.com.my/file/090a18a75c04ad1d4e0f63421a5c8651'),
          _listingItem('Ligo Sardines',
              'https://i.ebayimg.com/images/g/pz8AAOSwIt5enLLV/s-l300.jpg'),
          _listingItem('1 sack rice',
              'https://media.karousell.com/media/photos/products/2020/8/7/oishi_japanese_rice_1_sack_25k_1596774674_9992bf29_progressive.jpg'),
          _listingItem('Butter Sticks',
              'https://ph-test-11.slatic.net/p/abada0fd5d956a99f99d0f2ebebdd974.jpg'),
          _listingItem('Vegetables',
              'https://cdn.shopify.com/s/files/1/1533/6775/products/stjune11_grande.jpg?v=1613709550'),
          _listingItem('1 tray of eggs',
              'https://www.bultuhan.com/images/detailed/10/ZAY---F0001.jpg'),
        ],
      )),
    );
  }
}

Widget _listingItem(name, image) {
  // name, image, distance, time
  var donationImage = image;
  var donationName = name;
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
            image: NetworkImage(donationImage),
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
                donationName,
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
