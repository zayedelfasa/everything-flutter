import 'dart:async';

import 'package:provider_example/models/User.dart';
import 'package:provider_example/services/api.dart';

import '../locator.dart';

class AuthenticationService {
  Api api = locator<Api>();

  StreamController<User> userContoller = StreamController<User>();

  Future<bool> login(int userId) async {
    var fetchUser = await api.getUserProfile(userId);

    var hashUser = fetchUser != null;
    if(hashUser) {
      userContoller.add(fetchUser);
    }

    return hashUser;
  }
}