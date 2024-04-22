// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';
import '../theme/custom_button_style.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton(
      {super.key,
      this.alignment,
      this.backgroundColor,
      this.onTap,
      this.width,
      this.height,
      this.decoration,
      this.child});

  final Alignment? alignment;

  final Color? backgroundColor;

  final VoidCallback? onTap;

  final double? width;

  final double? height;

  final BoxDecoration? decoration;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment ?? Alignment.center, child: fabWidget)
        : fabWidget;
  }

  Widget get fabWidget => FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width ?? 0,
          height: height ?? 0,
          decoration: decoration ??
              BoxDecoration(
                color: theme.colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.circular(24.h),
              ),
          child: child,
        ),
      );
}
