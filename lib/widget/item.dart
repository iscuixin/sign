import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton2.dart';

class Item extends StatefulWidget {
  final Map data;
  final ValueChanged<Map> onChanged;
  final int type;

  const Item(this.data, this.type, {Key key, this.onChanged}) : super(key: key);

  @override
  _ItemState createState() => _ItemState(data);
}

class _ItemState extends State<Item> {
  Map d;

  _ItemState(this.d);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: <Widget>[
                        Container(
                            height: 20,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: c3,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '${widget.type == 2 ? d['category_name'] : widget.type == 1 ? d['category'] : widget.type == 3 ? d['category_id'] : widget.type == 4 ? d['color'] : '无'}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            )),
                        Container(
                          width: 120,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            '${getName(widget.type, d)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${widget.type == 4 ? '${d['sn']}' : (d['free'] == 1 ? '可赠送' : '不可赠送')}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
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
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    priceWidget('${d['price']}'),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        '库存：${d['stock']}',
                        style: TextStyle(
                            fontSize: 14,
                            color: widget.type != 3
                                ? textColor
                                : Colors.transparent),
                      ),
                    ),
                    Text('已预售：${d['beforehand_num']}',
                        style: TextStyle(
                            fontSize: 14,
                            color: widget.type != 3
                                ? textColor
                                : Colors.transparent)),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
