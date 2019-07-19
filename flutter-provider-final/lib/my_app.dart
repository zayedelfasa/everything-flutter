import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/provider_setup.dart' as prefix0;
import 'package:provider_example/ui/router.dart';

import 'constants/app_constants.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: prefix0.providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutePaths.Login,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}