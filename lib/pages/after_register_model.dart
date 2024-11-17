import 'package:flutter/material.dart';

class AfterRegisterModel {
  final TextEditingController textController1;
  final TextEditingController textController2;
  final FocusNode textFieldFocusNode1;
  final FocusNode textFieldFocusNode2;

  AfterRegisterModel()
      : textController1 = TextEditingController(),
        textController2 = TextEditingController(),
        textFieldFocusNode1 = FocusNode(),
        textFieldFocusNode2 = FocusNode();

  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();
  }
}
