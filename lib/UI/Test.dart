import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {

  Test({Key key, @required this.snapshot}) : super(key: key);

  DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text(snapshot.data['name']),),
      ),
    );
  }
}
