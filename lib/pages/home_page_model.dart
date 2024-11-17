import '/flutter_flow/flutter_flow_model.dart';
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel {
  double? sliderValue;
  
  @override
  void initState(BuildContext context) {
    sliderValue = 7500.0;
  }

  @override
  void dispose() {}
}

HomePageModel createModel(BuildContext context, Function() param1) => HomePageModel();
