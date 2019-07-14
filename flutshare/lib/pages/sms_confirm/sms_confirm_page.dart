import 'package:flutter/material.dart';
import 'package:flutshare/pages/sms_confirm/sms_confirm_bloc.dart';
import 'package:flutshare/pages/tab/tab_page.dart';
import 'package:flutshare/styles/default_colors.dart';
import 'package:flutshare/styles/default_styles.dart';
import 'package:flutshare/utils/link_route.dart';
import 'package:flutshare/utils/local_storage.dart';

class SmsPage extends StatefulWidget {
  final String phoneNumber;
  SmsPage(this.phoneNumber);

  @override
  _SmsPageState createState() => _SmsPageState();
}

class _SmsPageState extends State<SmsPage> {

  int confirmNumber;
  final _formKey = GlobalKey<FormState>();
  SmsConfirmBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SmsConfirmBloc();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
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
                    child: Text("Wanna know trends?", style: DefaultStyle.textStyleLabelFormBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 90.0),
                  child: Center(
                    child: Text("Ask NetaBot", style: DefaultStyle.textStyleLabelFormBold),
                  ),
                ),
                Text("Confirm Number", style: DefaultStyle.textStyleLabelForm),
                Form(
                  key: _formKey,
                  child: buildTextFromField(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    onPressed: this.checkConfirm,
                    color: DefaultColors.primaryColor,
                    shape: DefaultStyle().roundedRectangleBorderDefault(),
                    child:
                    Text("Submit", style: DefaultStyle.textStyleButtonDefault),
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
      decoration: DefaultStyle().defaultInputDecorationForm("Input Confirm Number Here"),
      keyboardType: TextInputType.number,
      validator: (value) {
        if(value.isEmpty) {
          return "Please Input Confirm Number";
        }
      },
      onSaved: (value) => confirmNumber = int.parse(value),
    );
  }

  void checkConfirm() {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if(bloc.checkConfirmNumber(confirmNumber)) {
        new SaveLocalStorage().saveLocalUserNumberPhone(widget.phoneNumber);
        Navigator.of(context).pushReplacementNamed(LinkRoute.TabPage);
      }
    }
  }

  void _onBackPressed() {
    Navigator.of(context).pop(true);
  }
}
