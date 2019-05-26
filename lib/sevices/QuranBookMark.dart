import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

SharedPreferences prefs;

class QuranBookMark {
  Future<void> saveQuranPage(int pageNumber) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('quranPage', pageNumber);
    print(pageNumber);
  }

  Future<int> returnQuranPage(int page) async {
    int pageNum = prefs.getInt('quranPage');
//    print(pageNum);
    page = pageNum;
    return page;
  }
}
