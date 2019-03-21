import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_app/sevices/studentManagment.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

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

  String _email, _password, _name;
  bool _sel = false;

  //
  var _currencies = ['نعم', 'لا'];
  var _currentItemSelected = 'نعم';

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = new TextEditingController();

  final separator = Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// To set white line
          Container(
            color: Colors.white,
            height: 1.5,
            width: 135.0,
          ),

          /// To set white line
          Container(
            color: Colors.white,
            height: 1.2,
            width: 110.0,
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
          body:
          Stack(
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
                                              horizontal: 10.0, vertical: 50.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Column(
                                                        children: <Widget>[
                                                          CircleAvatar(
                                                            backgroundColor:
                                                            Colors.teal,
                                                            radius: 70.0,
                                                            child: Image.asset(
                                                              "image/DSC_0065.JPG",
                                                              width: 80.0,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.camera_alt,
                                                            color: Colors.red,
                                                            size: 25.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                                child:
                                                                new Container(
                                                                  // margin: EdgeInsets.only(top: 10.0),
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  /* height: 52.0,*/
                                                                  width: 210.0,

                                                                  decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          20.0),
                                                                      //color: Colors.white,
                                                                      //boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]
                                                                      border: Border(
                                                                          top: BorderSide(
                                                                              color: Colors
                                                                                  .teal),
                                                                          bottom:
                                                                          BorderSide(color: Colors.teal),
                                                                          right: BorderSide(color: Colors.teal),
                                                                          left: BorderSide(color: Colors.teal))),
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      20.0,
                                                                      right:
                                                                      30.0,
                                                                      top: 0.0,
                                                                      bottom:
                                                                      0.0),
                                                                  child: Theme(
                                                                    data: ThemeData(
                                                                      hintColor: Colors
                                                                          .transparent,
                                                                    ),
                                                                    child:
                                                                    TextFormField(
                                                                      onSaved: (value) {
                                                                        this._name = value;
                                                                      },
                                                                      decoration:
                                                                      InputDecoration(
                                                                          labelText:
                                                                          'First Name',
                                                                          icon:
                                                                          Icon(
                                                                            Icons.account_circle,
                                                                            color:
                                                                            Colors.white,
                                                                          ),
                                                                          labelStyle: TextStyle(
                                                                              fontSize: 15.0,
                                                                              fontFamily: 'Sans',
                                                                              letterSpacing: 0.3,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w600)),
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                                child:
                                                                new Container(
                                                                  // margin: EdgeInsets.only(top: 10.0),
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  height: 59.0,
                                                                  width: 210.0,

                                                                  decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          20.0),
                                                                      //color: Colors.white,
                                                                      //boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]
                                                                      border: Border(
                                                                          top: BorderSide(
                                                                              color: Colors
                                                                                  .teal),
                                                                          bottom:
                                                                          BorderSide(color: Colors.teal),
                                                                          right: BorderSide(color: Colors.teal),
                                                                          left: BorderSide(color: Colors.teal))),
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      20.0,
                                                                      right:
                                                                      30.0,
                                                                      top: 0.0,
                                                                      bottom:
                                                                      0.0),
                                                                  child: Theme(
                                                                    data: ThemeData(
                                                                      hintColor: Colors
                                                                          .transparent,
                                                                    ),
                                                                    child:
                                                                    TextFormField(
                                                                      decoration:
                                                                      InputDecoration(
                                                                          labelText:
                                                                          'Last Name',
                                                                          icon:
                                                                          Icon(
                                                                            Icons.account_circle,
                                                                            color:
                                                                            Colors.white,
                                                                          ),
                                                                          labelStyle: TextStyle(
                                                                              fontSize: 15.0,
                                                                              fontFamily: 'Sans',
                                                                              letterSpacing: 0.3,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w600)),
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),

                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              TextFormField(
                                                onSaved: (value) {
                                                  this._email = value;
                                                },
                                                decoration:
                                                InputDecoration(
                                                    labelText:
                                                    'enter you email',
                                                    icon:
                                                    Icon(
                                                      Icons.account_circle,
                                                      color:
                                                      Colors.white,
                                                    ),
                                                    labelStyle: TextStyle(
                                                        fontSize: 15.0,
                                                        fontFamily: 'Sans',
                                                        letterSpacing: 0.3,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600)),
                                              ),//Email
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              textFromFieldpassword(),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              textFromFieldtype(),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              textFrom(),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              textFromFieldpass(),
                                              SizedBox(
                                                height: 15.0,
                                              ),
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
                                                    BorderRadius.circular(10.0),
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
                                                title: DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                      fontSize: 20.0,
                                                    ),
                                                    items: _currencies.map((String
                                                    dropDownStringItem) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: dropDownStringItem,
                                                        child: new Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 30.0),
                                                            ),
                                                            new Text(
                                                                dropDownStringItem),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String newValueSelected) {
                                                      //your code to execute , when a menu item is selected from drop down
                                                      _onDropDownItemSelected(
                                                          newValueSelected);
                                                    },
                                                    value: _currentItemSelected,
                                                  ),
                                                ),
                                                //leading:Text("gggggggggggggggggg", style: TextStyle(color: Colors.white), ),
                                                leading: RaisedButton(
                                                  color: Colors.transparent,
                                                  shape: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
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
                                                height: 20.0,
                                              ),
                                              InkWell(
                                                child: ButtonSaveProfile(),
                                                onTap: () {
                                                  student.updateStudent(context, {
                                                    'name': this._name,
                                                    'email': this._email
                                                  });
                                                },
                                              ),
                                              InkWell(
                                                child: ButtonBlackBottom(),
                                                onTap: () {},
                                              ),
                                              //separator,
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
          )
      ),

    );
  }

  Future<bool> UpdateForm(BuildContext context) async {

  }
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
}

