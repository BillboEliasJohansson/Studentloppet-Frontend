import 'package:flutter/material.dart';
import 'package:studentloppet/utils/size_utils.dart';

import '../../theme/theme_helper.dart';

enum Style { bgShadow }

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      this.height,
      this.styleType,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions});

  final double? height;

  final Style? styleType;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 48.v,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 48.v,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgShadow:
        return Container(
          height: 48.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.12),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: const Offset(
                  0,
                  0,
                ),
              )
            ],
          ),
        );
      default:
        return null;
    }
  }
}
