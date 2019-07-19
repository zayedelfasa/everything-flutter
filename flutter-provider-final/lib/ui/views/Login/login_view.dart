import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/constants/app_constants.dart';
import 'package:provider_example/ui/base/base_widget.dart';
import 'package:provider_example/ui/shared/app_colors.dart';
import 'package:provider_example/ui/shared/text_style.dart';
import 'package:provider_example/ui/shared/ui_helpers.dart';
import 'package:provider_example/ui/views/login/login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(authenticationService: Provider.of(context)),
      child: LoginHeader(controller: _controller),
      builder: (context, model, child) => Scaffold(
            backgroundColor: backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                child,
                model.busy
                    ? CircularProgressIndicator()
                    : FlatButton(
                        color: Colors.white,
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          var loginSuccess = await model.login(_controller.text);
                          if (loginSuccess) {
                            Navigator.pushNamed(context, RoutePaths.Home);
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

  LoginHeader({@required this.controller, this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Login', style: headerStyle),
      UIHelper.verticalSpaceMedium,
      Text('Enter a number between 1 - 10', style: subHeaderStyle),
      LoginTextField(controller),
      this.validationMessage != null ? Text(validationMessage, style: TextStyle(color: Colors.red)) : Container()
    ]);
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
      child: TextField(decoration: InputDecoration.collapsed(hintText: 'User Id'), controller: controller),
    );
  }
}
