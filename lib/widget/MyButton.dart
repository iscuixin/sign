import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? MediaQuery.of(context).size.width / 2,
        margin: margin,
        height: height ?? 38.0,
        child: CupertinoButton(
          disabledColor: disColor,
          padding: EdgeInsets.all(0),
          pressedOpacity: 0.5,
          borderRadius: BorderRadius.circular(30.0),
          child: load
              ? loading(radius: 10)
              : Text(
                  title,
                  style: titleStyle,
                ),
          onPressed: onPressed,
          color: color ?? c1,
        ));
  }

  MyButton(
      {this.onPressed,
      @required this.title,
      this.width,
      this.height,
      this.color,
      this.margin,
      this.titleStyle,
      this.load = false});

  final double width;
  final double height;
  final String title;
  final Color color;
  final EdgeInsetsGeometry margin;
  final VoidCallback onPressed;
  final TextStyle titleStyle;
  final bool load;
}
