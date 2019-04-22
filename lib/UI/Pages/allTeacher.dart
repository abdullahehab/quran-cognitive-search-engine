import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/Pages/ChatPage.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';
import 'package:flutter_app/sevices/teacherManagement.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/sevices/teacherManagement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllTeacher extends StatefulWidget {
  @override
  _GetAllTeacherState createState() => _GetAllTeacherState();
}


class _GetAllTeacherState extends State<GetAllTeacher> {
  TeacherManagement teacherManagement = new TeacherManagement();
  SharedPreferences prefs;
  QuerySnapshot teachers;
  String nickname = '';
  String photoUrl = '';

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    nickname = prefs.getString('nickname') ?? '';
    photoUrl = prefs.getString('photoUrl') ?? '';
    // Force refresh input
    setState(() {});
  }

  @override
  void initState() {
    teacherManagement.getAllTeacher().then((results) {
      setState(() {
        teachers = results;
      });
    });
    readLocal();
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
              onPressed: () =>
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AllQuran()
                  )
                  )
          ),
          title: Text("All teachers"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          color: Colors.deepPurple,
          child: _studentList(),
        ));
  }

  Widget _studentList() {
    if (teachers != null) {
      return ListView.builder(
          itemCount: teachers.documents.length,
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
                                                    Text(teachers.documents[i].data['name'], style: TextStyle(color: Colors.blue,fontSize: 25.0,fontWeight: FontWeight.bold),),
                                                    SizedBox(width: 10.0,),
                                                    Text(' 23 age', style: TextStyle(fontSize: 17.0),)
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                /*teachers.documents[i].data['email']*/
                                                padding: const EdgeInsets.only(right: 60.0),
                                                child: Text('test email', style: TextStyle(fontSize: 17.0),),
                                              ),
                                              SizedBox(height: 7.0,),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 160.0),
                                                child: Text(teachers.documents[i].data['type']),
                                              ),
                                              ListTile
                                                (
                                                  trailing: OutlineButton(
                                                      child: Text(
                                                        "Chat",
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
                                                        Navigator.push(
                                                            context, MaterialPageRoute(builder: (builder) => ChatPage(nickname, photoUrl)));

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
