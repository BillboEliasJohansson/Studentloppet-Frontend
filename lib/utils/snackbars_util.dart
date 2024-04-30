import 'package:flutter/material.dart';
import 'package:studentloppet/theme/custom_text_style.dart';

showErrorSnackbar(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    backgroundColor: const Color.fromARGB(255, 187, 60, 51),
    content: Text(
      errorMessage,
      style: CustomTextStyles.titleMediumWhiteA700,
    ),
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'x',
      onPressed: () {
        // Code to execute when dismissing the Snackbar
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSuccesfulSnackbar(BuildContext context, String errorMessage) {
  final snackBar = SnackBar(
    content: Text(errorMessage),
    action: SnackBarAction(
      label: 'Dismiss',
      onPressed: () {
        // Code to execute when dismissing the Snackbar
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


