import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:sizer/sizer.dart';
import 'package:my_app/Pages/PostDonation/step_three.dart';

var donationName = "";
File _image;
var _donationNameController = TextEditingController();
List<TextEditingController> controllers = [];
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
            color: Colors.grey[200],
            height: 100.h,
            width: 100.w,
            child: Form(
              key: _homeKey,
              child: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    CupertinoSliverNavigationBar(
                      largeTitle: Text('Post a Donation'),
                      leading: GestureDetector(
                        onTap: () {
                          showAlertDialog(context);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          showAlertDialog(context);
                        },
                      ),
                    ),
                    Forms()
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("No"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      _donationNameController.clear();
      controllers = [];
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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

class Forms extends StatefulWidget {
  @override
  _formsState createState() => _formsState();
}

class _formsState extends State<Forms> {
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
      height: 280.0 * listDynamic.length,
      child: new ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    var width = MediaQuery.of(context).size.width - 30;
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
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                color: Colors.grey[100],
                margin: EdgeInsets.all(20),
                child: TextFormField(
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
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 0)),
                    border: OutlineInputBorder(),
                    hintText: 'Enter Here',
                  ),
                ),
              ),
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

    // http.Response response1 =
    //     await http.post("https://foodernity.herokuapp.com/stocks/addStocks",
    //         headers: <String, String>{
    //           'Content-Type': 'application/json; charset=UTF-8',
    //         },
    //         body: jsonEncode(<String, dynamic>{
    //           'categArr': donationCateg,
    //           'qtyArr': donationQty,
    //         }));
    // print(response1.body);
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => StepThree()));
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => StepThree()),
            //     ModalRoute.withName("/SuccessDonation"));
            postDonation(categArr, qtyArr, _image, donationName);
            _donationNameController.clear();
            controllers = [];
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
    PostDonation._homeKey = _homeKey;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems2() {
    List<DropdownMenuItem<String>> items = [];
    for (String city in _categories) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.height / 4;
    String error = '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Form(
              key: _homeKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: DropdownButton(
                      hint: widget.categoryController.text == ''
                          ? Text(
                              'Choose a category',
                              style: TextStyle(fontSize: 15.0),
                            )
                          : Text(
                              widget.categoryController.text,
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      underline: SizedBox(),
                      style: TextStyle(color: Colors.grey),
                      items: _categories.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val,
                                style: TextStyle(color: Colors.black)),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            for (var i = 0; i < controllers.length; i++) {
                              if (val == controllers[i].text) {
                                return _showErrorMessage(context, error);
                              }
                            }
                            widget.categoryController.text = val;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Earliest Expiry:',
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
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            width: itemWidth,
                            child: DateTimeField(
                              enabled: widget.categoryController.text == ''
                                  ? false
                                  : true,
                              controller: widget.expiryController,
                              format: date,
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
                                  hintText: 'Select expiry date'),
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Quantity:',
                            textAlign: TextAlign.left,
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
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              width: itemWidth,
                              child: TextFormField(
                                controller: widget.quantityController,
                                enabled: widget.categoryController.text == ''
                                    ? false
                                    : true,
                                onSaved: (value) {
                                  qty[index] = value;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.start,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'piece/s'),
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
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
      ],
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

 