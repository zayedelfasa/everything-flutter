import 'package:flutter/material.dart';
import 'package:flutshare/pages/chat_page/ChatBloc.dart';
import 'package:flutshare/styles/default_styles.dart';

class Consts {
  Consts._();
  static const double padding = 3.0;
  static const double avatarRadius = 66.0;
}

class ChatDialogInterestOverTime extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  final ChatBloc chatBloc;

  final _formKey = GlobalKey<FormState>();
  String keyword;

  ChatDialogInterestOverTime({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    @required this.chatBloc,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding * 5.0,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                height: 200.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Interest Overtime", style: DefaultStyle.textStyleLabelForm),
                    Form(
                      key: _formKey,
                      child: buildTextFromField(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextFormField buildTextFromField() {
    return TextFormField(
      decoration: DefaultStyle().defaultInputDecorationForm("Input Interest Overtime"),
      validator: (value) {
        if(value.isEmpty) {
          return "Input Interest Overtime";
        }
      },
      onSaved: (value) => keyword = value,
    );
  }

  void checkConfirm() {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // if(bloc.checkConfirmNumber(confirmNumber)) {
      //   new SaveLocalStorage().saveLocalUserNumberPhone(widget.phoneNumber);
      //   Navigator.of(context).pushReplacementNamed(LinkRoute.TabPage);
      // }
    }
  }
}