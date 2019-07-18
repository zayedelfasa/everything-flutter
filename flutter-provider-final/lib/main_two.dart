import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/locator.dart';
import 'package:provider_example/services/authentication_service.dart';
import 'package:provider_example/ui/router.dart';

import 'models/User.dart';

class MainTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      initialData: User.initial(),
      builder: (context) => locator<AuthenticationService>().userContoller,
      child: MaterialApp(
        title: "Flutter Login",
        theme: ThemeData(),
        initialRoute: "login",
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}