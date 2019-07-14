import 'dart:async';
import 'package:login_with_sqflite/models/user.dart';
import 'package:login_with_sqflite/utils/network_util.dart';

class RestData {
  NetworkUtil _networkUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<User> login(String _username, String _password) {
    return new Future.value(new User(_username, _password));
  }
}