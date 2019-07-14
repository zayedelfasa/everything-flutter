import 'package:flutter/material.dart';
import 'package:flutshare/pages/login/login_bloc.dart';
// import 'package:neta/pages/sms_confirm/sms_confirm_page.dart';
import 'package:flutshare/styles/default_colors.dart';
import 'package:flutshare/styles/default_styles.dart';
// import 'package:neta/utils/link_route.dart';
// import 'package:neta/utils/local_storage.dart';
import 'package:flutshare/utils/slide_effect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String phoneNumber;
  final _formKey = GlobalKey<FormState>();
  // LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    // loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    // loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
      body: Container(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 100.0),
                  child: Center(
                    child: Text("We hope good news everyday", style: DefaultStyle.textStyleLabelFormBold),
                  ),
                ),
                Text("Phone Number", style: DefaultStyle.textStyleLabelForm),
                Form(
                  key: _formKey,
                  child: buildTextFromField(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    onPressed: this.login,
                    color: DefaultColors.primaryColor,
                    shape: DefaultStyle().roundedRectangleBorderDefault(),
                    child:
                    Text("Login", style: DefaultStyle.textStyleButtonDefault),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: InkWell(
                      child: Icon(Icons.arrow_back_ios, size: 40.0),
                      onTap: this._onBackPressed,
                    ),
                  ),
                )
              ],
            ),
          )),
    ), onWillPop: null);
  }

  void login() async {
//     if(_formKey.currentState.validate()) {
//       _formKey.currentState.save();
//       int tempID = await loginBloc.newUserLogin(phoneNumber);
// //      setState(() {
// //        id = tempID;
// //      });
//       if(tempID > 0) {
//         Navigator.push(context,SlideEffectDuration(widget: new SmsPage(phoneNumber)));
// //        Navigator.of(context).pushReplacementNamed(LinkRoute.SmsConfirmPage);
//       }
//     }
  }

  TextFormField buildTextFromField() {
    return TextFormField(
      decoration: DefaultStyle().defaultInputDecorationForm("Input Phone Number Here"),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if(value.isEmpty) {
          return "Please Input Phone Number";
        }
      },
      onSaved: (value) => phoneNumber = value,
    );
  }

  void _onBackPressed() {
    Navigator.of(context).pop(true);
//    return showDialog(
//      context: context,
//      builder: (context) => new AlertDialog(
//        title: new Text('Are you sure?'),
//        content: new Text('Do you want to exit an App'),
//        actions: <Widget>[
//          new GestureDetector(
//            onTap: () => Navigator.of(context).pop(false),
//            child: roundedButton("No", const Color(0xFF167F67),
//                const Color(0xFFFFFFFF)),
//          ),
//          new GestureDetector(
//            onTap: () => Navigator.of(context).pop(true),
//            child: roundedButton(" Yes ", const Color(0xFF167F67),
//                const Color(0xFFFFFFFF)),
//          ),
//        ],
//      ),
//    ) ??
//        false;
  }
}

