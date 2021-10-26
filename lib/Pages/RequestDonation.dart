import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Pages/RequestDonationSummary.dart';
import 'dart:io';

var donationName = "";
var expiryDate = "";
bool _validate = false;

class RequestDonation extends StatefulWidget {
  static String routeName = "/RequestDonation";
  static GlobalKey<FormState> _homeKey = GlobalKey<FormState>();
  @override
  _RequestDonationState createState() => _RequestDonationState();
}

class _RequestDonationState extends State<RequestDonation> {
  final GlobalKey<FormState> _homeKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    RequestDonation._homeKey = _homeKey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _homeKey,
        child: SafeArea(
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [_navigationBar(context), forms()],
          ),
        ),
      ),
    );
  }
}

Widget _navigationBar(context) {
  return CupertinoSliverNavigationBar(
    largeTitle: Text('Request a Donation'),
    trailing: GestureDetector(
      onTap: () {
        showAlertDialog(context);
      },
      child: Text(
        'Cancel',
        style: TextStyle(color: Colors.blue),
      ),
    ),
  );
}

Widget showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context, false);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.pushNamed(context, Home.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirm Cancel"),
    content: Text("Would you like to cancel requesting donation?"),
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

class forms extends StatefulWidget {
  @override
  _formsState createState() => _formsState();
}

class _formsState extends State<forms> {
  final GlobalKey<FormState> _homeKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> _dropDownMenuItems2;
  File _image;
  final picker = ImagePicker();
  String _currentRecipient;
  String _currentCategory;

  final date = DateFormat("yyyy-MM-dd");
  final time = DateFormat("HH:mm");
  // GlobalKey<FormState> myFormKey = new GlobalKey();

  List _recipient = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
  ];

  //canned goods, instant noodles, biscuits and beverages.

  List _categories = [
    "Canned Goods",
    "Instant Noodles",
    "Biscuits",
    "Beverages",
    "Others"
  ];

  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentRecipient = _dropDownMenuItems[0].value;
    _dropDownMenuItems2 = getDropDownMenuItems2();
    _currentCategory = _dropDownMenuItems2[0].value;
    RequestDonation._homeKey = _homeKey;
    super.initState();
  }

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null && pickedFile.path != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _recipient) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems2() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _categories) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 40;
    var height = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: Form(
        key: _homeKey,
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.height / 5,
                    child: _image == null
                        ? FlatButton(
                            onPressed: getImage,
                            child: Column(
                              children: [
                                Icon(Icons.add, color: Colors.blue),
                                Text('Upload Image',
                                    style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                            color: Colors.grey[50],
                            textColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          )
                        : Container(
                            width: width,
                            height: 200,
                            margin: EdgeInsets.all(10.0),
                            child: FlatButton(
                              onPressed: getImage,
                              child: Image.file(
                                _image,
                                fit: BoxFit.fitWidth,
                              ),
                              // color: Colors.grey[50],
                              // textColor: Colors.black,
                              // shape: RoundedRectangleBorder(
                              //   side: BorderSide(color: Colors.blue, width: 1),
                              //   borderRadius: BorderRadius.circular(8.0),
                              // ),
                            ),
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: width,
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Donation Name Can\'t Be Empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        donationName = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Donation Name'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width,
                  child: new DropdownButtonFormField(
                    value: _currentCategory,
                    items: _dropDownMenuItems2,
                    onChanged: changedDropDownItem2,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Category'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  width: width,
                  child: new DropdownButtonFormField(
                    value: _currentRecipient,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Quantity'),
                  ),
                ),
                // placesAutoCompleteTextField(),
                Container(
                  width: width,
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: <Widget>[
                      // Text('Basic date field (${format.pattern})'),
                      DateTimeField(
                        format: date,
                        validator: (value) {
                          if (value == null) {
                            return ('Pickup Date Can\'t Be Empty');
                          }
                          if (!value.isAfter(DateTime.now())) {
                            return ('Pickup Date Can\'t Be In The Past');
                          }
                          return null;
                        },
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Select Pick up Date'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: width,
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Request Notes Can\'t Be Empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          // contentPadding: new EdgeInsets.symmetric(vertical: 50.0),
                          border: OutlineInputBorder(),
                          labelText: 'Request Notes'),
                      maxLines: 6,
                      minLines: 4,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                  child: FlatButton(
                    onPressed: () {
                      if (!_homeKey.currentState.validate()) {
                        return;
                      }
                      // if (controller.text.isEmpty
                      //     ? _validate = true
                      //     : _validate = false) {
                      //   return;
                      // }
                      // setState(() {
                      //   controller.text.isEmpty
                      //       ? _validate = true
                      //       : _validate = false;
                      // });
                      Navigator.pushNamed(context, RequestSummary.routeName);
                      _homeKey.currentState.save();
                    },
                    color: Colors.blue,
                    minWidth: width,
                    height: 45,
                    child:
                        Text('Proceed', style: TextStyle(color: Colors.white)),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.blue,
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // placesAutoCompleteTextField() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 20.0),
  //     padding: EdgeInsets.symmetric(horizontal: 20),
  //     child: GooglePlaceAutoCompleteTextField(
  //         textEditingController: controller,
  //         googleAPIKey: "AIzaSyDyn1Cs8FHCOEedwL6jWkq1EtWhulBUc70",
  //         inputDecoration: InputDecoration(
  //             hintText: "Search your location",
  //             // errorText: _homeKey != null ? 'Location Can\'t Be Empty' : null,
  //             border: OutlineInputBorder()),
  //         debounceTime: 800,
  //         countries: ["ph"],
  //         isLatLngRequired: true,
  //         getPlaceDetailWithLatLng: (Prediction prediction) {
  //           print("placeDetails" + prediction.lng.toString());
  //         },
  //         itmClick: (Prediction prediction) {
  //           controller.text = prediction.description;

  //           controller.selection = TextSelection.fromPosition(
  //               TextPosition(offset: prediction.description.length));
  //         }
  //         // default 600 ms ,
  //         ),
  //   );
  // }

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void changedDropDownItem(String selectedRecipient) {
    setState(() {
      _currentRecipient = selectedRecipient;
    });
  }

  void changedDropDownItem2(String selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory;
    });
  }
}
