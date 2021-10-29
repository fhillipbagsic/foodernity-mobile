import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/Pages/AccountPage/profilepage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';

GlobalKey<FormState> _homeKey = GlobalKey<FormState>();
var refreshKey = GlobalKey<RefreshIndicatorState>();

var EditFullName = "";
var EditCurrentPass = "";
var EditNewPass = "";
File _image;

// SharedPreferences prefs;

var loginMethodLocal = "";
var fullNameLocal = "";
var imageLocal = "";
var _NameController = TextEditingController();
var _CurrentPassController = TextEditingController();
var _NewPassController = TextEditingController();

void saveChangesBtnFnc(context) async {
  final cloudinary = CloudinaryPublic('dftq12ab0', 'b4jy8nar', cache: false);
  final prefs = await SharedPreferences.getInstance();

  loginMethodLocal = prefs.getString("loginMethod");

  if (loginMethodLocal == "google") {
    var email = prefs.getString("email");
    var profilePicture = prefs.getString("profilePicture");
    var fullName = prefs.getString("fullName");

    if (_image != null) {
      //kapag binago yung image
      CloudinaryResponse responseImg = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(_image.path,
            resourceType: CloudinaryResourceType.Image),
      );

      print(responseImg.secureUrl);

      http.Response response = await http.post(
          "https://foodernity.herokuapp.com/user/updateUserDetailsGoogle",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'profilePicture': responseImg.secureUrl,
            'fullName': _NameController.text
          }));

      print(response.body);
      print("nagbago ako ng image");
      prefs.setString('profilePicture', responseImg.secureUrl);
      prefs.setString('fullName', _NameController.text);
    } else {
      // kapag di binago yung image
      http.Response response = await http.post(
          "https://foodernity.herokuapp.com/user/updateUserDetailsGoogle",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'profilePicture': profilePicture,
            'fullName': _NameController.text
          }));
      print(response.body);
      print("di ako nagbago ng image");
      prefs.setString('profilePicture', profilePicture);
      prefs.setString('fullName', _NameController.text);
    }
  } else {
    var email = prefs.getString("email");
    var profilePicture = prefs.getString("profilePicture");
    var fullName = prefs.getString("fullName");
    var password = prefs.getString("password");

    if (_image != null) {
      //kapag binago yung image

      if (password == _CurrentPassController.text) {
        // if tama yung password, goods

        if (_CurrentPassController.text == _NewPassController.text) {
          //Bawal gamitin ang same pass
          print("Bawal gamitin same pass");
        } else {
          CloudinaryResponse responseImg = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(_image.path,
                resourceType: CloudinaryResourceType.Image),
          );

          print(responseImg.secureUrl);

          http.Response response = await http.post(
              "https://foodernity.herokuapp.com/user/updateUserDetailsDefault",
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'email': email,
                'profilePicture': responseImg.secureUrl,
                'fullName': _NameController.text,
                'password': _NewPassController.text
              }));

          print(response.body);
          print("nagbago ako ng image");
          prefs.setString('profilePicture', responseImg.secureUrl);
          prefs.setString('fullName', _NameController.text);
        }
      } else {
        //Mali password mo
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Mali Password',
                style: TextStyle(color: Colors.redAccent)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("Close"),
              ),
            ],
          ),
        );
      }
    } else {
      // kapag di binago yung image
      if (password == _CurrentPassController.text) {
        // if tama yung password, goods

        if (_CurrentPassController.text == _NewPassController.text) {
          //Bawal gamitin ang same pass
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Same password are not allowed',
                  style: TextStyle(color: Colors.redAccent)),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          );
        } else {
          // CloudinaryResponse responseImg = await cloudinary.uploadFile(
          //   CloudinaryFile.fromFile(_image.path,
          //       resourceType: CloudinaryResourceType.Image),
          // );

          // print(responseImg.secureUrl);

          http.Response response = await http.post(
              "https://foodernity.herokuapp.com/user/updateUserDetailsDefault",
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'email': email,
                'profilePicture': profilePicture,
                'fullName': _NameController.text,
                'password': _NewPassController.text
              }));

          print(response.body);
          print("di ako nagbago ng image");
          prefs.setString('profilePicture', profilePicture);
          prefs.setString('fullName', _NameController.text);
        }
      } else {
        //Mali password mo
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Mali Password',
                style: TextStyle(color: Colors.redAccent)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("Close"),
              ),
            ],
          ),
        );

        print("Mali password");
      }
    }
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null && pickedFile.path != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preLoad();
  }

  void preLoad() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullNameLocal = prefs.getString("fullName");
      loginMethodLocal = prefs.getString("loginMethod");
      _NameController.text = fullNameLocal;
      imageLocal = prefs.getString("profilePicture");
    });
    print(loginMethodLocal + " preload");
  }

  Future<void> refreshEditProfile() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      // limit = random.nextInt(10);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 40;
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(
            key: refreshKey,
            onRefresh: refreshEditProfile,
            child: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                leading: GestureDetector(
                  onTap: () {
                    debugPrint('Back button tapped');
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(CupertinoIcons.left_chevron,
                          color: CupertinoColors.activeBlue),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                middle: Text('Edit Profile'),
              ),
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      width: width,
                      child: Form(
                        key: _homeKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            Container(
                              child: SizedBox(
                                height: 115,
                                width: 115,
                                child: Stack(
                                  fit: StackFit.expand,
                                  overflow: Overflow.visible,
                                  children: [
                                    (_image == null)
                                        ? CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(imageLocal),
                                          )
                                        : ClipOval(
                                            child: Image.file(
                                              _image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                    Positioned(
                                      right: -16,
                                      bottom: 0,
                                      child: SizedBox(
                                        height: 46,
                                        width: 46,
                                        child: FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            side:
                                                BorderSide(color: Colors.white),
                                          ),
                                          color: Color(0xFFF5F6F9),
                                          onPressed: () {
                                            getImage();
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/Camera Icon.svg"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            _fullNameTextField(context),
                            SizedBox(
                              height: 6.0,
                            ),
                            (loginMethodLocal == "default")
                                ? _currentPass(context)
                                : _currentPassDisabled(context),
                            SizedBox(
                              height: 6.0,
                            ),
                            (loginMethodLocal == "default")
                                ? _newPass(context)
                                : _newPassDisabled(context),
                            SizedBox(
                              height: 30.0,
                            ),
                            _saveChanges(context),
                            SizedBox(
                              height: 10.0,
                            ),
                            _cancelChanges(context)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget _fullNameTextField(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height / 14;
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    child: Column(
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 10.0),
              child: Text(
                "Full Name",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        (TextFormField(
          controller: _NameController,
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
                  _NameController.text = value;
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
            EditFullName = value;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[300],
            hintText: fullNameLocal,
            hintStyle: TextStyle(color: Colors.black),
          ),
        ))
      ],
    ),
  );
}

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'^[a-zA-Z0-9]+$',
      errorText: 'passwords must not have special character')
]);

Widget _currentPass(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height / 14;
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    child: Column(
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 10.0),
              child: Text(
                "Current Password",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        (TextFormField(
          obscureText: true,
          controller: _CurrentPassController,
          validator: passwordValidator,
          onSaved: (value) {
            _CurrentPassController.text = value;
          },
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[300],
            border: InputBorder.none,
            hintText: 'Enter Here',
            hintStyle: TextStyle(color: Colors.black),
          ),
        ))
      ],
    ),
  );
}

Widget _currentPassDisabled(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height / 14;
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    child: Column(
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 10.0),
              child: Text(
                "Current Password",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        (TextFormField(
          enabled: false,
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[300],
            border: InputBorder.none,
            hintText: 'Disabled',
            hintStyle: TextStyle(color: Colors.black),
          ),
        ))
      ],
    ),
  );
}

