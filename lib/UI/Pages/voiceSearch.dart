import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medcorder_audio/medcorder_audio.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class VoiceSearch extends StatefulWidget {
  @override
  _VoiceSearchState createState() => _VoiceSearchState();
}

class _VoiceSearchState extends State<VoiceSearch> {
  MedcorderAudio audioModule = new MedcorderAudio();
  bool canRecord = false;
  double recordPower = 0.0;
  double recordPosition = 0.0;
  bool isRecord = false;
  bool isPlay = false;
  double playPosition = 0.0;
  String file = "";
  String fileUrl = "";

  Future<void> fetchData() async {
    await convertFileActionApi(fileUrl).then((response) {
      print(response);
      return response;
    });
  }


  Future convertFileActionApi(file) async {
    String uri = "https://quiet-hamlet-78778.herokuapp.com/convert-file";

    Dio dio = new Dio();
    FormData formdata = new FormData(); // just like JS
    formdata.add("file",
        new UploadFileInfo(File.fromUri(Uri.parse(file)), basename(file)));
    return await dio.post(uri, data: formdata, options: Options(
        method: 'POST',
        responseType: ResponseType.json // or ResponseType.JSON
    ))
        .then((response) {
      return response;
    })
        .catchError((error) => print(error));
  }

  @override
  initState() {
//    convertFileActionApi();
    super.initState();
    audioModule.setCallBack((dynamic data) {
      _onEvent(data);
    });
    _initSettings();
  }

  Future _initSettings() async {
    final String result = await audioModule.checkMicrophonePermissions();
    if (result == 'OK') {
      await audioModule.setAudioSettings();
      setState(() {
        canRecord = true;
      });
    }
    return;
  }

  Future _startRecord() async {
    try {
      DateTime time = new DateTime.now();
      setState(() {
        file = time.millisecondsSinceEpoch.toString();
//        print("File is " + file);
      });
      final String result = await audioModule.startRecord(file);
      setState(() {
        isRecord = true;
      });
      print('startRecord: ' + result);
    } catch (e) {
      file = "";
      print('startRecord: fail');
    }
  }

  Future _stopRecord() async {
    print(1111);
    try {
      final String result = await audioModule.stopRecord();
      print('stopRecord: ' + result);
      setState(() {
        isRecord = false;
//        fetchData();
      });
    } catch (e) {
      print('stopRecord: fail');
      setState(() {
        isRecord = false;
      });
    }
  }

  Future _startStopPlay() async {
    if (isPlay) {
      await audioModule.stopPlay();
    } else {
      print('test');
      print(file);
      print('end test');

      await audioModule.startPlay({
        "file": file,
        "position": 0.0,
      });
      if (fileUrl.length > 0) {
        fetchData();
      } else {
        print("invalid length");
      }
    }
  }

  void _onEvent(dynamic event) {
    if (event['code'] == 'recording') {
      double power = event['peakPowerForChannel'];
      String url = event['url'];
      setState(() {
        recordPower = (60.0 - power.abs().floor()).abs();
        recordPosition = event['currentTime'];
        fileUrl = url;
      });
    }
    if (event['code'] == 'playing') {
      String url = event['url'];
      setState(() {
        playPosition = event['currentTime'];
        isPlay = true;
//        fileUrl = url;
      });
    }
    if (event['code'] == 'audioPlayerDidFinishPlaying') {
      setState(() {
        playPosition = 0.0;
        isPlay = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Audio example app'),
        ),
        body: new Center(
          child: canRecord
              ? new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                  child: isRecord
                      ? new Icon(Icons.mic_off)
                      : Icon(Icons.mic),
                  onPressed: () {
                    if (isRecord) {
                      _stopRecord();
                    } else {
                      _startRecord();
                    }
                  }),
              SizedBox(
                height: 10.0,
              ),
              new Text('recording: ' + recordPosition.toString()),
              new Text('power: ' + recordPower.toString()),
              FloatingActionButton(
                  child: isPlay
                      ? new Icon(Icons.play_circle_filled)
                      : Icon(Icons.pause_circle_filled),
                  onPressed: () {
                    if (!isRecord && file.length > 0) {
                      _startStopPlay();
                    }
                  }),
//              new InkWell(
//                child: new Container(
//                  margin: new EdgeInsets.only(top: 40.0),
//                  alignment: FractionalOffset.center,
//                  child: new Text(isPlay ? 'Stop' : 'Play'),
//                  height: 40.0,
//                  width: 200.0,
//                  color: Colors.blue,
//                ),
//                onTap: () {
//                  if (!isRecord && file.length > 0) {
//                    _startStopPlay();
//                  }
//                },
//              ),
              new Text('playing: ' + playPosition.toString()),
            ],
          )
              : new Text(
            'Microphone Access Disabled.\nYou can enable access in Settings',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}


