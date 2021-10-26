import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/styles.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:my_app/Pages/Account/Signup.dart';
import 'package:my_app/Pages/Account/ForgotPassword.dart';
import 'package:my_app/Pages/Home.dart';
import 'package:sizer/sizer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

var phoneNumber = "";
var password = "";
var _emailController = TextEditingController();
var _passwordController = TextEditingController();

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class Signin extends StatefulWidget {
  static String routeName = "/Signin";

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
    super.initState();
    // connectSocket();
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blue,
          body: Form(
            key: _formKey,
            child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Container(
                      height: 30.h,
                      width: 70.w,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Welcome to Foodernity',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 45.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 10.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                          ),
                        ),
                        padding:
                            EdgeInsets.only(top: 40.0, right: 30.0, left: 30.0),
                        child: Column(
                          children: [
                            _signInTextField(),
                            SizedBox(
                              height: 20.0,
                            ),
                            _passwordField(),
                            SizedBox(
                              height: 15.0,
                            ),
                            _forgotPassword(context),
                            SizedBox(
                              height: 30.0,
                            ),
                            _signinButton(context),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'or',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            GoogleButton(),
                            SizedBox(
                              height: 40.0,
                            ),
                            _noAccount(context),
                          ],
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

String email = '';
String fullname = '';

// void signInUser() async {
//   http.Response response =
//       await http.post("https://foodernity.herokuapp.com/login/googleLogin",
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//           body: jsonEncode(<String, String>{
//             'email': email,
//             'password': password,
//           }));
//   print(response.body);
// }

void googleSignin(context) async {
  final prefs = await SharedPreferences.getInstance();
  var formatter = DateFormat('MM/dd/yyyy');
  String now = formatter.format(new DateTime.now());
  http.Response response =
      await http.post("https://foodernity.herokuapp.com/login/googleLogin",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'password': "",
            'fullName': fullname,
            'dateOfReg': now,
            'loginMethod': 'google',
            'userType': 'user',
            'userStatus': 'active',
          }));
  print(response.body);
  var message = response.body;
  if (message == "Email is in use in different login method.") {
    _showErrorMessage(context, "Email is in use in different login method.");
  } else if (message == "Logged in") {
    await prefs.setString('email', email);
    var string = await prefs.getString('email');
    print(string);
    Navigator.pushNamed(context, Home.routeName);
  } else {
    _showErrorMessage(context, message);
  }
}

//alert dialog when user doesnt exists
void _showErrorMessage(context, String subtitle) {
  var subtitle1 = subtitle;
  Widget continueButton = FlatButton(
    child: Text(
      "Close",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Row(
      children: [
        Text("Login Error", style: TextStyle(color: Colors.redAccent)),
      ],
    ),
    content: Text(
      subtitle1,
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

void loginUser(context) async {
  final prefs = await SharedPreferences.getInstance();
  print(_emailController.text);
  print(_passwordController.text);
  http.Response response =
      await http.post("https://foodernity.herokuapp.com/login/login",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': _emailController.text,
            'password': _passwordController.text,
          }));
  print(response.body);

  var message = response.body;
  // print(message);

  if (message == "No existing account.") {
    _showErrorMessage(context, "No existing account.");
  } else if (message == "Wrong email/password.") {
    _showErrorMessage(context, "Wrong email/password.");
  } else if (message == "logged in") {
    await prefs.setString('email', _emailController.text);
    var string = await prefs.getString('email');
    print(string);
    Navigator.pushNamed(context, Home.routeName);
  } else {
    _showErrorMessage(context, message);
  }
}

Widget _signInTextField() {
  return (TextFormField(
    controller: _emailController,
    validator: (String value) {
      if (value.isEmpty) {
        return 'Please provide email address';
      }
      return null;
    },
    onSaved: (value) {
      phoneNumber = value;
    },
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Email Address',
        suffixIcon: IconButton(
          onPressed: _emailController.clear,
          icon: Icon(Icons.clear, size: 15.0),
        )),
  ));
}

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
]);

Widget _passwordField() {
  return (TextFormField(
    controller: _passwordController,
    obscureText: true,
    validator: (String value) {
      if (value.isEmpty) {
        return 'Please provide password';
      }
      return null;
    },
    onSaved: (value) {
      password = value;
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

Widget _forgotPassword(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, ForgotPassword.routeName),
        child: Text(
          "Forgot Password? ",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget _signinButton(context) {
  return (ElevatedButton(
    onPressed: () {
      if (!_formKey.currentState.validate()) {
        return;
      }
      // _showErrorMessage(context);
      loginUser(context);
      // _showErrorMessage(context);
      // _emailController.clear();
      // _passwordController.clear();
      // print(_emailController.text);
      // print(_passwordController.text);
      // Navigator.pushNamed(context, Home.routeName);
      // _formKey.currentState.save();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('SIGN IN')],
    ),
  ));
}

class GoogleButton extends StatefulWidget {
  const GoogleButton({Key key}) : super(key: key);

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          (OutlinedButton(
              onPressed: () {
                _googleSignIn.signIn().then((userData) {
                  setState(() {
                    _isLoggedIn = true;
                    _userObj = userData;
                    email = _userObj.email;
                    fullname = _userObj.displayName;
                    googleSignin(context);
                    print(_userObj);
                    print(_userObj.displayName);
                    print(_userObj.email);
                  });
                }).catchError((e) {
                  print(e);
                });
              },
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey)),
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
                    'SIGN IN WITH GOOGLE',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ))),
        ],
      ),
    );
  }
}

Widget _noAccount(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Don’t have an account? ",
        style: TextStyle(color: Colors.grey),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Signup()));
          _emailController.clear();
          _passwordController.clear();
        },
        child: Text(
          "Sign up here",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
