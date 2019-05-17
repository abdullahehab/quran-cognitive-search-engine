import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';
import 'package:flutter_app/UI/Test.dart';
import 'package:flutter_app/sevices/studentManagment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllStudent extends StatefulWidget {
  @override
  _GetAllStudentState createState() => _GetAllStudentState();
}

class _GetAllStudentState extends State<GetAllStudent> {
  Widget appBarTitle = new Text(
    "All Teacher",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  StudentManagement studentManagement = new StudentManagement();
  final TextEditingController _searchQuery = new TextEditingController();
  SharedPreferences prefs;
  QuerySnapshot students;
  String nickname = '';
  String photoUrl = '';
  bool _isSearching;
  String _searchText = "";

  List _searchResult = [];
  List _userDetails = [];

  _GetAllStudentState() {
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
    // Force refresh input
    setState(() {});
  }

  Future<Null> getUserDetails() async {
    studentManagement.getAllStudent().then((results) {
      setState(() {
        students = results;
        print('results');
        print(results);
      });

      setState(() {
        for (int i = 0; i < students.documents.length; i++) {
          _userDetails.add(students.documents[i].data);
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
          child: _isSearching ? _studentSearchResult() : _studentList(),
        ));
  }

  Widget _studentSearchResult() {
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
                          _searchResult[i]),
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

  Widget _studentList() {
    if (students != null) {
      return ListView.builder(
          itemCount: students.documents.length,
          itemBuilder: (context, i) {
            return new Column(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      menuCard(
                          students.documents[i].data['name'],
                          students.documents[i].data['photoUrl'],
                          students.documents[i].data['type'],
                          students.documents[i].data['education'],
                          students.documents[i]),
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
      return Center(child: Text('loading data'));
    }
  }

  Widget menuCard(String title, String imgPath, String type, String education,
      DocumentSnapshot selected) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(7.0),
        elevation: 4.0,
        child: Container(
          height: 125.0,
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
                            ? 'https://bit.ly/2UBROqC'
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
                    title,
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
                    children: <Widget>[
                      Text(education),
                    ],
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                        child: Text("show Profile"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => Test(
                                        snapshot: selected,
                                      )));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
