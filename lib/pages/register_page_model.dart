import 'package:flutter/material.dart';

class RegisterPageModel {
  final TextEditingController emailAddressTextController;
  final TextEditingController passwordTextController;
  final TextEditingController passwordConfirmTextController;
  
  final FocusNode emailAddressFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode passwordConfirmFocusNode;
  
  bool passwordVisibility;
  bool passwordConfirmVisibility;

  RegisterPageModel()
      : emailAddressTextController = TextEditingController(),
        passwordTextController = TextEditingController(),
        passwordConfirmTextController = TextEditingController(),
        emailAddressFocusNode = FocusNode(),
        passwordFocusNode = FocusNode(),
        passwordConfirmFocusNode = FocusNode(),
        passwordVisibility = false,
        passwordConfirmVisibility = false;

  void dispose() {
    emailAddressTextController.dispose();
    passwordTextController.dispose();
    passwordConfirmTextController.dispose();
    emailAddressFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmFocusNode.dispose();
  }
}
