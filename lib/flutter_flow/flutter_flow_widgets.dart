import 'package:flutter/material.dart';

class FFButtonOptions {
  final double? width;
  final double? height;
  final EdgeInsetsDirectional? padding;
  final EdgeInsetsDirectional? iconPadding;
  final Color? color;
  final TextStyle? textStyle;
  final double? elevation;
  final BorderRadius? borderRadius;

  FFButtonOptions({
    this.width,
    this.height,
    this.padding,
    this.iconPadding,
    this.color,
    this.textStyle,
    this.elevation,
    this.borderRadius,
  });
}

class FFButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Widget? icon;
  final FFButtonOptions? options;

  const FFButtonWidget({
    super.key,
    this.onPressed,
    this.text,
    this.icon,
    this.options,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: options?.color,
        minimumSize: Size(options?.width ?? 0, options?.height ?? 0),
        elevation: options?.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: options?.borderRadius ?? BorderRadius.circular(8),
        ),
        padding: options?.padding?.resolve(TextDirection.ltr),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Padding(
            padding: options?.iconPadding?.resolve(TextDirection.ltr) ?? EdgeInsets.zero,
            child: icon,
          ),
          if (text != null) Text(
            text!,
            style: options?.textStyle,
          ),
        ],
      ),
    );
  }
}
