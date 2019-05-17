import 'package:flutter/material.dart';
import 'package:flutter_app/UI/QuranWidgets.dart';

class ViewUserProfile extends StatelessWidget {
  ViewUserProfile({Key key, @required user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Mr Nested TabBar',
        theme: ThemeData(brightness: Brightness.light),
        home: Scaffold(body: _viewProfile(context)));
  }
}

Widget _viewProfile(BuildContext context) {
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
                  MaterialPageRoute(builder: (context) => AllQuran()))),
          title: Text("Profile"),
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
                    Center(
                      child: ClipOval(
                          child: Image.network(
                        "https://bit.ly/2JrA9jU",
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
                  'abdullah ehab',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "nrtroz.ae@gmail.com",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )
            ],
          ),
        ),
        DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Basic Info'),
                    Tab(text: 'Education'),
                    Tab(text: 'Experience')
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
                          children: basicInfo,
                        ),
                        new ListView(
                          children: education,
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

List<Widget> basicInfo = <Widget>[
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
                                  "Age: 23 Years Old",
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
                                "Gender: Female",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: const ListTile(
                              title: Text(
                                'Nationality: Egyption',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
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
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: const ListTile(
                              title: Text(
                                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
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

List<Widget> education = <Widget>[
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
                                  "English School",
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
                                  "Thanawya amma (Egyption)",
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
                                  "High Graduation School",
                                  style: TextStyle(fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
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
                                  "Helwan University",
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
                                  "Fine Arts- Decor Department",
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
                                  "University Student",
                                  style: TextStyle(fontSize: 18.0),
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
                              "Cources & Workshops",
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
                                  "English School",
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
                                  "Thanawya amma (Egyption)",
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
                                  "High Graduation School",
                                  style: TextStyle(fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
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
                                  "Helwan University",
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
                                  "Fine Arts- Decor Department",
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
                                  "University Student",
                                  style: TextStyle(fontSize: 18.0),
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
            )
          ],
        ),
      ),
    ],
  )
];
