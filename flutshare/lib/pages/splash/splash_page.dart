import 'dart:async';
import 'package:flutshare/utils/link_route.dart';
import 'package:flutshare/utils/slide_effect.dart';
import 'package:flutter/material.dart';
// import 'package:neta/pages/first_screen/first_page.dart';
// import 'package:neta/pages/login/login_page.dart';
// import 'package:neta/pages/tab/tab_page.dart';
// import 'package:neta/utils/link_route.dart';
// import 'package:neta/utils/local_storage.dart';
// import 'package:neta/utils/slide_effect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/bg.png"), fit: BoxFit.cover))));
  }

  void navigationPage() async {
    //Route route = new FadeSlideDuration(widget: new FirstPage());
    prefs = await SharedPreferences.getInstance();
    // String prefUserPhoneNumber = prefs.getString(SaveLocalStorage.keyNumberPhone) ?? "";

    // if(prefUserPhoneNumber.toString().isEmpty) {
      // Navigator.of(context).pushReplacementNamed(LinkRoute.FirstPage);
      Navigator.of(context).pushReplacementNamed(LinkRoute.TabPage);
    // }
    // else {
      // Navigator.of(context).pushReplacementNamed(LinkRoute.FirstPage);
      // Navigator.of(context).pushReplacementNamed(LinkRoute.TabPage);
      // Navigator.of(context).pushReplacement(FadeSlideDuration(widget: TabPage()));
    // }
    // Navigator.push(context, route);
  }

  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);
  }
}
