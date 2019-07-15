import 'package:flutter/material.dart';
import 'package:provider_example/enums/viewstate.dart';
import 'package:provider_example/ui/shared/app_colors.dart';
import 'package:provider_example/ui/shared/text_style.dart';
import 'package:provider_example/ui/shared/ui_helpers.dart';
import 'package:provider_example/ui/views/Login/login_model.dart';
import 'package:provider_example/ui/views/base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
            backgroundColor: backgroundColor,
            body: Column(
              children: <Widget>[
                LoginHeader(
                  validationMessage: model.errorMessage,
                  controller: _textEditingController,
                ),
                model.state == ViewState.Busy
                    ? CircularProgressIndicator()
                    : FlatButton(
                        color: Colors.white,
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          var loginSuccess = await model.login(_textEditingController.text);
                          if (loginSuccess) {
                            print("LOGIN SUCCESS");
                            Navigator.pushNamed(context, "/");
                          }
                        },
                      )
              ],
            ),
          ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  final TextEditingController controller;
  final String validationMessage;

  LoginHeader({this.controller, this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Login', style: headerStyle),
        UIHelper.verticalSpaceMedium(),
        Text("Enter a number between 1 - 10", style: subHeaderStyle),
        LoginTextField(controller),
        this.validationMessage != null
            ? Text(
                validationMessage,
                style: TextStyle(color: Colors.red),
              )
            : Container()
      ],
    );
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;

  LoginTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: "User Id"),
        controller: controller,
      ),
    );
  }
}
