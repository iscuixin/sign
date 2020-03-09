import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyChip extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final String label;
  final Color color;
  final double fontSize;
  final int maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      width: width,
      decoration: BoxDecoration(
          color: color ?? c3, borderRadius: BorderRadius.circular(radius)),
      child: Text(
        label,
        maxLines: maxLines??1,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white, fontSize: fontSize ?? 14),
      ),
    );
  }

  MyChip(this.label,
      {this.height = 25,
      this.width = 50,
      this.radius = 15,
      this.color,
      this.fontSize,
      this.maxLines,
      this.overflow});
}
