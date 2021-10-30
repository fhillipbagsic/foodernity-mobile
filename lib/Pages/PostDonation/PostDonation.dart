import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:my_app/Pages/DonationDetails.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Pages/Home/Listings.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:sizer/sizer.dart';

var donationName = "";
File _image;
var _donationNameController = TextEditingController();
// var _quantityController = TextEditingController();
// var _dateController = TextEditingController();
// String _dropDownValue;

// final _form = GlobalKey<FormState>();
List<TextEditingController> controllers = [];

// List<bool> isAllowed = [
//   true,
//   true,
//   true,
//   true,
//   true,
//   true,
//   true,
//   true,
//   true,
//   true,
// ];

// var quantity = '';

List _categories = [
  "Eggs",
  "Canned goods",
  "Instant Noodles",
  "Rice",
  "Cereals",
  "Tea/Coffee/Milk/Sugar",
  "Biscuits",
  "Condiments and sauces",
  "Beverages",
  "Snacks",
];

List qty = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

class PostDonation extends StatefulWidget {
  static String routeName = "/PostDonation";
  static GlobalKey<FormState> _homeKey = GlobalKey<FormState>();
  @override
  _PostDonationState createState() => _PostDonationState();
}

class _PostDonationState extends State<PostDonation> {
  final GlobalKey<FormState> _homeKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    PostDonation._homeKey = _homeKey;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: Container(
            height: 100.h,
            width: 100.w,
            child: Form(
              key: _homeKey,
              child: SafeArea(
                child: CustomScrollView(
                  physics: ClampingScrollPhysics(),
                  slivers: [_navigationBar(context), forms()],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget _navigationBar(context) {
  return CupertinoSliverNavigationBar(
    largeTitle: Text('Post a Donation'),
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirm Cancel", style: TextStyle(color: Colors.redAccent)),
    content: Text("Would you like to cancel posting donation?"),
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
  List<DropdownMenuItem<String>> _dropDownMenuItems2;

  final picker = ImagePicker();
  String _dropDownValue;
  final form = GlobalKey<FormState>();
  List<CategoryForm> listDynamic = [];
  List<String> data = [];
  final date = DateFormat("yyyy-MM-dd");

  addDynamic() {
    setState(() {});

    if (listDynamic.length >= _categories.length) {
      return;
    }
    TextEditingController categoryController = TextEditingController();
    TextEditingController expiryController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    controllers.add(categoryController);
    controllers.add(expiryController);
    controllers.add(quantityController);
    listDynamic.add(new CategoryForm(
      categoryController: categoryController,
      expiryController: expiryController,
      quantityController: quantityController,
    ));
  }

  // if (data.length != 0) {
  //     floatingIcon = new Icon(Icons.add);

  //     data = [];
  //     listDynamic = [];
  //     print('if');
  //   }
  //   setState(() {});
  //   if (listDynamic.length >= 5) {
  //     return;
  //   }

  void initState() {
    _dropDownMenuItems2 = getDropDownMenuItems2();
    _dropDownValue = _dropDownMenuItems2[0].value;
    PostDonation._homeKey = _homeKey;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => addDynamic());
  }

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null && pickedFile.path != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
    Widget result = new Flexible(
        flex: 1,
        child: new Card(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child: new Text("${index + 1} : ${data[index]}"),
                    ),
                    new Divider()
                  ],
                ),
              );
            },
          ),
        ));

    Widget dynamicForm = Container(
      height: 260.0 * listDynamic.length,
      child: new ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    var width = MediaQuery.of(context).size.width - 30;
    var height = MediaQuery.of(context).size.height / 4;
    var imageWidth = MediaQuery.of(context).size.width - 25;

    return SliverToBoxAdapter(
      child: Form(
        key: _homeKey,
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  width: width,
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [_uploadImageText()],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: imageWidth,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 2,
                    child: Center(
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width - 40,
                        height: MediaQuery.of(context).size.height / 5,
                        child: _image == null
                            ? FlatButton(
                                onPressed: getImage,
                                child: Column(
                                  children: [
                                    // Icon(Icons.add, color: Colors.blue),
                                    Text('Browse Image',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                color: Colors.grey[50],
                                textColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  // side: BorderSide(color: Colors.blue, width: 1),
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
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                _donationName(context),
                Container(
                  width: width,
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [_foodCategText()],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                data.length == 0 ? dynamicForm : result,
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.blue),
                        RichText(
                          text: TextSpan(
                            style:
                                TextStyle(color: Colors.grey, fontSize: 20.0),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Add more category',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16.0),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //print('clicked');
                                      addDynamic();
                                    }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                _submitButton(),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _donationName(context) {
    var width = MediaQuery.of(context).size.width - 30;
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Text(
                      'Donation Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    )),
              ],
            ),
            TextFormField(
              controller: _donationNameController,
              validator: (String value) {
                var validCharacters = RegExp(r'^[a-zA-Z ]+$');

                if (value.isEmpty) {
                  return 'Donation Name is required';
                } else {
                  if (validCharacters.hasMatch(value)) {
                    //goods

                    donationName = value;
                  } else {
                    return "Only letters are allowed in the Donation Name field.";
                  }
                  return null;
                }
              },
              // onSaved: (value) {
              //   donationName = value;
              // },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Here'),
            ),
          ],
        ),
      ),
    );
  }

  void postDonation(dynamic donationCateg, dynamic donationQty, dynamic img,
      dynamic donationName) async {
    final prefs = await SharedPreferences.getInstance();
    var userID = prefs.getInt("userID");

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String formattedDate = formatter.format(now);

    final cloudinary = CloudinaryPublic('dftq12ab0', 'b4jy8nar', cache: false);
    CloudinaryResponse responseImg = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(img.path,
          resourceType: CloudinaryResourceType.Image),
    );

    print(responseImg.secureUrl);

    http.Response response =
        await http.post("https://foodernity.herokuapp.com/post/postDonation",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'userID': userID,
              'date': formattedDate,
              'donationName': donationName,
              'donationCategories': donationCateg.toString(),
              'donationQuantities': donationQty.toString(),
              'imgPath': responseImg.secureUrl,
              'status': "pending",
            }));
    print(response.body);

    http.Response response1 =
        await http.post("https://foodernity.herokuapp.com/stocks/addStocks",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'categArr': donationCateg,
              'qtyArr': donationQty,
            }));
    print(response1.body);
  }

  Widget _submitButton() {
    var categArr = [];
    var dateArr = [];
    var qtyArr = [];

    var width = MediaQuery.of(context).size.width - 30;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
      child: FlatButton(
        onPressed: () {
          if (!_homeKey.currentState.validate()) {
            return;
          }

          if (_image != null) {
            print('VALUES');
            // print(controllers.toString());
            print(_image);
            print(donationName);
            for (var i = 0; i < (controllers.length - 2); i++) {
              // print(controllers[i].text);
              if (_categories.contains(controllers[i].text)) {
                categArr.add(controllers[i].text);
                dateArr.add(controllers[i + 1].text);
                qtyArr.add(controllers[i + 2].text);
              }
            }

            print(categArr);
            print(dateArr);
            print(qtyArr);

            postDonation(categArr, qtyArr, _image, donationName);

            //  dateArr.sort((a, b) {
            //    DateTime c = DateTime.parse(a);
            //    DateTime d = DateTime.parse(b);
            //    return c.compareTo(d);
            //  });
            //  print("sorted");
            //  print(dateArr[0]);
            // var sixMonths =DateTime.now().add(Duration(days: 180));
            // print(sixMonths);

            // if(dateArr[0].){
            //
            // }
            // print(_donationNameController.text);
            // print(_image);
            // print(_quantityController.text);
            //print(_dropDownValue);
            // print(_dateController.text);
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
            // Navigator.pushNamed(context, PostDonationSummary.routeName);
            // _homeKey.currentState.save();
          } else {
            //lagyan ng popup na image is required
            _imageRequired(context);
            print("image is required");
          }
        },
        color: Colors.blue,
        minWidth: width,
        height: 45,
        child: Text('Proceed', style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.blue, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _uploadImageText() {
    return (Text(
      'Upload an Image of your donation',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
    ));
  }

  Widget _foodCategText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (Text(
          'Food Categories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        )),
        SizedBox(
          height: 7.0,
        ),
        Text('Choose all the food categories of your donation',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.normal)),
      ],
    );
  }
}

