import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/Item.dart';
import 'package:my_app/Pages/MyProfile/profile_page.dart';
import 'package:my_app/Widgets/NavigationBar.dart';
import 'package:my_app/Pages/PostDonation/post_donation.dart';

class AddListing extends StatefulWidget {
  static String routeName = "/AddListing";
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
    largeTitle: Text('FAQs'),
    leading: GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage())),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(
          'Back',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ),
  );
}

Widget _agreementDescription() {
  const title = "Guidelines For Posting Donations";
  const description =
      "Before proceeding to post a donation, you must adhere to the guidelines first to protect you and the safety of the others as we. The guidelines to acknowledge are as follows.";
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
    headerValue:
        'I acknowledge that I am donating foods that are in the following:',
    expandedValue:
        'Canned Goods - Canned fruits and vegetables, milks and sauces, meat and fish.',
    expandedValue2:
        'Instant Noodles - Instant Noodles sush as soups noodles, fried noodles, non-fried noodles.',
    expandedValue3:
        'Snacks & Biscuits - Any kinds of snacks and biscuits and the.',
    expandedValue4:
        'Beverages - Water, tea, coffee, soft drinks, juice drinks (alcoholic are prohibited).',
    expandedValue5:
        "Others - Other non-perishable foods that don't require refrigeration (e.g., condiments).",
    expandedValue6: '',
  ),
  Item(
    headerValue:
        'I acknowledge that I am not donating foods that are in the following:',
    expandedValue:
        'Home-cooked-foods - Foods prepared, cooked, cooled, or reheated at home.',
    expandedValue2:
        'Expired Foods - Foods that are past a "use by / consume by" date.',
    expandedValue3:
        'Foods in containers - Foods taken out of their original packaging and placed into containers.',
    expandedValue4:
        'Opened Foods - Foods in opened or torn containers exposing the food to potential contamination.',
    expandedValue5:
        "Raw foods - Meat, beef, pork, poultry, and other considered raw foods.",
    expandedValue6:
        "Others - Other perishables such as fruits, vegetables, dairy products, eggs, meat, poultry, and seafood.",
  ),
  Item(
    headerValue:
        'I acknowledge that I am donating foods that are in the following:',
    expandedValue:
        'Canned Goods - Canned fruits and vegetables, milks and sauces, meat and fish.',
    expandedValue2:
        'Instant Noodles - Instant Noodles sush as soups noodles, fried noodles, non-fried noodles.',
    expandedValue3:
        'Snacks & Biscuits - Any kinds of snacks and biscuits and the.',
    expandedValue4:
        'Beverages - Water, tea, coffee, soft drinks, juice drinks (alcoholic are prohibited).',
    expandedValue5:
        "Others - Other non-perishable foods that don't require refrigeration (e.g., condiments).",
    expandedValue6: '',
  ),
  Item(
    headerValue:
        'I acknowledge that I am not donating foods that are in the following:',
    expandedValue:
        'Home-cooked-foods - Foods prepared, cooked, cooled, or reheated at home.',
    expandedValue2:
        'Expired Foods - Foods that are past a "use by / consume by" date.',
    expandedValue3:
        'Foods in containers - Foods taken out of their original packaging and placed into containers.',
    expandedValue4:
        'Opened Foods - Foods in opened or torn containers exposing the food to potential contamination.',
    expandedValue5:
        "Raw foods - Meat, beef, pork, poultry, and other considered raw foods.",
    expandedValue6:
        "Others - Other perishables such as fruits, vegetables, dairy products, eggs, meat, poultry, and seafood.",
  ),
  Item(
    headerValue:
        'I acknowledge that I am donating foods that are in the following:',
    expandedValue:
        'Canned Goods - Canned fruits and vegetables, milks and sauces, meat and fish.',
    expandedValue2:
        'Instant Noodles - Instant Noodles sush as soups noodles, fried noodles, non-fried noodles.',
    expandedValue3:
        'Snacks & Biscuits - Any kinds of snacks and biscuits and the.',
    expandedValue4:
        'Beverages - Water, tea, coffee, soft drinks, juice drinks (alcoholic are prohibited).',
    expandedValue5:
        "Others - Other non-perishable foods that don't require refrigeration (e.g., condiments).",
    expandedValue6: '',
  ),
  Item(
    headerValue: 'All about MHTP',
    expandedValue:
        'Located at: Calabash Rd., Balic-Balic, 1008 Manila, Philippines',
    expandedValue2:
        'Working days and working hours: Tuesday to Sunday, 9:00AM to 6:00PM',
    expandedValue3: '',
    expandedValue4: '',
    expandedValue5: '',
    expandedValue6: '',
  ),
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
              title: Text(
                item.headerValue,
                style: TextStyle(fontSize: 15.0),
              ),
            );
          },
          body: ListTile(
            title: Column(
              children: [
                Text(item.expandedValue, style: TextStyle(fontSize: 12.0)),
                SizedBox(height: 10.0),
                Text(item.expandedValue2, style: TextStyle(fontSize: 12.0)),
                SizedBox(height: 10.0),
                Text(item.expandedValue3, style: TextStyle(fontSize: 12.0)),
                SizedBox(height: 10.0),
                Text(item.expandedValue4, style: TextStyle(fontSize: 12.0)),
                SizedBox(height: 10.0),
                Text(item.expandedValue5, style: TextStyle(fontSize: 12.0)),
                SizedBox(height: 10.0),
                Text(item.expandedValue6, style: TextStyle(fontSize: 12.0)),
              ],
            ),
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
