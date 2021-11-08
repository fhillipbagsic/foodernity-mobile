import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:my_app/Pages/Account/Signin.dart';
import 'package:sizer/sizer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_app/Pages/PostDonation/verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

var firstName = "";
var lastName = "";
var fullName = "";
var Email = "";
var Password = "";
var confirmPass = "";

var _FNameController = TextEditingController();
var _LNameController = TextEditingController();
var _emailController = TextEditingController();
var _passwordController = TextEditingController();
var _confirmPassController = TextEditingController();

GlobalKey<FormState> _homeKey = GlobalKey<FormState>();

class Signup extends StatelessWidget {
  static String routeName = "/Signup";
  IO.Socket socket;
  String _haveStarted3Times = '';

  //Will get the startupnumber from shared_preferences
//Will return 0 if null
  Future<int> _getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startupNumber = prefs.getInt('startupNumber');

    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  //Resert the counter in shared_preferences to 0
  Future<void> _resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('startupNumber', 0);
  }

  //Increment startup number and store it
  Future<void> _incrementStartup() async {
    final prefs = await SharedPreferences.getInstance();

    int lastStartupNumber = await _getIntFromSharedPref();
    int currentStartupNumber = ++lastStartupNumber;

    await prefs.setInt('startupNumber', currentStartupNumber);

    if (currentStartupNumber == 3) {
      print('$currentStartupNumber Times Complete');
      await _resetCounter();
    } else {
      print('$currentStartupNumber Times Started the app');
    }
  }

  void initState() {
    // super.initState();
    connectSocket();
    _incrementStartup();
  }

  void connectSocket() {
    socket = IO.io("http://10.0.2.2:3001", <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false,
    });
    // socket.io.options['extraHeaders'] = {
    //   'Content-Type': 'application/json; charset=UTF-8'
    // };
    socket.connect();
    socket.onConnect((data) => print("connected"));
    print(socket.connected);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 2;
    var width = MediaQuery.of(context).size.width;
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blue,
          body: Form(
            key: _homeKey,
            child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Container(
                      height: 20.h,
                      width: 100.w,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign up to Foodernity',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 20.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                          ),
                        ),
                        padding:
                            EdgeInsets.only(top: 70.0, right: 30.0, left: 30.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _displayName(width),
                              _nameHelper(),
                              SizedBox(
                                height: 15.0,
                              ),
                              _EmailField(),
                              SizedBox(
                                height: 15.0,
                              ),
                              _passwordField(),
                              _passwordHelper(),
                              SizedBox(
                                height: 15.0,
                              ),
                              _confirmPasswordField(),
                              SizedBox(
                                height: 15.0,
                              ),
                              _agreement(),
                              SizedBox(
                                height: 20.0,
                              ),
                              _signupButton(context),
                              SizedBox(
                                height: 5.0,
                              ),
                              // Text(
                              //   'or',
                              //   style: TextStyle(color: Colors.grey),
                              // ),
                              // SizedBox(
                              //   height: 5.0,
                              // ),
                              // _googleButton(),
                              SizedBox(
                                height: 15.0,
                              ),
                              _hasAccount(context)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      );
    });
  }
}

// void addUser(firstName, lastName, phoneNumber, password, confirmPass) async {
//   http.Response response = await http.post("http://10.0.2.2:8090/register",
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'firstName': firstName,
//         'lastName': lastName,
//         'phoneNumber': phoneNumber,
//         'password': password,
//         'confirmPass': confirmPass
//       }));
//   print(response.body);
// }

void signUp() async {
  final prefs = await SharedPreferences.getInstance();
  var formatter = DateFormat('MM/dd/yyyy');
  String now = formatter.format(new DateTime.now());
  http.Response response =
      await http.post("https://foodernity.herokuapp.com/signup/signup",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': Email,
            'password': Password,
            'fullName': fullName,
            'dateOfReg': now,
            'loginMethod': 'default',
            'userType': 'user',
            'userStatus': 'active',
          }));
  print(response.body);
  var hashCode = response.body;
  await prefs.setString('vc', hashCode);
}

// Widget _nameField(width) {
//   return (Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [_firstNameField(width), _lastNameField(width)],
//   ));
// }

Widget _nameHelper() {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0),
    child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'First Name, Last Name',
          style: TextStyle(color: Colors.grey),
        )),
  );
}