void _imageRequired(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Image required', style: TextStyle(color: Colors.redAccent)),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            //   Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text("Close"),
        ),
      ],
    ),
  );
}

void _showErrorMessage(context, String error) {
  var errorMessage = error;
  Widget continueButton = FlatButton(
    child: Text(
      "Close",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Row(
      children: [
        Text("Category already selected",
            style: TextStyle(color: Colors.redAccent)),
      ],
    ),
    content: Text(
      errorMessage,
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      continueButton,
    ],
    backgroundColor: Colors.white,
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class CategoryForm extends StatefulWidget {
  const CategoryForm(
      {Key key,
      this.categoryController,
      this.expiryController,
      this.quantityController})
      : super(key: key);

  final TextEditingController categoryController;
  final TextEditingController expiryController;
  final TextEditingController quantityController;

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final date = DateFormat("yyyy-MM-dd");

  final form = GlobalKey<FormState>();

  final GlobalKey<FormState> _homeKey = GlobalKey<FormState>();

  //List<DropdownMenuItem<String>> _dropDownMenuItems2;

  // List _categories = [
  //   "Canned Goods",
  //   "Instant Noodles",
  //   "Biscuits",
  //   "Beverages",
  //   "Others"
  // ];

  // List qty = [0, 0, 0, 0, 0];

  var categQty = 0;

  var index = 0;

  DateTime getMinExpiryDate(String category) {
    switch (category) {
      case 'Eggs':
        return DateTime.now().add(Duration(days: 14));
      default:
        return DateTime.now().add(Duration(days: 180));
    }
  }

  DateTime getMaxExpiryDate(String category) {
    switch (category) {
      case 'Eggs':
        return DateTime.now().add(Duration(days: 42));
      default:
        return DateTime(2100);
    }
  }

  void initState() {
    //_dropDownMenuItems2 = getDropDownMenuItems2();
    //_dropDownValue = _dropDownMenuItems2[0].value;
    PostDonation._homeKey = _homeKey;
    super.initState();
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
    var width = MediaQuery.of(context).size.width - 30;
    var height = MediaQuery.of(context).size.height / 3.5;
    var itemWidth = MediaQuery.of(context).size.height / 4;
    // final form = GlobalKey<FormState>();
    String error = '';
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height,
            child: Material(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: Form(
                key: _homeKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          color: Colors.grey[200],
                          width: 350,
                          child: DropdownButton(
                            hint: widget.categoryController.text == null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      'Choose a category',
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      widget.categoryController.text,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            underline: SizedBox(),
                            style: TextStyle(color: Colors.grey),
                            items: _categories.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  //_dropDownValue = val;
                                  // print('abc');
                                  for (var i = 0; i < controllers.length; i++) {
                                    if (val == controllers[i].text) {
                                      return _showErrorMessage(context, error);
                                    }
                                  }
                                  widget.categoryController.text = val;
                                  // for (var x = 0; x < _categories.length; x++) {
                                  //   if (_categories[x] == val) {
                                  //     // print(_categories[x] + " categ");

                                  //     // print(val + " val");

                                  //     if (isAllowed[x] == true) {
                                  //       isAllowed[x] = false;
                                  //       // print(isAllowed[x]);
                                  //       // print(isAllowed);
                                  //       // qty[x] == categQty;
                                  //       index = x;
                                  //       widget.categoryController.text = val;
                                  //     } else {
                                  //       // print("napili na po putangina mo");
                                  //       _showErrorMessage(context, error);
                                  //       //_dropDownValue = _categories[0];
                                  //     }
                                  //   }
                                  // }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Earliest Expiry ',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Container(
                                color: Colors.grey[200],
                                width: itemWidth,
                                // margin: EdgeInsets.only(top: 20.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: DateTimeField(
                                    enabled:
                                        widget.categoryController.text == ''
                                            ? false
                                            : true,
                                    controller: widget.expiryController,
                                    format: date,
                                    // validator: (value) {
                                    //   if (!value.isAfter(DateTime.now())) {
                                    //     return ('Pickup Date Can\'t Be In The Past');
                                    //   }
                                    //   return null;
                                    // },
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                        context: context,
                                        firstDate: getMinExpiryDate(
                                            widget.categoryController.text),
                                        initialDate: currentValue ??
                                            getMinExpiryDate(
                                                widget.categoryController.text),
                                        lastDate: getMaxExpiryDate(
                                            widget.categoryController.text),
                                      );
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Select Pick up Date*'),
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Quantity:  ',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Container(
                                  color: Colors.grey[200],
                                  width: itemWidth,
                                  // margin: EdgeInsets.only(top: 20.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: TextFormField(
                                      controller: widget.quantityController,
                                      enabled:
                                          widget.categoryController.text == ''
                                              ? false
                                              : true,
                                      onSaved: (value) {
                                        qty[index] = value;

                                        //print(qty);
                                        // print("quantities");
                                        // print(isAllowed);
                                        //print("is allowed");
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      // keyboardType: TextInputType.number,
                                      textAlign: TextAlign.start,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'piece/s'),
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// DateTime _getMaxExpiry(String category) {
//   switch(category) {
//     case 'eggs':
//       return DateTime.now().add(Duration(days: 42));
//     default:
//       return DateTime(2100);
//   }
// }

 // Container(
                //   margin: EdgeInsets.only(top: 20.0),
                //   child: SizedBox(
                //     width: width,
                //     child: TextFormField(
                //       validator: (String value) {
                //         if (value.isEmpty) {
                //           return 'Donation Name Can\'t Be Empty';
                //         }
                //         return null;
                //       },
                //       onSaved: (value) {
                //         donationName = value;
                //       },
                //       decoration: InputDecoration(
                //           border: OutlineInputBorder(),
                //           labelText: 'Donation Name*'),
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 20.0),
                //   width: width,
                //   child: new DropdownButtonFormField(
                //     value: _currentCategory,
                //     items: _dropDownMenuItems2,
                //     onChanged: changedDropDownItem2,
                //     decoration: const InputDecoration(
                //         border: OutlineInputBorder(), labelText: 'Category*'),
                //   ),
                // ),
                // Container(
                //   width: width,
                //   margin: EdgeInsets.only(top: 20.0),
                //   child: Column(
                //     children: <Widget>[
                //       // Text('Basic date field (${format.pattern})'),
                //       DateTimeField(
                //         format: date,
                //         validator: (value) {
                //           if (value == null) {
                //             return ('Pickup Date Can\'t Be Empty');
                //           }
                //           if (!value.isAfter(DateTime.now())) {
                //             return ('Pickup Date Can\'t Be In The Past');
                //           }
                //           return null;
                //         },
                //         onShowPicker: (context, currentValue) {
                //           return showDatePicker(
                //               context: context,
                //               firstDate: DateTime(1900),
                //               initialDate: currentValue ?? DateTime.now(),
                //               lastDate: DateTime(2100));
                //         },
                //         decoration: const InputDecoration(
                //             border: OutlineInputBorder(),
                //             labelText: 'Select Pick up Date*'),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 20.0),
                //   child: Column(
                //     children: <Widget>[
                //       Row(
                //         children: [
                //           Padding(
                //             padding:
                //                 const EdgeInsets.only(left: 20.0, top: 10.0),
                //             child: Text(
                //               "How do you want your donation to be claimed? ",
                //               style: TextStyle(
                //                   fontSize: 17, fontWeight: FontWeight.bold),
                //               textAlign: TextAlign.left,
                //             ),
                //           ),
                //         ],
                //       ),
                //       ListTile(
                //         title: const Text('Pick Up'),
                //         leading: Radio<SingingCharacter>(
                //           value: SingingCharacter.pickup,
                //           groupValue: _character,
                //           onChanged: (SingingCharacter value) {
                //             setState(() {
                //               _character = value;
                //             });
                //           },
                //         ),
                //       ),
                //       ListTile(
                //         title: const Text('Deliver'),
                //         leading: Radio<SingingCharacter>(
                //           value: SingingCharacter.deliver,
                //           groupValue: _character,
                //           onChanged: (SingingCharacter value) {
                //             setState(() {
                //               _character = value;
                //             });
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   width: width,
                //   margin: EdgeInsets.only(top: 20.0),
                //   child: Column(
                //     children: <Widget>[
                //       // Text('Basic date field (${format.pattern})'),
                //       DateTimeField(
                //         format: time,
                //         validator: (value) {
                //           if (value == null) {
                //             return ('Pickup Time Can\'t Be Empty');
                //           }
                //           return null;
                //         },
                //         onShowPicker: (context, currentValue) async {
                //           final time = await showTimePicker(
                //             context: context,
                //             initialTime: TimeOfDay.fromDateTime(
                //                 currentValue ?? DateTime.now()),
                //           );
                //           return DateTimeField.convert(time);
                //         },
                //         decoration: const InputDecoration(
                //             border: OutlineInputBorder(),
                //             labelText: 'Select Pick up Time'),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(top: 20.0),
                //   child: SizedBox(
                //     width: width,
                //     child: TextFormField(
                //       validator: (String value) {
                //         if (value.isEmpty) {
                //           return 'Donation Notes Can\'t Be Empty';
                //         }
                //         return null;
                //       },
                //       decoration: InputDecoration(
                //           // contentPadding: new EdgeInsets.symmetric(vertical: 50.0),
                //           border: OutlineInputBorder(),
                //           labelText: 'Donation Notes*'),
                //       maxLines: 6,
                //       minLines: 4,
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                //   child: FlatButton(
                //     onPressed: () {
                //       if (!_homeKey.currentState.validate()) {
                //         return;
                //       }
                //       // if (controller.text.isEmpty
                //       //     ? _validate = true
                //       //     : _validate = false) {
                //       //   return;
                //       // }
                //       // setState(() {
                //       //   controller.text.isEmpty
                //       //       ? _validate = true
                //       //       : _validate = false;
                //       // });
                //       Navigator.pushNamed(
                //           context, PostDonationSummary.routeName);
                //       _homeKey.currentState.save();
                //     },
                //     color: Colors.blue,
                //     minWidth: width,
                //     height: 45,
                //     child:
                //         Text('Proceed', style: TextStyle(color: Colors.white)),
                //     shape: RoundedRectangleBorder(
                //         side: BorderSide(
                //             color: Colors.blue,
                //             width: 2,
                //             style: BorderStyle.solid),
                //         borderRadius: BorderRadius.circular(10)),
                //   ),
                // ),
