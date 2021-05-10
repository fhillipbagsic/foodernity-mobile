import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/Item.dart';
import 'package:my_app/Widgets/NavigationBar.dart';

class AddListing extends StatefulWidget {
  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [_navigationBar(), _agreementDescription(), AgreementList()],
        ),
      ),
    );
  }
}

Widget _navigationBar() {
  return CupertinoSliverNavigationBar(
    largeTitle: Text('Post a Donation'),
    trailing: Text(
      'Next',
      style: TextStyle(color: Colors.blue),
    ),
  );
}

Widget _agreementDescription() {
  const title = "Donating Guidelines";
  const description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam quis non euismod faucibus a eu cum pharetra elementum. Congue placerat vitae ultrices quis elit aliquam. Gravida a etiam sed aliquam mauris.";
  return SliverToBoxAdapter(
    child: Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(description)
        ],
      ),
    ),
  );
}

List<Item> agreementItems = [
  Item(
      headerValue: 'I acknowledge that I',
      expandedValue: 'Guideline 1 description'),
  Item(
      headerValue: 'I acknowledge that I',
      expandedValue: 'Guideline 2 description'),
  Item(
      headerValue: 'I acknowledge that I',
      expandedValue: 'Guideline 3 description'),
  Item(
      headerValue: 'I acknowledge that I',
      expandedValue: 'Guideline 4 description'),
  Item(
      headerValue: 'I acknowledge that I',
      expandedValue: 'Guideline 5 description'),
];

class AgreementList extends StatefulWidget {
  @override
  _AgreementListState createState() => _AgreementListState();
}

class _AgreementListState extends State<AgreementList> {
  final List<Item> _data = agreementItems;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
            //subtitle: Text(item.expandedValue),
            //trailing: Checkbox(checkColor: Colors.white, fillColor: MaterialStateProperty(),),
            // onTap: () {
            //   setState(() {
            //     _data.removeWhere((Item currentItem) => item == currentItem);
            //   });
            // }),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
