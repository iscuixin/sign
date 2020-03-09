import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyItem extends StatelessWidget {
  final String label;
  final Widget child;
  final double height;
  final bool showLine;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                //padding: EdgeInsets.only(left: 15),
                height: 50,
                child: Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                alignment: alignment,
                width: 100,
              ),
              Expanded(
                child: child,
              )
            ],
          ),
          showLine
              ? Divider(
                  height: 0,
                )
              : Offstage(),
        ],
      ),
    );
  }

  MyItem(
      {@required this.label,
      @required this.child,
      this.height = 50,
      this.showLine = true,
      this.alignment = Alignment.center});
}
