import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Tools/const.dart';
import 'package:flutter_app/Tools/snackBar.dart';
import 'dart:async';
//import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/sevices/studentManagment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}
StudentManagement s = new StudentManagement();
class _EditProfileState extends State<EditProfile> {
  DateTime selectedDate = DateTime.now();

  StudentManagement student = StudentManagement();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  SharedPreferences prefs;

  String id = '';
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';
  String email = '';
  String type = '';
  String birthDate = '';
  String stuEducation = '';
  int numOfReading = 0;
  int numOfParts = 0;

  File avatarImageFile;

  TextEditingController _nameText;
  TextEditingController _emailText;
  TextEditingController _jobText;
  TextEditingController _numOfReadingText;
  TextEditingController _numOfPartsText;
  TextEditingController _educationText;

  final FocusNode focusNodeName = new FocusNode();
  final FocusNode focusNodeEmail = new FocusNode();

  String _name, _jobTitle, _numOfReading, _numOfParts, _education, _email;

  final nameIcon = Icons.person_pin;
  final emailIcon = Icons.email;
  final numOfReadingIcon = Icons.bookmark;
  final numOfPartIcons = Icons.person_outline;
  final educationIcon = Icons.school;
  final icon = Icons.work;

  @override
  void initState() {
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? '';
    print(id);
    nickname = prefs.getString('nickname') ?? '';
    //  print(nickname);
    //  aboutMe = prefs.getString('aboutMe') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    email = prefs.getString('email');
    type = prefs.get('userType');
    _education = prefs.get('education');
    numOfReading = prefs.get('numOfReading');
    numOfParts = prefs.get('numOfParts');
    //print(photoUrl);

    _nameText = new TextEditingController(text: nickname);
    _emailText = new TextEditingController(text: email);
    /* _jobText = new TextEditingController(text: _jobTitle);
    _numOfReadingText = new TextEditingController(text: _numOfReading);
    _numOfPartsText = new TextEditingController(text: _numOfParts);
    _educationText = new TextEditingController(text: _education);
*/
    // Force refresh input
    setState(() {});
  }

  @override
  void dispose() {
    _nameText.dispose();
    _emailText.dispose();
    _jobText.dispose();
    _numOfReadingText.dispose();
    _numOfPartsText.dispose();
    _educationText.dispose();
    super.dispose();
  }

  /*Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        avatarImageFile = image;
        //isLoading = true;
      });
    }
    //uploadFile();
  }*/

  Future<void> handleUpdateData() async {
    focusNodeName.unfocus();
    focusNodeEmail.unfocus();

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //String userID = user.uid.toString();
    Firestore.instance
        .collection('users')
        .document(id)
        .updateData({'name': _name, 'email': _email}).then((data) async {
      print(nickname);
      print(email);
      prefs.setString('nickname', _name);
      prefs.setString('email', _email);

      Toast.show('Update success', context,
          duration: Toast.LENGTH_LONG, backgroundColor: Colors.green);
    }).catchError((e) {
      showSnackBar(e.toString(), _scafoldKey);
      print(e.toString());
    });
  }

