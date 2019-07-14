import 'package:flutter/material.dart';
import 'package:flutshare/pages/login/login_page.dart';
import 'package:flutshare/styles/default_colors.dart';
import 'package:flutshare/styles/default_styles.dart';
import 'package:flutshare/utils/link_route.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/bg.png"), fit: BoxFit.cover)),
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Material(),
          Positioned(
              top: 50, left: 20, right: 0,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Text(
                    "News and Trends Assistance",
                    style: DefaultStyle.textStyleTitle,
                  ),
                ),
              )),
          Positioned(
            bottom: -290, left: -130, right: -130,
            child: Align(
              alignment: Alignment.center,
              child: CircleImage(context: context,),
            ),
          )
        ],
      ),
    );
  }
}

class CircleImage extends StatelessWidget {

  final BuildContext context;
  CircleImage({this.context});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipOval(
      child: Container(
          color: Colors.white,
          height: 500.0,
          child: Padding(
            padding: EdgeInsets.only(top: 58.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 300.0,
                    child: RaisedButton(
                      onPressed: this.moveToLoginPage,
                      color: DefaultColors.primaryColor,
                      shape: DefaultStyle().roundedRectangleBorderDefault(),
                      child: Text("Login",
                          style: DefaultStyle.textStyleButtonDefault),
                    ),
                  ),
                  Container(
                    width: 300.0,
                    child: RaisedButton(
                      onPressed: this.moveToRegister,
                      color: DefaultColors.primaryColor,
                      shape: DefaultStyle().roundedRectangleBorderDefault(),
                      child: Text("Register",
                          style: DefaultStyle.textStyleButtonDefault),
                    ),
                  )
                ],
              ),
            ),
          )),
    ));
  }

  void moveToLoginPage() {
          // Route route = MaterialPageRoute(builder:  (context)=> new LoginPage());
      // Navigator.push(context, route);
    Navigator.of(context).pushNamed(LinkRoute.LoginPage);
  }

  void moveToRegister() {
    Navigator.of(context).pushNamed(LinkRoute.RegisterPage);
  }
}
