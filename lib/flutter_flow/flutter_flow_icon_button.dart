import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
  const FlutterFlowIconButton({
    super.key,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.buttonSize,
    this.fillColor,
    this.icon,
    this.onPressed,
  });

  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final double? buttonSize;
  final Color? fillColor;
  final Widget? icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => Material(
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        color: fillColor,
        child: IconButton(
          icon: icon ?? const Icon(Icons.add),
          onPressed: onPressed,
          splashRadius: buttonSize ?? 20,
        ),
      );
}