Widget _newPassDisabled(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height / 14;
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    child: Column(
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 10.0),
              child: Text(
                "New Password",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        (TextFormField(
          enabled: false,
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[300],
            border: InputBorder.none,
            hintText: 'Disabled',
            hintStyle: TextStyle(color: Colors.black),
          ),
        ))
      ],
    ),
  );
}

Widget _newPass(context) {
  var width = MediaQuery.of(context).size.width - 40;
  var height = MediaQuery.of(context).size.height / 14;
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    child: Column(
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 10.0),
              child: Text(
                "New Password",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        (TextFormField(
          obscureText: true,
          controller: _NewPassController,
          validator: passwordValidator,
          onSaved: (value) {
            _NewPassController.text = value;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            // border: OutlineInputBorder(),
            border: InputBorder.none,
            hintText: 'Enter Here',
            hintStyle: TextStyle(color: Colors.black),
          ),
        ))
      ],
    ),
  );
}

Widget _saveChanges(context) {
  var width = MediaQuery.of(context).size.width - 40;
  return Container(
    child: Align(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () {
          if (!_homeKey.currentState.validate()) {
            return;
          }
          saveChangesBtnFnc(context);
          // print(EditFullName);
          // print(_CurrentPassController.text);
          // print(_NewPassController.text);
          // print(_image);
        },
        minWidth: width,
        height: 45,
        color: Colors.green,
        child: Text('Save Changes',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                color: Colors.white)),
        shape: RoundedRectangleBorder(
            // side: BorderSide(
            //     color: Colors.blue, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}

Widget _cancelChanges(context) {
  var width = MediaQuery.of(context).size.width - 40;
  return Container(
    child: Align(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () {
          // Navigator.pushNamed(
          //     context, PostDonationSummary.routeName);
        },
        minWidth: width,
        height: 45,
        color: Colors.redAccent,
        child: Text('Cancel Changes',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
                color: Colors.white)),
        shape: RoundedRectangleBorder(
            // side: BorderSide(
            //     color: Colors.blue, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
