import 'package:flutter/material.dart';
import 'package:flutshare/pages/register/register_bloc.dart';
import 'package:flutshare/styles/default_colors.dart';
import 'package:flutshare/styles/default_styles.dart';
import 'package:flutshare/utils/link_route.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String id;
  final _formKey = GlobalKey<FormState>();
  RegisterBloc registerBloc;
  String phoneNumber;

  @override
  void initState() {
    super.initState();
    registerBloc = RegisterBloc();
  }

  @override
  void dispose() {
    super.dispose();
    registerBloc.dispose();
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
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Center(
                        child: Text("Register For Open", style: DefaultStyle.textStyleLabelFormBold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 90.0),
                      child: Center(
                        child: Text("The News World", style: DefaultStyle.textStyleLabelFormBold),
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
                        onPressed: this.newRegisterUser,
                        color: DefaultColors.primaryColor,
                        shape: DefaultStyle().roundedRectangleBorderDefault(),
                        child:
                        Text("Register", style: DefaultStyle.textStyleButtonDefault),
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

  void newRegisterUser() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String tempID = await registerBloc.newUserRegister(phoneNumber);
      setState(() {
        id = tempID;
      });
      Navigator.of(context).pushReplacementNamed(LinkRoute.SmsConfirmPage);
    }
  }

  void _onBackPressed() {
    Navigator.of(context).pop(true);
  }
}
