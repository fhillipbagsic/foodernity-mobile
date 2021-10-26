import 'package:flutter/material.dart';
import 'package:my_app/Widgets/NavigationBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: AccountDrawer(),
      key: scaffoldKey,
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            NavigationBar(
              title: 'Notifications',
              scaffold: scaffoldKey,
            ),
            NotificationCount()
          ],
        ),
      ),
    );
  }
}

class NotificationCount extends StatefulWidget {
  const NotificationCount({Key key}) : super(key: key);

  @override
  _NotificationCountState createState() => _NotificationCountState();
}

class _NotificationCountState extends State<NotificationCount> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 11.2;
    final double itemWidth = size.width - 1;

    return SliverPadding(
      padding: EdgeInsets.only(top: 20.0),
      sliver: (SliverGrid.count(
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        crossAxisCount: 1,
        children: [
          _buildNotification(
              // 'https://cf.shopee.com.my/file/090a18a75c04ad1d4e0f63421a5c8651',
              'Pancit Canton',
              'The foodbank accepted your donation'),
          _buildNotification(
              // 'https://cf.shopee.com.my/file/090a18a75c04ad1d4e0f63421a5c8651',
              'Pancit Canton',
              'The foodbank accepted your donation'),
          _buildNotification(
              // 'https://cf.shopee.com.my/file/090a18a75c04ad1d4e0f63421a5c8651',
              'Bread',
              'The foodbank accepted your donation'),
        ],
      )),
    );
  }
}

