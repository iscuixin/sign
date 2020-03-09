import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton2.dart';

class CardItem extends StatefulWidget {
  final Map data;
  final ValueChanged<Map> onChanged;

  const CardItem(
    this.data, {
    Key key, this.onChanged,
  }) : super(key: key);

  @override
  _CardState createState() => _CardState(this.data);
}

class _CardState extends State<CardItem> {
  Map d;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  '${d['card_name']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            //text: '余额：',
                            children: [
                              TextSpan(
                                  text: '¥',
                                  style: TextStyle(color: c1, fontSize: 13)),
                              TextSpan(
                                  text: '${d['price']}',
                                  style: TextStyle(color: c1, fontSize: 16)),
                            ],
                            style: TextStyle(
                              color: textColor,
                            ))),
                  ),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: '卡类：',
                            children: [
                              TextSpan(
                                  text: '${d['s']}',
                                  style: TextStyle(color: Colors.black))
                            ],
                            style: TextStyle(
                              color: textColor,
                            ))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          MyButton2(
                            icon: Icons.remove,
                            color: d['sum'] > 0 ? c1 : disColor,
                            onPress: () {
                              if (d['sum'] > 0) {
                                setState(() {
                                  d['sum']--;
                                });
                                widget.onChanged(d);
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              '${d['sum']}',
                              style: TextStyle(color: textColor, fontSize: 18),
                            ),
                          ),
                          MyButton2(
                            icon: Icons.add,
                            onPress: () {
                              setState(() {
                                d['sum']++;
                              });
                              widget.onChanged(d);
                            },
                          ),
                          //IconButton(icon: Icon(Icons.add), onPressed: (){}),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  _CardState(this.d);
}
