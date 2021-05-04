import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Widgets/NavigationBar.dart';

class Listings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            NavigationBar(
              title: 'Listings',
            ),
          ],
        ),
      ),
    );
  }
}

Widget _a() {
  return (SliverToBoxAdapter(
    child: Text('data'),
  ));
}
