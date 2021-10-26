import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/Item.dart';
import 'package:my_app/Pages/RequestDonation.dart';
import 'package:my_app/Widgets/NavigationBar.dart';
import 'package:my_app/Pages/PostDonation/PostDonation.dart';
import 'package:my_app/Pages/Home.dart';

class FrequentlyAsk extends StatefulWidget {
  static String routeName = "/FrequentlyAsk";
  @override
  _FrequentlyAskState createState() => _FrequentlyAskState();
}

class _FrequentlyAskState extends State<FrequentlyAsk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: [
            _navigationBar(context),
            _agreementDescription(),
            AgreementList()
          ],
        ),
      ),
    );
  }
}

Widget _navigationBar(context) {
  return CupertinoSliverNavigationBar(
    largeTitle:
        Text('Frequently Ask Questions', style: TextStyle(fontSize: 30.0)),
    trailing: GestureDetector(
      onTap: () {
        showAlertDialog(context);
      },
      child: Text(
        'Done',
        style: TextStyle(color: Colors.blue),
      ),
    ),
  );
}

Widget showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context, false);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      Navigator.pushNamed(context, Home.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text("Are you done reading? "),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget _agreementDescription() {
  const title = "The Accepted Foods";
  const description =
      "This guidelines are for food DONORS and REQUESTORS. By Following these guidelines, food DONORS and REQUESTORS will be able to safely request, prepare, handle, and provide food that can be accepted by INDIVIDUALS and FOOD DISTRIBUTING ORGANIZATIONS";
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
      headerValue: 'How to post a donation',
      expandedValue: 'Guideline 1 description'),
  Item(
      headerValue: 'How to recevied a donation',
      expandedValue: 'Guideline 2 description'),
  Item(
      headerValue: 'How to request a donation',
      expandedValue: 'Guideline 3 description'),
  Item(
      headerValue: 'What foods can i donate',
      expandedValue: 'Guideline 4 description'),
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
