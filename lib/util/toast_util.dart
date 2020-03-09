import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil{
  static void toast(String text){
    showToast(
      text,
      backgroundColor: Colors.black54,
      textStyle: TextStyle(color: Colors.white,fontSize: 14),
      position: ToastPosition.bottom,
      duration: Duration(
        seconds: 2,
      )
    );
  }
}