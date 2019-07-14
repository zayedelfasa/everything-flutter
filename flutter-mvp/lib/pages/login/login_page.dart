import 'package:flutter/material.dart';
import 'package:login_with_sqflite/data/database_helper.dart';
import 'package:login_with_sqflite/models/user.dart';
import 'package:login_with_sqflite/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username;
  String _password;

  LoginPagePresenter _loginPagePresenter;

  _LoginPageState() {
    _loginPagePresenter = new LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if(form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _loginPagePresenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String msgText) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(msgText),
    ));
  }
  
  @override
  Widget build(BuildContext context) {

    var loginBtn = new RaisedButton(
      child: new Text("Login"),
      onPressed: _submit,
    );

    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text("App Login", textScaleFactor: 2.0),
        new Form(
          key : formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(10.0),
                child: new TextField(
                  onChanged: (val) => _username = val,
                  decoration: new InputDecoration(
                    labelText: "Username"
                  ),
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(10.0),
                child: new TextField(
                  onChanged: (val) => _password = val,
                  decoration: new InputDecoration(
                    labelText: "Password"
                  ),
                ),
              )
            ],
          ),
        ),
        loginBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm
        ),
      ),
    );
  }

  @override
  void onLoginError(String err) {
    _showSnackBar(err);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }
}
