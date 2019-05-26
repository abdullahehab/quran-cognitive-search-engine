import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/Tools/const.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this._userName, this._avatar);

//  DocumentSnapshot selected;
  final String _userName;
  final String _avatar;

  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.all(7.0),
            child: CircleAvatar(
              child: Image.network(widget._avatar),
            ),
          ),
          title: Text(widget._userName),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("chat_room")
                      .orderBy("created_at", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return new ListView.builder(
                      padding: new EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (_, int index) {
                        DocumentSnapshot document =
                            snapshot.data.documents[index];
                        bool isOwnMessage = false;
                        print('start name');
                        print(document['user_name']);
                        print(widget._userName);
                        print(('end name'));
                        if (document['user_name'] == widget._userName) {
                          isOwnMessage = true;
                        }
                        return isOwnMessage
                            ? _ownMessage(document['message'],
                                document['user_name'], widget._avatar)
                            : _message(document['message'],
                                document['user_name'], document['photoUrl']);
                      },
                      itemCount: snapshot.data.documents.length,
                    );
                  },
                ),
              ),
              new Divider(height: 1.0),
              Container(
                margin: EdgeInsets.only(bottom: 20.0, right: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    new Flexible(
                      child: new TextField(
                        controller: _controller,
                        onSubmitted: _handleSubmit,
                        decoration: new InputDecoration.collapsed(
                            hintText: "send message"),
                      ),
                    ),
                    new Container(
                      child: new IconButton(
                          icon: new Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _handleSubmit(_controller.text);
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _ownMessage(String message, String userName, String photoUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      DecoratedBox(
                        position: DecorationPosition.background,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              message,
                            ),
                          ),
                        ),
                      ),
                      Positioned(right: 2, bottom: 31, child: triangle),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.network(photoUrl == null ? '' : photoUrl),
            )
//          Material(
//            child: CachedNetworkImage(
//              placeholder: (context, url) => Container(
//                    child: CircularProgressIndicator(
//                      strokeWidth: 1.0,
//                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                    ),
//                    width: 35.0,
//                    height: 35.0,
//                    padding: EdgeInsets.all(10.0),
//                  ),
//              imageUrl: widget._avatar,
//              width: 35.0,
//              height: 35.0,
//              fit: BoxFit.cover,
//            ),
//            borderRadius: BorderRadius.all(
//              Radius.circular(18.0),
//            ),
//            clipBehavior: Clip.hardEdge,
//          ),
            )
      ],
    );
  }

  var triangle = CustomPaint(
    painter: Triangle(),
  );
  Widget _message(String message, String userName, String photoUrl) {
    return Row(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.network(
                photoUrl == null ? "" : photoUrl,
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned(left: 2, bottom: 30, child: triangle),
                      DecoratedBox(
                        position: DecorationPosition.background,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(message),
                          ),
                        ),
                      ),
                    ],
                  )
//                  Text(message),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _handleSubmit(String message) {
    _controller.text = "";
    var db = Firestore.instance;
    db.collection("chat_room").add({
      "user_name": widget._userName,
      "message": message,
      "photoUrl": widget._avatar,
      "created_at": DateTime.now()
    }).then((val) {
      print("sucess");
    }).catchError((err) {
      print(err);
    });
  }
}

class Triangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.amber;

    var path = Path();
    path.lineTo(10, 0);
    path.lineTo(0, -10);
    path.lineTo(-10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
