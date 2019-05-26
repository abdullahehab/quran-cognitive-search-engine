import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  Test({Key key, @required this.snapshot, this.birthDate}) : super(key: key);
  static var now = new DateTime.now();
  var birthDate;
//  static var age = int.parse(birthDate);
   var result = now.year;
  DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('${birthDate - result}'),),
      ),
    );
  }
}