Widget _displayName(width) {
  return Container(
    // width: width / 2.4,
    child: (TextFormField(
      controller: _FNameController,
      validator: (String value) {
        var validCharacters = RegExp(r'^[a-zA-Z ]+$');
        var arr = value.trim().split(" ");

        if (value.isEmpty) {
          return 'Fullname is required';
        } else {
          if (validCharacters.hasMatch(value)) {
            //goods
            if (arr.length >= 2) {
              //goodswa
              fullName = value;
            } else {
              return 'Please enter your lastname.';
            }
          } else {
            return "Only letters are allowed in the Fullname field.";
          }
          return null;
        }
      },
      onSaved: (value) {
        fullName = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Full Name',
        suffixIcon: IconButton(
          onPressed: _FNameController.clear,
          icon: Icon(
            Icons.clear,
            size: 15.0,
          ),
        ),
      ),
    )),
  );
}

Widget _EmailField() {
  // String pattern = '^(09)\\d{9}';
  // RegExp regExp = new RegExp(pattern);
  return (TextFormField(
    controller: _emailController,
    // keyboardType: TextInputType.number,
    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    validator: emailValidator,
    onSaved: (value) {
      Email = value;
    },
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Email Address',
      suffixIcon: IconButton(
        onPressed: _emailController.clear,
        icon: Icon(
          Icons.clear,
          size: 15.0,
        ),
      ),
    ),
  ));
}

final emailValidator = MultiValidator([
  RequiredValidator(errorText: "Email address is required"),
  EmailValidator(errorText: "Enter valid email address"),
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'^[a-zA-Z0-9]+$',
      errorText: 'passwords must not have special character')
]);

Widget _passwordField() {
  return (TextFormField(
    controller: _passwordController,
    obscureText: true,
    validator: passwordValidator,
    onSaved: (value) {
      Password = value;
    },
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Password',
      suffixIcon: IconButton(
        onPressed: _passwordController.clear,
        icon: Icon(
          Icons.clear,
          size: 15.0,
        ),
      ),
    ),
  ));
}

Widget _passwordHelper() {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0),
    child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Must be at least 8 characters',
          style: TextStyle(color: Colors.grey),
        )),
  );
}

Widget _confirmPasswordField() {
  return (TextFormField(
    controller: _confirmPassController,
    obscureText: true,
    validator: (String value) {
      if (value.isEmpty) {
        return 'Need to re-type password for confirmation';
      } else if (value != _passwordController.text) {
        return 'Password and confirm password does not match';
      }
      return null;
    },
    onSaved: (value) {
      confirmPass = value;
    },
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Confirm Password',
      suffixIcon: IconButton(
        onPressed: _confirmPassController.clear,
        icon: Icon(
          Icons.clear,
          size: 15.0,
        ),
      ),
    ),
  ));
}

Widget _agreement() {
  return (RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'By creating an account, you accept our ',
        style: TextStyle(color: Colors.grey),
        children: [
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ', ',
            style: TextStyle(color: Colors.grey),
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ', and our default ',
            style: TextStyle(color: Colors.grey),
          ),
          TextSpan(
            text: 'Notification Settings.',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ]),
  ));
}

Widget showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget continueButton = FlatButton(
    child: Text(
      "Proceed",
      style: TextStyle(color: Colors.blue),
    ),
    onPressed: () {
      Navigator.pushNamed(context, Signin.routeName);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Row(
      children: [
        Icon(
          Icons.check_circle,
          size: 20.0,
          color: Colors.green,
        ),
        Text("Successfuly Registered!", style: TextStyle(color: Colors.green)),
      ],
    ),
    content: Text(
      "You can now proceed to Sign In",
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

Widget _signupButton(context) {
  var formatter = DateFormat('MM/dd/yyyy');
  String now = formatter.format(new DateTime.now());
  var email = Email;
  var password = Password;
  // var firstname = firstName;
  // var surname = lastName;
  var name = fullName;
  var dateOfReg = now;
  var loginMethod = 'default';
  var userType = 'user';
  var userStatus = 'active';

  print(now);

  return (ElevatedButton(
    onPressed: () {
      if (!_homeKey.currentState.validate()) {
        return;
      }
      _homeKey.currentState.save();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Verification()));
      print(fullName);
      print(phoneNumber);
      print(password);
      print(confirmPass);
      signUp();
      _FNameController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPassController.clear();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('SIGN UP')],
    ),
  ));
}

Widget _googleButton() {
  return (OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.google,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            'SIGN UP WITH GOOGLE',
            style: TextStyle(color: Colors.grey),
          )
        ],
      )));
}

Widget _hasAccount(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: 13),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => Signin()));
            _FNameController.clear();
            _emailController.clear();
            _passwordController.clear();
            _confirmPassController.clear();
          },
          child: Text(
            "Sign in here",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
