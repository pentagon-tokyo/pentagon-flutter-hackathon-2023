import 'package:flutter/material.dart';

import '../design/colors.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(message),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: colorGray7A,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
    ),
  );
}
