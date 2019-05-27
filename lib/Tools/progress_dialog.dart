import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  String message;

  ProgressDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black.withAlpha(200),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(message,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

displayProgressDialog(BuildContext context, String message) {
  Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext, _, __) {
    return ProgressDialog(message);
  }));
}

closeProgressDialog(BuildContext context) {
  Navigator.pop(context);
}