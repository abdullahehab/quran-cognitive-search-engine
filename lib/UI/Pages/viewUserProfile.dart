import 'package:QCSE/Tools/const.dart';
import 'package:QCSE/UI/Pages/allStudent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewUserProfile extends StatelessWidget {
  ViewUserProfile({Key key, @required this.snapshot, this.birthDate, this.user})
      : super(key: key);

  List user;
  int birthDate;
  DocumentSnapshot snapshot;
  var now = new DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light),
        home: Scaffold(body: _viewProfile(context, snapshot, birthDate, now)));
  }
}

Widget _viewProfile(
    BuildContext context, DocumentSnapshot snapshot, int date, var now) {
  return Scaffold(
      body: Stack(
    children: <Widget>[
      Container(
        color: Colors.deepPurple,
        height: 200.0,
      ),
      ListView(children: [
        AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GetAllStudent()))),
          title: Text(snapshot.data['name']),
          backgroundColor: Colors.deepPurple,
        ),
        Container(
          color: Colors.deepPurple,
          height: 250.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    snapshot.data['photoUrl'] == null
                        ? CachedNetworkImage(
                            placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        themeColor),
                                  ),
                                  width: 90.0,
                                  height: 90.0,
                                  padding: EdgeInsets.all(20.0),
                                ),
                            imageUrl: "https://bit.ly/2JLl7EM",
                            width: 90.0,
                            height: 90.0,
                            fit: BoxFit.cover,
                          )
                        : snapshot.data['photoUrl'] != null
                            ? Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  themeColor),
                                        ),
                                        width: 90.0,
                                        height: 90.0,
                                        padding: EdgeInsets.all(20.0),
                                      ),
                                  imageUrl: snapshot.data['photoUrl'],
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45.0)),
                                clipBehavior: Clip.hardEdge,
                              )
                            : Center(
                                child: ClipOval(
                                    child: Image.network(
                                  snapshot.data['photoUrl'],
//                        "https://bit.ly/2JrA9jU",
                                  fit: BoxFit.cover,
                                  width: 90.0,
                                  height: 90.0,
                                )),
                              )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  snapshot.data['name'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                snapshot.data['email'],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )
            ],
          ),
        ),
        DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Basic Info'),
                    Tab(text: 'Education'),
//                    Tab(text: 'Experience')
                  ],
                  labelColor: Colors.black,
                  indicatorColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.teal,
                ),
                Container(
                    height: 300.0,
                    child: TabBarView(
                      children: [
                        new ListView(
                          children: basicInfo(
                              snapshot.data['name'],
                              date,
                              snapshot.data['gender'],
                              snapshot.data['aboutMe'],
                              snapshot.data['education'],
                              now),
                        ),
                        new ListView(
                          children: education(
                            snapshot.data['education'],
                            snapshot.data['university'],
                            snapshot.data['numberOfParts'],
                            snapshot.data['numberOfReading'],
                            snapshot.data['igaza'],
                            snapshot.data['jobTitle'],
                            snapshot.data['type'],
                          ),
                        ),
                        Center(child: Text('Education here')),
                        Center(child: Text('Experience here')),
                      ],
                    ))
              ],
            ))
      ]),
    ],
  ));
}

List<Widget> basicInfo(String name, int age, String gender, String aboutMe,
        String education, var now) =>
    <Widget>[
      Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3.0,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.white)),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const ListTile(
                                subtitle: Text(
                                  'Personal Info.',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 19.0),
                                    child: Text(
                                      "Age: ${now - age} Years Old",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Text(
                                    "Gender: ${gender}",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 19.0),
                                      child: Text(
                                        "Education: ${education}",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3.0,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.white)),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const ListTile(
                                subtitle: Text(
                                  'About Me',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Padding(
                                            padding:
                                            const EdgeInsets.all(10.0),
                                            child: Text(
                                              '${aboutMe}',
                                              style: TextStyle(fontSize: 16.0),
                                            )
                                        ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ];

List<Widget> education(String education, String university, String numOfParts,
        String numOfReading, String userType, String igaza, String type) =>
    <Widget>[
      Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3.0,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.white)),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const ListTile(
                                subtitle: Text(
                                  "Academic Education",
                                  style: TextStyle(fontSize: 22.0),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Icon(Icons.school),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "$university University",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 65.0, top: 3.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "$education",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 65.0, top: 3.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "$university",
                                      style: TextStyle(fontSize: 18.0),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3.0,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.white)),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const ListTile(
                                subtitle: Text(
                                  "Islamic Education",
                                  style: TextStyle(fontSize: 22.0),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Icon(Icons.school),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "Islamic Education",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 65.0, top: 3.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Number of Reading : ${numOfReading}",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 65.0, top: 3.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Number Or Parts : ${numOfParts}",
                                      style: TextStyle(fontSize: 18.0),
                                    )
                                  ],
                                ),
                              ),
                              type == 'Teacher'
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 65.0, top: 3.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Igaza : ${userType}",
                                            style: TextStyle(fontSize: 18.0),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: 30.0,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )
    ];
