import 'package:flutter/material.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.validator,
    required this.entries,
    required this.onSelected, // Require an onSelected function
  }) : super(key: key);

  final Alignment? alignment;
  final double? width;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final List<DropdownMenuEntry<dynamic>> entries;
  final Function(dynamic)?
      onSelected; // Define a function that takes an argument

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: dropDownMenuWidget(context),
          )
        : dropDownMenuWidget(context);
  }

  Widget dropDownMenuWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        height: 43,
        child: DropdownMenu(
          textStyle: theme.textTheme.bodyMedium,
          hintText: hintText,
          menuHeight: 300, //Fixade hur stor dropdown baren är
          enableSearch: true,
          enableFilter: true,
          dropdownMenuEntries: entries,
          inputDecorationTheme: decoration,
          controller: controller,
          requestFocusOnTap: true,
          expandedInsets:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

          onSelected: onSelected, // Pass the function here
        ),
      );

  InputDecorationTheme get decoration => InputDecorationTheme(
        hintStyle: hintStyle ?? theme.textTheme.bodyMedium,
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.all(9.h),
        fillColor: fillColor,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.h),
              borderSide: BorderSide(
                color: theme.colorScheme.onPrimary,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.h),
              borderSide: BorderSide(
                color: theme.colorScheme.onPrimary,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.h),
              borderSide: BorderSide(
                color: theme.colorScheme.onPrimary,
                width: 1,
              ),
            ),
      );
}
