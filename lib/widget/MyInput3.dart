import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyInput3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Column(
        children: <Widget>[
          TextField(
            controller: controller,
            enabled: enabled,
            onChanged: onChanged,
            onTap: onPressed,
            keyboardType: keyboardType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                suffixIcon: suffixIcon,
                fillColor: fillColor ?? Colors.white,
                filled: true,
                hintText: hintText,
                hintStyle: hintStyle,
                border: showBottomLine
                    ? UnderlineInputBorder(borderSide: BorderSide(color: hintColor))
                    : InputBorder.none,
                enabledBorder: showBottomLine
                    ? UnderlineInputBorder(borderSide: BorderSide(color: hintColor))
                    : InputBorder.none,
                focusedBorder: showBottomLine
                    ? UnderlineInputBorder(borderSide: BorderSide(color: hintColor))
                    : InputBorder.none),
          ),
        ],
      ),
    );
  }

  MyInput3(
      {this.hintText,
      this.controller,
      this.label,
      this.enabled,
      this.hintStyle,
      this.onPressed,
      this.suffixIcon,
      this.fillColor,
      this.showBottomLine = false, this.keyboardType, this.onChanged});

  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool enabled;
  final TextStyle hintStyle;
  final VoidCallback onPressed;
  final Widget suffixIcon;
  final Color fillColor;
  final bool showBottomLine;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
}
