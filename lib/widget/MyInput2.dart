import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyInput2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Column(
        children: <Widget>[
          TextField(
            enabled: enabled,
            onChanged: onChanged,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                contentPadding: contentPadding ?? EdgeInsets.all(15),
                errorText: errorText,
                suffixIcon: suffixIcon,
                prefixIcon: type == 1
                    ? Container(
                        child: Text(
                          label,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        alignment: alignment,
                        width: 100,
                      )
                    : null,
                fillColor: Colors.white,
                filled: true,
                hintText: hintText,
                hintStyle: hintStyle,
                suffixText: suffixText,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.transparent))),
          ),
          showBottomLine
              ? Divider(
                  height: 0,
                )
              : Offstage(),
        ],
      ),
    );
  }

  MyInput2({
    this.hintText,
    this.controller,
    @required this.label,
    this.enabled,
    this.hintStyle,
    this.onPressed,
    this.suffixIcon,
    this.suffixText,
    this.type = 1,
    this.width,
    this.height = 60,
    this.showBottomLine = true,
    this.alignment = Alignment.center,
    this.contentPadding,
    this.onChanged,
    this.errorText, this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool enabled;
  final TextStyle hintStyle;
  final VoidCallback onPressed;
  final Widget suffixIcon;
  final String suffixText;
  final double width;
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final int type;
  final bool showBottomLine;
  final AlignmentGeometry alignment;
  final ValueChanged<String> onChanged;
  final String errorText;
  final TextInputType keyboardType;


}
