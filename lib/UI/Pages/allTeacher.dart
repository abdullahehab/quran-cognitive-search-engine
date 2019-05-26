import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/Tools/const.dart';
import 'package:flutter_app/UI/Pages/ChatPage.dart';
import 'package:flutter_app/UI/Pages/UserDetails.dart';
import 'package:flutter_app/UI/Pages/viewUserProfile.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';
import 'package:flutter_app/sevices/teacherManagement.dart';
import 'package:shared_preferences/shared_preferences.dart';
class GetAllTeacher extends StatefulWidget {
  @override
  _GetAllTeacherState createState() => _GetAllTeacherState();
}

class _GetAllTeacherState extends State<GetAllTeacher> {
  Widget appBarTitle = new Text(
    "All Teacher",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  TeacherManagement teacherManagement = new TeacherManagement();
  final TextEditingController _searchQuery = new TextEditingController();
  SharedPreferences prefs;
  QuerySnapshot teachers;
  QuerySnapshot searchResult;
  String nickname = '';
  String photoUrl = '';
  String birthDate = '';
  bool _isSearching;
  String _searchText = "";
  List _searchResult = [];
  List _userDetails = [];

  _GetAllTeacherState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    _isSearching = false;
    readLocal();
    getUserDetails();
    super.initState();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    birthDate = prefs.getString('birthdate') ?? '';
    // Force refresh input
    setState(() {});
  }

  Future<Null> getUserDetails() async {
    teacherManagement.getAllTeacher().then((results) {
      setState(() {
        teachers = results;
        print('results');
        print(results);
      });

      setState(() {
        for (int i = 0; i < teachers.documents.length; i++) {
          _userDetails.add(teachers.documents[i].data);
          final user = UserDetails();

        }
      });
    });
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.deepPurple,
        title: appBarTitle,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AllQuran()));
            }),
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    onChanged: onSearchTextChanged,
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  onSearchTextChanged(String text) async {
    print(text);
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (int i = 0; i < _userDetails.length; i++) {
      if (_userDetails[i]['name'].toString().toLowerCase().contains(text)) {
        _searchResult.add(_userDetails[i]);
        print(_userDetails[i]['name']);
      }
    }
    setState(() {});
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "All teachers",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchQuery.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildBar(context),
        body: Container(
          color: Colors.deepPurple,
          child: _isSearching ? _teacherSearchResult() : _teacherList(),
        ));
  }

  Widget _teacherSearchResult() {
    if (_searchResult != null) {
      return ListView.builder(
          itemCount: _searchResult.length,
          itemBuilder: (context, i) {
            return new Column(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      menuCard(
                          _searchResult[i]['name'],
                          _searchResult[i]['photoUrl'],
                          _searchResult[i]['type'],
                          _searchResult[i]['education'],
                          _searchResult[i],
                          _userDetails[i]['birth']),
                      SizedBox(
                        height: 12.0,
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    }
  }

  Widget _teacherList() {
    if (teachers != null) {
      return ListView.builder(
          itemCount: teachers.documents.length,
          itemBuilder: (context, i) {
            return new Column(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      menuCard(
                        teachers.documents[i].data['name'],
                        teachers.documents[i].data['photoUrl'],
                        teachers.documents[i].data['type'],
                        teachers.documents[i].data['education'],
                        teachers.documents[i],
                        _userDetails[i]['birth'],),
                      SizedBox(
                        height: 12.0,
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    } else {
      return Center(
        child: Container(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(themeColor),
          ),
          width: 90.0,
          height: 90.0,
          padding: EdgeInsets.all(20.0),
        ),
      );
    }
  }

  Widget menuCard(String name, String imgPath, String type, String education,
      var selected, String birthDate) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(7.0),
        elevation: 4.0,
        child: Container(
          height: 150.0,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0), color: Colors.white),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  //hena bya5od el path bta3 el-image wy7tha 3la el-4mal
                    image: DecorationImage(
                        image: NetworkImage(imgPath == null
                            ? 'https://bit.ly/2JLl7EM'
                            : imgPath),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(7.0)),
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[Text('${type}')],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        color: Color(0xFFFA624F),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(name, imgPath)));
                        },
                        child: Text(
                          'Message',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      FlatButton(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewUserProfile(
                                    snapshot: selected,
                                    birthDate: int.parse(birthDate),
                                  )));
                        },
                        child: Text(
                          'Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