  //
  var _currencies = ['نعم', 'لا'];
  var _currentItemSelected = 'نعم';

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          key: _scafoldKey,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'images/test.jpeg',
                        ),
                        fit: BoxFit.fill)),
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.0),
                        Color.fromRGBO(0, 0, 0, 0.3)
                      ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                    )),
                    child: SingleChildScrollView(
                      child: Stack(
                        //alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                //alignment: AlignmentDirectional.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Form(
                                        key: _keyForm,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 16.0),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Center(
                                                  child: Stack(
                                                    children: <Widget>[
                                                      (avatarImageFile == null)
                                                          ? (photoUrl != ''
                                                              ? Material(
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            Container(
                                                                              child: CircularProgressIndicator(
                                                                                strokeWidth: 2.0,
                                                                                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                                                                              ),
                                                                              width: 90.0,
                                                                              height: 90.0,
                                                                              padding: EdgeInsets.all(20.0),
                                                                            ),
                                                                    imageUrl:
                                                                        photoUrl,
                                                                    width:
                                                                        100.0,
                                                                    height:
                                                                        100.0,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              50.0)),
                                                                  clipBehavior:
                                                                      Clip.hardEdge,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .account_circle,
                                                                  size: 90.0,
                                                                  color:
                                                                      greyColor,
                                                                ))
                                                          : Material(
                                                              child: Image.file(
                                                                avatarImageFile,
                                                                width: 90.0,
                                                                height: 90.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          45.0)),
                                                              clipBehavior:
                                                                  Clip.hardEdge,
                                                            ),
                                                      IconButton(
                                                        icon: Icon(
                                                          Icons.camera_alt,
                                                          color: primaryColor
                                                              .withOpacity(0.5),
                                                        ),
                                                  //      onPressed: getImage,
                                                        padding: EdgeInsets.all(
                                                            30.0),
                                                        splashColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            greyColor,
                                                        iconSize: 30.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                width: double.infinity,
                                                margin: EdgeInsets.all(20.0),
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              //Name Text Form Filed
                                              TextFromField(
                                                  'Enter your Name',
                                                  nameIcon,
                                                  TextInputType.text,
                                                  _nameText,
                                                  _name,
                                                  focusNodeName),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              TextFromField(
                                                  'Enter your Email',
                                                  emailIcon,
                                                  TextInputType.emailAddress,
                                                  _emailText,
                                                  _email,
                                                  focusNodeEmail),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              /*TextFromField(
                                                  'job title',
                                                  icon,
                                                  TextInputType.text,
                                                  _jobText,
                                                  _jobTitle),
                                              */
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              // Number OF Reading Text For Filed
                                              /*TextFromField(
                                                  'Number Of Reading',
                                                  numOfReadingIcon,
                                                  TextInputType.number,
                                                  _numOfReadingText,
                                                  _numOfReading),
                                              */
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              // Number OF Parts Text Form Field
                                              /*TextFromField(
                                                  'Number Of Parts',
                                                  numOfPartIcons,
                                                  TextInputType.number,
                                                  _numOfPartsText,
                                                  _numOfParts),
                                              */
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              // Education Text Form Field
                                              /*TextFromField(
                                                  'Education',
                                                  educationIcon,
                                                  TextInputType.text,
                                                  _educationText,
                                                  _education),
                                              */
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              ListTile(
                                                title: Text(
                                                  "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                leading: RaisedButton(
                                                  color: Colors.transparent,
                                                  shape: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide: BorderSide(
                                                        color: Colors.teal),
                                                  ),
                                                  onPressed: () =>
                                                      _selectDate(context),
                                                  child: Text(
                                                    'Birthday',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              /************************************************************/
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              ListTile(
                                                title:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    items: _currencies.map(
                                                        (String
                                                            dropDownStringItem) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value:
                                                            dropDownStringItem,
                                                        child: new Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          30.0),
                                                            ),
                                                            new Text(
                                                                dropDownStringItem),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String
                                                        newValueSelected) {
                                                      //your code to execute , when a menu item is selected from drop down
                                                      _onDropDownItemSelected(
                                                          newValueSelected);
                                                    },
                                                    value: _currentItemSelected,
                                                  ),
                                                ),
                                                leading: RaisedButton(
                                                  color: Colors.transparent,
                                                  shape: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide: BorderSide(
                                                        color: Colors.teal),
                                                  ),
                                                  onPressed: () => {},
                                                  child: Text(
                                                    ' ايجازه ',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30.0, left: 30.0),
                                                child: new Container(
                                                    height: 55.0,
                                                    width: 600.0,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black38,
                                                              blurRadius: 15.0)
                                                        ],
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Colors.teal[400],
                                                              Colors.teal[400]
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    30.0)),
                                                    child: FlatButton(
                                                      child: Text(
                                                        "Update",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "UbuntuBold"),
                                                      ),
                                                      onPressed: () {
                                                        print(_nameText);
                                                        print(_emailText);
                                                        /* if (nameController.text == "" ||
    emailController.text == "" ||
    jobController.text == "" ||
    numOfReadingController.text == "" ||
    numOfPartsController.text == "" ||
    educationController.text == "") {
    showSnackBar("All Fields required", _scafoldKey);
    return;
    }*/
                                                        //handleUpdateData();
                                                        s.updateStudent(id, _nameText.text,_emailText.text, context);
                                                        //print(nameController.text);
                                                      },
                                                    )),
                                              )
                                              /*     GeneralButton(
                                                  _nameText,
                                                  _jobText,
                                                  _numOfReadingText,
                                                  _numOfPartsText,
                                                  _educationText,
                                                  _emailText,
                                                  _scafoldKey),
                                         */ //separator,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}

///ButtonBlack class
class GeneralButton extends StatelessWidget {
  TextEditingController nameController,
      jobController,
      numOfReadingController,
      numOfPartsController,
      educationController,
      emailController;
  GlobalKey<ScaffoldState> _scafoldKey;

  GeneralButton(
      this.nameController,
      this.jobController,
      this.numOfReadingController,
      this.numOfPartsController,
      this.educationController,
      this.emailController,
      this._scafoldKey);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0, left: 30.0),
      child: new Container(
          height: 55.0,
          width: 600.0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
              gradient:
                  LinearGradient(colors: [Colors.teal[400], Colors.teal[400]]),
              borderRadius: BorderRadius.circular(30.0)),
          child: FlatButton(
            child: Text(
              "Update",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "UbuntuBold"),
            ),
            onPressed: () {
              if (nameController.text == "" ||
                  emailController.text == "" ||
                  jobController.text == "" ||
                  numOfReadingController.text == "" ||
                  numOfPartsController.text == "" ||
                  educationController.text == "") {
                showSnackBar("All Fields required", _scafoldKey);
                return;
              }
              //         handleUdpateData();
              print(nameController.text);
            },
          )),
    );
  }
}

class TextFromField extends StatelessWidget {
  TextFromField(this.name, this.icon, this.inputType, this.controller,
      this.inputValue, this.focusNodeName);

  String name;
  IconData icon;
  TextInputType inputType;
  TextEditingController controller;
  String inputValue;
  FocusNode focusNodeName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            //color: Colors.white,
            //boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]
            border: Border(
                top: BorderSide(color: Colors.teal),
                bottom: BorderSide(color: Colors.teal),
                right: BorderSide(color: Colors.teal),
                left: BorderSide(color: Colors.teal))),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            onSaved: (val) {
              inputValue = val;
            },
            focusNode: focusNodeName,
            controller: controller,
            decoration: InputDecoration(
                labelText: name,
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}
