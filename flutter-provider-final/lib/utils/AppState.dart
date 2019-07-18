//import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppState with ChangeNotifier {
  AppState();

  String displayText = "";
  String _dataUrl = "https://reqres.in/api/users?per_page=20";
  String _jsonResonse = "";
  bool _isFetching = false;

  void setDisplayText(String text) {
    displayText = text;
    notifyListeners();
  }

  bool get isFetching => _isFetching;

  Future<void> fetchData() async {
    _isFetching = true;
    notifyListeners();
    var response = await http.get(_dataUrl);
    if(response.statusCode == 200) {
      _jsonResonse = response.body;
    }
    _isFetching = false;
    notifyListeners();
  }

  String get getResponseText => _jsonResonse;

  List<dynamic> getResponseJson() {
    if(_jsonResonse.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(_jsonResonse);
      // print(json['data']['avatar']);
      return json['data'];
    }
    return null;
  }

  String getDisplayText() => this.displayText;
}