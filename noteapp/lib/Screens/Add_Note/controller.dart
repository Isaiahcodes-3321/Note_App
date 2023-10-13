import 'package:flutter/material.dart';
import 'export_note_input.dart';

var connectionCheck = ConnectionCheck();

class ConnectionCheck {

  Future<void> showBanner(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: themeColor,
          content: Text(
            "Failed to Save. Please check your internet connection.",
             style: AppTextStyle.textStyle().copyWith(fontSize: 15.sp),
          ),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }
}
