import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/Pages/viewUserProfile.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/sevices/studentManagment.dart';

//StudentManagement student = new StudentManagement();

class GetAllStudent extends StatefulWidget {
  @override
  _GetAllStudentState createState() => _GetAllStudentState();
}

class _GetAllStudentState extends State<GetAllStudent> {
  StudentManagement studentManagement = new StudentManagement();
  QuerySnapshot students;

//  get studentManagement => null;

  @override
  void initState() {
    studentManagement.getAllStudent().then((results) {
      setState(() {
        students = results;
        print(results);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllQuran()));
              }
          ),
          title: Text("All students"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          color: Colors.deepPurple,
          child: _studentList(),
        ));
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              elevation: 3.0,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(color: Colors.white)),
                              color: Colors.white,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 120.0,
                                      child: Column(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                'https://cdn.pixabay.com/photo/2016/08/20/05/38/avatar-1606916__340.png'),
                                            radius: 57.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 220.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 6.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(students.documents[i].data['name'], style: TextStyle(color: Colors.blue,fontSize: 25.0,fontWeight: FontWeight.bold),),
                                                  SizedBox(width: 10.0,),
                                                  Text(' 23 age', style: TextStyle(fontSize: 17.0),)
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 60.0),
                                              child: Text(students.documents[i].data['email'], style: TextStyle(fontSize: 17.0),),
                                            ),
                                            SizedBox(height: 7.0,),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 160.0),
                                              child: Text(students.documents[i].data['type']),
                                            ),
                                            ListTile
                                              (
                                                trailing: OutlineButton(
                                                    child: Text(
                                                      "Show Profile",
                                                      style: TextStyle(
                                                          color: Colors.deepPurple,
                                                          letterSpacing: 0.2,
                                                          fontFamily: "Sans",
                                                          fontSize: 15.0,
                                                          fontWeight: FontWeight.w900),
                                                    ),
                                                    shape: OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        )),
                                                    borderSide: BorderSide(
                                                        color: Colors.deepPurple[400],
                                                        style: BorderStyle.solid,
                                                        width: 3.0),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                          '/homepage');
                                                    })),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
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
}

/*
*
* Column(
                          children: <Widget>[
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: const ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(top: 40.0),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/08/20/05/38/avatar-1606916__340.png'),
                                      radius: 50.0,
                                    ),
                                  ),
                              ),
                               ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: const ListTile(
                                title: Text(
                                  "s",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )*/
