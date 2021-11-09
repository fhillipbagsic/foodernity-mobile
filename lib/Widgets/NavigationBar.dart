import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  final String title;
  NavigationBar({this.title, this.scaffold});

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      automaticallyImplyLeading: false,
      trailing: GestureDetector(
          child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Icon(
          Icons.notifications,
          color: Colors.blue,
          size: 25.0,
        ),
      )),
      largeTitle: Text(widget.title),
      // trailing: _hamburger(widget.scaffold),
    );
  }
}

// Widget _hamburger(scaffold) {
//   return GestureDetector(
//     onTap: () {
//       scaffold.currentState.openEndDrawer();
//     },
//     child: Container(
//       padding: EdgeInsets.only(top: 8),
//       // ignore: missing_required_param
//       child: IconButton(
//         icon: Icon(Icons.menu, color: Colors.blue, size: 30.0),
//       ),
//     ),
//   );
// }

// class AccountDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: <Widget>[
//           Container(
//             child: UserAccountsDrawerHeader(
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: AssetImage("assets/images/profile.jpg"),
//               ),
//               accountName: Text(
//                 "Mark Kenneth Dela Cruz",
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//               accountEmail: Text(
//                 "markennethdelacruz04@gmail.com",
//                 style: TextStyle(color: Colors.white, fontSize: 13),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           ListTile(
//             title: Text('Frequently Asked Questions'),
//             leading: Icon(Icons.contact_support_sharp),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => FrequentlyAsk()));
//             },
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ListTile(
//             title: Text('My Donations'),
//             leading: Icon(Icons.add_shopping_cart),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => Listed()));
//             },
//           ),
//           SizedBox(
//             height: 350,
//           ),
//           ListTile(
//             title: Text('Logout'),
//             leading: Icon(Icons.arrow_back),
//             onTap: () {
//               print("Clicked");
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class NavigationBar2 extends StatelessWidget {
  final String title;
  NavigationBar2({this.title});
  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(title),
    );
  }
}
