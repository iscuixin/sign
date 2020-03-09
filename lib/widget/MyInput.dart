import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyInput extends StatelessWidget {
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String hintText;
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
        controller: controller,
        textAlign: textAlign ?? TextAlign.start,
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            contentPadding: contentPadding ?? EdgeInsets.all(10),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: fillColor ?? bg,
            filled: true,
            hintText: hintText,
            hintStyle: hintStyle,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.transparent))),
      ),
    );
  }

  MyInput({
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.hintStyle,
    this.textAlign,
    this.onChanged,
    this.keyboardType,
    this.suffixIcon,
    this.contentPadding,
    this.fillColor,
  });

  final TextEditingController controller;
  final TextStyle hintStyle;
  final TextAlign textAlign;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final Color fillColor;
}
