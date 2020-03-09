import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyButton2 extends StatelessWidget {
  final VoidCallback onPress;
  final Color color;
  final double radius;
  final IconData icon;

  const MyButton2(
      {Key key,
      @required this.onPress,
      this.color,
      this.radius = defRadius,
      @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      alignment: Alignment.center,
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        child: Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
        onPressed: onPress,
        color: color ?? c1,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
