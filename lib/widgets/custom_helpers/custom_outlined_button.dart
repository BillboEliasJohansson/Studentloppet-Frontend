// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'base_button.dart';

class CustomOutlinedButton extends BaseButton {
  const CustomOutlinedButton(
      {super.key,
      Key? keys,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      this.label,
      VoidCallback? onPressed,
      ButtonStyle? buttonStyle,
      TextStyle? buttonTextStyle,
      bool? isDisabled,
      Alignment? alignment,
      double? height,
      double? width,
      EdgeInsets? margin,
      required String text})
      : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          alignment: alignment,
          width: width,
          margin: margin,
        );

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSize = buttonTextStyle?.fontSize ?? 30;
        double buttonWidth = constraints.maxWidth;

        // Measure the text width
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: buttonTextStyle?.copyWith(fontSize: fontSize),
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout();

        // Reduce font size until text fits within the button width
        while (textPainter.width > buttonWidth - 40 && fontSize > 8) {
          fontSize -= 1;
          textPainter = TextPainter(
            text: TextSpan(
              text: text,
              style: buttonTextStyle?.copyWith(fontSize: fontSize),
            ),
            maxLines: 1,
            textDirection: TextDirection.ltr,
          )..layout();
        }

        return alignment != null
            ? Align(
                alignment: alignment ?? Alignment.center,
                child: buildOutlinedButtonWidget(fontSize))
            : buildOutlinedButtonWidget(fontSize);
      },
    );
  }

  Widget buildOutlinedButtonWidget(double fontSize) => Container(
        height: height ?? 32.v,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: OutlinedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leftIcon != null) leftIcon!,
              Flexible(
                child: Text(
                  text,
                  style: buttonTextStyle?.copyWith(fontSize: fontSize),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (rightIcon != null) rightIcon!,
            ],
          ),
        ),
      );
}
