import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyRadio2 extends StatefulWidget {
  MyRadio2(
      {this.value,
      this.onChanged,
      @required this.widget2,
      @required this.widget});

  final int value;
  final ValueChanged<int> onChanged;
  final Widget widget2;
  final Widget widget;

  @override
  _MyRadioState createState() => _MyRadioState();
}

class _MyRadioState extends State<MyRadio2> {
  int v = 1;

  @override
  void didUpdateWidget(MyRadio2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      v = widget.value??v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                v = 1;
              });
              widget.onChanged(v);
            },
            child: Row(
              children: <Widget>[
                Image.asset(
                  v == 1 ? 'img/radio_yes.png' : 'img/radio_no.png',
                  height: 20,
                  color: v == 1 ? c1 : textColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: widget.widget,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                v = 2;
              });
              widget.onChanged(v);
            },
            child: Row(
              children: <Widget>[
                Image.asset(
                  v == 1 ? 'img/radio_no.png' : 'img/radio_yes.png',
                  height: 20,
                  color: v == 2 ? c1 : textColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: widget.widget2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
