import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class Product extends StatefulWidget {
  final int id;

  const Product(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List list;
  String arrears = '';
  double money = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('会员产品'),
        actions: <Widget>[
          CupertinoButton(
              child: Text(
                '购买产品',
                style: TextStyle(color: c1),
              ),
              onPressed: () {})
        ],
        bottom: PreferredSize(
            child: Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Text(
                        '累计购买金额',
                        style: TextStyle(color: textColor, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '$money',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Text(
                        '总欠款',
                        style: TextStyle(color: textColor, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '$arrears',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            preferredSize: Size(getRange(context), 70)),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                width: getRange(context) * 2,
                color: bg2,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Center(child: Text('类别'))),
                    Expanded(child: Center(child: Text('名称'))),
                    Expanded(child: Center(child: Text('价格'))),
                    Expanded(child: Center(child: Text('数量'))),
                    Expanded(child: Center(child: Text('购买日期'))),
                    Expanded(child: Center(child: Text('美容师'))),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: getRange(context) * 2,
                child: list == null
                    ? Center(
                        child: loading(),
                      )
                    : ListView.builder(
                        itemBuilder: (_, i) => _item(i),
                        itemCount: list.length,
                      ),
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget _item(int i) {
    return Container(
      color: bg2,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Chip(
                    padding: EdgeInsets.all(0),
                    label: Text(
                      '${list[i]['category']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: c1,
                  ),
                ),
                Expanded(
                    child: Text(
                  '${list[i]['goods_name']}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                Expanded(
                    child: Text('¥${list[i]['price']}',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis)),
                Expanded(
                    child: Text(
                  '${list[i]['sum']}',
                  textAlign: TextAlign.center,
                )),
                Expanded(
                  child:
                      Text('${list[i]['time']}', textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text('-', textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
          )
        ],
      ),
    );
  }

  void delData(int id) async {
    var rs = await post('MemberBoxItemsDel', data: {
      'id': id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        getSj();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await post('HaveProductList', data: {
      'mid': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res']['list'];
          for (var v in list) {
            money += double.parse(v['price'].toString()) *
                int.parse(v['sum'].toString());
          }
          arrears = rs['res']['arrears'].toString();
        });
      }
    }
  }
}