Widget _buildNotification(title, description) {
  // var notifImage = image;
  var notifTitle = title;
  var notifDesc = description;
  return Sizer(
    builder: (context, orientation, deviceType) {
      return Container(
        // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
        child: Column(
          children: [
            ListTile(
              leading: ClipOval(
                child: Container(
                  child: Image.asset(
                    'assets/images/email_open.png',
                    color: Colors.grey[400],
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(notifTitle,
                  style: TextStyle(
                      // fontFamily: 'roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
              subtitle: Text(notifDesc,
                  style: TextStyle(
                      // fontFamily: 'RobotoMono-Regular',
                      fontWeight: FontWeight.normal,
                      fontSize: 13.0,
                      color: Colors.black)),
            ),
          ],
        ),
      );
    },
  );
}

  // ListTile(
          //   leading: ClipOval(
          //     child: Container(
          //       child: Image.network(
          //         'https://cf.shopee.com.my/file/090a18a75c04ad1d4e0f63421a5c8651',
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   title: Text('Request Approved',
          //       style: TextStyle(
          //           // fontFamily: 'roboto',
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18.0)),
          //   subtitle: Text(
          //       'Fhilip Accepted your listing request. Click to view more.',
          //       style: TextStyle(
          //           // fontFamily: 'RobotoMono-Regular',
          //           fontWeight: FontWeight.normal,
          //           fontSize: 13.0,
          //           color: Colors.black)),
          // ),
          // ListTile(
          //   leading: ClipOval(
          //     child: Container(
          //       child: Image.network(
          //         'https://i.ebayimg.com/images/g/pz8AAOSwIt5enLLV/s-l300.jpg',
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   title: Text('New Message',
          //       style: TextStyle(
          //           // fontFamily: 'roboto',
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18.0)),
          //   subtitle: Text('Julia Request message you regarding your listing.',
          //       style: TextStyle(
          //           // fontFamily: 'RobotoMono-Regular',
          //           fontWeight: FontWeight.normal,
          //           fontSize: 13.0,
          //           color: Colors.black)),
          // ),
          // ListTile(
          //   leading: ClipOval(
          //     child: Container(
          //       child: Image.network(
          //         'https://media.karousell.com/media/photos/products/2020/8/7/oishi_japanese_rice_1_sack_25k_1596774674_9992bf29_progressive.jpg',
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   title: Text('New Request',
          //       style: TextStyle(
          //           // fontFamily: 'roboto',
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18.0)),
          //   subtitle: Text(
          //       'Julia Request your listing Ligo Sardines. Click to view more.',
          //       style: TextStyle(
          //           // fontFamily: 'RobotoMono-Regular',
          //           fontWeight: FontWeight.normal,
          //           fontSize: 13.0,
          //           color: Colors.black)),
          // ),
          // ListTile(
          //   leading: ClipOval(
          //     child: Container(
          //       child: Image.network(
          //         'https://ph-test-11.slatic.net/p/abada0fd5d956a99f99d0f2ebebdd974.jpg',
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   title: Text('Listing Request',
          //       style: TextStyle(
          //           // fontFamily: 'roboto',
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18.0)),
          //   subtitle: Text(
          //       'Julia Request your listing Lucky Me Noodles. Click to view more.',
          //       style: TextStyle(
          //           // fontFamily: 'RobotoMono-Regular',
          //           fontWeight: FontWeight.normal,
          //           fontSize: 13.0,
          //           color: Colors.black)),
          // ),
          // ListTile(
          //   leading: ClipOval(
          //     child: Container(
          //       child: Image.network(
          //         'https://cdn.shopify.com/s/files/1/1533/6775/products/stjune11_grande.jpg?v=1613709550',
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   title: Text('Request Approved',
          //       style: TextStyle(
          //           // fontFamily: 'roboto',
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18.0)),
          //   subtitle: Text(
          //       'Julia Request your listing Lucky Me Noodles. Click to view more.',
          //       style: TextStyle(
          //           // fontFamily: 'RobotoMono-Regular',
          //           fontWeight: FontWeight.normal,
          //           fontSize: 13.0,
          //           color: Colors.black)),
          // ),
          // ListTile(
          //   leading: ClipOval(
          //     child: Container(
          //       child: Image.network(
          //         'https://www.bultuhan.com/images/detailed/10/ZAY---F0001.jpg',
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   title: Text('New Message',
          //       style: TextStyle(
          //           // fontFamily: 'roboto',
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18.0)),
          //   subtitle: Text(
          //       'Julia Request your listing Lucky Me Noodles. Click to view more.',
          //       style: TextStyle(
          //           // fontFamily: 'RobotoMono-Regular',
          //           fontWeight: FontWeight.normal,
          //           fontSize: 13.0,
          //           color: Colors.black)),
          // ),
          // ListTile(
          //   leading: ClipOval(
          //     child: Container(
          //       child: Image.network(
          //         'https://c1.staticflickr.com/5/4158/33593402264_bedafb79d1_c.jpg',
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   title: Text('New Request',
          //       style: TextStyle(
          //           // fontFamily: 'roboto',
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18.0)),
          //   subtitle: Text(
          //       'Julia Request your listing Lucky Me Noodles. Click to view more.',
          //       style: TextStyle(
          //           // fontFamily: 'RobotoMono-Regular',
          //           fontWeight: FontWeight.normal,
          //           fontSize: 13.0,
          //           color: Colors.black)),
          // ),
          // ListTile(
          //   leading: ClipOval(
          //     child: Container(
          //       child: Image.network(
          //         'https://ph-test-11.slatic.net/p/abada0fd5d956a99f99d0f2ebebdd974.jpg',
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   title: Text('Request Approved',
          //       style: TextStyle(
          //           // fontFamily: 'roboto',
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18.0)),
          //   subtitle: Text(
          //       'Julia Request your listing Lucky Me Noodles. Click to view more.',
          //       style: TextStyle(
          //           // fontFamily: 'RobotoMono-Regular',
          //           fontWeight: FontWeight.normal,
          //           fontSize: 13.0,
          //           color: Colors.black)),
          // ),
          // ListTile(
          //   leading: ClipOval(
          //     child: Container(
          //       child: Image.network(
          //         'https://cdn.shopify.com/s/files/1/1533/6775/products/stjune11_grande.jpg?v=1613709550',
          //         height: 50,
          //         width: 50,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          //   title: Text('Listing Request',
          //       style: TextStyle(
          //           // fontFamily: 'roboto',
          //           fontWeight: FontWeight.bold,
          //           fontSize: 18.0)),
          //   subtitle: Text(
          //       'Julia Request your listing Lucky Me Noodles. Click to view more.',
          //       style: TextStyle(
          //           // fontFamily: 'RobotoMono-Regular',
          //           fontWeight: FontWeight.normal,
          //           fontSize: 13.0,
          //           color: Colors.black)),
          // ),