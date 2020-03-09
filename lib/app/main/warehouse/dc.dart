import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';

class Dc extends StatefulWidget {
  final int id;
  final int wid;
  final int type;

  const Dc(
    this.id,
    this.wid,
    this.type, {
    Key key,
  }) : super(key: key);

  @override
  _DcState createState() => _DcState();
}

class _DcState extends State<Dc> {
  Map detail;
  List store = [];
  List goods = [];
  String name = '';
  String num = '';
  String remark = '';
  Map now;
  Map nowGoods;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('商品调仓'),
      ),
      body: detail != null
          ? ListView(
              children: <Widget>[
                MyInput2(
                  label: '所选商品',
                  hintText: '${detail['name']}',
                  hintStyle: TextStyle(color: Colors.black),
                  enabled: false,
                ),
                MyInput2(
                  label: '商品编号',
                  hintText: '${detail['sn']}',
                  hintStyle: TextStyle(color: Colors.black),
                  enabled: false,
                ),
                MyInput2(
                  label: '当前库存',
                  hintText: '${detail['stock']}',
                  hintStyle: TextStyle(color: Colors.black),
                  enabled: false,
                ),
                MyItem(
                  child: GestureDetector(
                    onTap: () {
                      if (store.length > 0) {
                        showMyPicker(context);
                      }
                    },
                    child: Text(
                      now == null ? '请选择仓库' : now['name'],
                      style: TextStyle(
                          fontSize: 16,
                          color: now == null ? hintColor : Colors.black),
                    ),
                  ),
                  label: '可选仓库',
                ),
                MyItem(
                  child: GestureDetector(
                    onTap: () {
                      if (goods.length > 0) {
                        showMyPicker2(context);
                        nowGoods = goods[0];
                        setState(() {});
                      }
                    },
                    child: Text(
                      nowGoods == null
                          ? (goods.length == 0 ? '未找到指定编号的商品' : '请选择')
                          : nowGoods['name'],
                      style: TextStyle(
                          fontSize: 16,
                          color: nowGoods == null ? hintColor : Colors.black),
                    ),
                  ),
                  label: '调拨至',
                ),
                MyInput2(
                  label: '调拨数量',
                  hintText: '请输入要调拨的数量',
                  onChanged: (v) {
                    setState(() {
                      num = v;
                    });
                  },
                ),
                MyInput2(
                  label: '操作人',
                  hintText: '请填写调仓操作人',
                  onChanged: (v) {
                    setState(() {
                      name = v;
                    });
                  },
                ),
                MyInput2(
                  label: '调仓备注',
                  hintText: '请输入备注',
                  onChanged: (v) {
                    setState(() {
                      remark = v;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: MyButton(
                    title: '确认调仓',
                    onPressed: () {
                      sub();
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: loading(),
            ),
    );
  }

  void getSj() async {
    var rs = await get('transfer_operation', data: {
      'transfer': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          detail = rs['res']['alone'];
          store = rs['res']['other_store'];
        });
      }
    }
  }

  void getSj2() async {
    var rs = await get('transfer_operation', data: {
      'cate': widget.type,
      'child_transfer': now['id'],
      'sn': detail['sn'],
      'type': 'check',
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          goods = rs['res'];
        });
      }
    }
  }

  void sub() async {
    if (num.length == 0 || name.length == 0) {
      return tip(context, '请填完以上内容');
    }
    if (nowGoods == null || now == null) {
      return tip(context, '请选择仓库和商品');
    }
    var rs = await post('ware_allot', data: {
      'data': {
        'check_num': num,
        'check_goods': nowGoods == null ? '' : nowGoods['id'],
        'check_ware': now['id'],
        'check_person': name,
        'remark': remark,
        'type': widget.type,
        'transfer': widget.id,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  void showMyPicker(BuildContext context) async {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: getRange(context, type: 2) / 3,
              child: CupertinoApp(
                home: Column(
                  children: <Widget>[
                    Container(
                      color: bg2,
                      height: 60,
                      width: getRange(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CupertinoButton(
                              child: Text('取消'),
                              onPressed: () {
                                now = null;
                                back(context);
                              }),
                          CupertinoButton(
                              child: Text('确定'),
                              onPressed: () {
                                if (now == null) {
                                  now = store[0];
                                }
                                getSj2();
                                setState(() {});
                                back(context);
                              })
                        ],
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                          useMagnifier: true,
                          backgroundColor: Colors.white,
                          itemExtent: 30,
                          magnification: 1.2,
                          onSelectedItemChanged: (v) {
                            now = store[v];
                            //print(now);
                          },
                          children: store
                              .map((v) => Center(child: Text('${v['name']}')))
                              .toList()),
                    )
                  ],
                ),
              ),
            ));
  }

  void showMyPicker2(BuildContext context) async {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: getRange(context, type: 2) / 3,
              child: CupertinoApp(
                home: CupertinoPicker(
                    useMagnifier: true,
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1.2,
                    onSelectedItemChanged: (v) {
                      nowGoods = goods[v];
                      setState(() {});
                    },
                    children: goods
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }
}
