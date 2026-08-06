import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtilis {
  static showToastMessage({
    required  var message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Fluttertoast.showToast(
      msg: message ,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor:textColor,
      fontSize:18,


    );
  }
}
