import 'package:flutter/material.dart';
import 'package:my_app/Widgets/NavigationBar.dart';

class Guidelines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            NavigationBar2(
              title: 'Guidelines',
            )
          ],
        ),
      ),
    );
  }
}