///ButtonBlack class
class ButtonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Cancel",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        /*rgb(5, 206, 158)*/
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Colors.teal[400], Colors.teal[400]])),
      ),
    );
  }
}

class ButtonSaveProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Save Profile",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        /*rgb(5, 206, 158)*/
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Colors.teal[400], Colors.teal[400]])),
      ),
    );
  }
}
//7teh hena

class textFromField extends StatelessWidget {
  //bool password;
  String label;
  IconData icon;
  String email;
  //TextInputType inputType;

  textFromField(this.label, this.icon);

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
            decoration: InputDecoration(
                labelText: this.label,
                icon: Icon(
                  this.icon,
                  color: Colors.white,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            // keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}

class textFromFieldpass extends StatelessWidget {
  String namee;
  IconData icon;
  TextInputType inputType;

  textFromFieldpass({
    this.namee,
    this.icon,
    this.inputType,
  });

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
            decoration: InputDecoration(
                labelText: 'حاصل علي',
                icon: Icon(
                  Icons.account_circle,
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

class textFromFieldtype extends StatelessWidget {
  String num;
  IconData icon;
  TextInputType inputType;

  textFromFieldtype({
    this.num,
    this.icon,
    this.inputType,
  });

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
            decoration: InputDecoration(
                labelText: 'عدد القراءات',
                icon: Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    );
  }
}

class textFrom extends StatelessWidget {
  String num;
  IconData icon;
  TextInputType inputType;

  textFrom({
    this.num,
    this.icon,
    this.inputType,
  });

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
            decoration: InputDecoration(
                labelText: 'عدد الاجزاء',
                icon: Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    );
  }
}

class textFromFieldpassword extends StatelessWidget {
  String namee;
  IconData icon;
  TextInputType inputType;

  textFromFieldpassword({
    this.namee,
    this.icon,
    this.inputType,
  });

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
            decoration: InputDecoration(
                labelText: 'Job Title',
                icon: Icon(
                  Icons.work,
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

class Checkox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*
class Checkbox extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<Checkbox>{

  bool _value1 = false;
  bool _value2 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Checkbox(
                  value: _value1,
                  onChanged: _value1Changed
              ),
              new CheckboxListTile(
                value: _value2,
                onChanged: _value2Changed,
                title: new Text('Hello World'),
                controlAffinity: ListTileControlAffinity.leading,
                subtitle: new Text('Subtitle'),
                secondary: new Icon(Icons.archive),
                activeColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

/*
class Demo extends StatefulWidget {
  @override
  DemoState createState() => new DemoState();
}

class DemoState extends State<Demo> {
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: values.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: values[key],
            onChanged: (bool value) {
              setState(() {
                values[key] = value;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
*/
