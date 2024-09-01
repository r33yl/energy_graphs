import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(BuildContext context, String message, {bool cancelOldToast = true}) {
  Color textColor = Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white;
  Color backgroundColor = Theme.of(context).brightness == Brightness.dark
      ? Colors.grey.shade100.withOpacity(0.9)
      : Colors.grey.shade900.withOpacity(0.9);

  cancelOldToast ? Fluttertoast.cancel() : null;
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}
