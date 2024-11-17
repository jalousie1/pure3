import 'package:flutter/material.dart';

class LoginModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController? emailAddressTextController;
  TextEditingController? passwordTextController;
  FocusNode? emailAddressFocusNode;
  FocusNode? passwordFocusNode;
  bool passwordVisibility = false;

  void initState(BuildContext context) {
    emailAddressTextController ??= TextEditingController();
    passwordTextController ??= TextEditingController();
    emailAddressFocusNode ??= FocusNode();
    passwordFocusNode ??= FocusNode();
  }

  void dispose() {
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();
    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}
