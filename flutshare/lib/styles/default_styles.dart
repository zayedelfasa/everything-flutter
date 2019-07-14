import 'package:flutter/material.dart';
import 'default_colors.dart';

class DefaultStyle {
  static const textStyleTitle = TextStyle(color: Colors.white, fontSize: 30.0);
  static const textStyleButtonDefault =
      TextStyle(fontSize: 16, color: Colors.white);
  static const textStyleLabelForm = TextStyle(fontSize: 15.0);
  static const textStyleLabelFormBold = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  RoundedRectangleBorder roundedRectangleBorderDefault() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));
  }

  InputDecoration defaultInputDecorationForm(String hint) {
    return InputDecoration(hintText: hint, focusedBorder: new UnderlineInputBorder(
        borderSide: new BorderSide(color: DefaultColors.primaryColor)
    ));
  }
}
