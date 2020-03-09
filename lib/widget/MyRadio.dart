import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyRadio extends StatefulWidget {
  MyRadio(
      {this.value,
      this.onChanged,
      @required this.text,
      @required this.text2, this.enable=true});

  final int value;
  final String text;
  final String text2;
  final ValueChanged<int> onChanged;
  final bool enable;

  @override
  _MyRadioState createState() => _MyRadioState();
}

class _MyRadioState extends State<MyRadio> {
  int v;

  @override
  void initState() {
    super.initState();
    v = widget.value??1;
  }

  @override
  void didUpdateWidget(MyRadio oldWidget) {
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
              if(widget.enable){
                setState(() {
                  v = 1;
                });
                widget.onChanged(v);
              }
            },
            child: Row(
              children: <Widget>[
                Image.asset(
                  v == 1 ? 'img/radio_yes.png' : 'img/radio_no.png',
                  height: 20,
                  color: v == 1 ? c1:textColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.text,
                      style: TextStyle(color: v == 1 ? c1:textColor, fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              if(widget.enable){
                setState(() {
                  v = 2;
                });
                widget.onChanged(v);
              }
            },
            child: Row(
              children: <Widget>[
                Image.asset(
                  v == 1 ? 'img/radio_no.png' : 'img/radio_yes.png',
                  height: 20,
                  color: v == 2 ? c1:textColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.text2,
                    style: TextStyle(color: v == 2 ? c1:textColor, fontSize: 16),
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
