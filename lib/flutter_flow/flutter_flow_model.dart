import 'package:flutter/material.dart';

abstract class FlutterFlowModel {
  void initState(BuildContext context);
  void dispose();
  
  // Utility method to notify about state changes
  void notifyListeners() {}
}

T createModel<T extends FlutterFlowModel>(
    BuildContext context, T Function() builder) {
  final model = builder();
  model.initState(context);
  return model;
}