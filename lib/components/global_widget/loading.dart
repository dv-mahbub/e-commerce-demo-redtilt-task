import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

loadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: SizedBox(
          height: 120,
          width: 120,
          child: Lottie.asset('assets/json/loader.json'),
        ),
      );
    },
  );
}

popAfterShortTime(BuildContext context) {
  Future.delayed(
    const Duration(milliseconds: 150),
    () {
      if (context.mounted) {
        Navigator.of(context).pop();
      } // Close the dialog
    },
  );
}
