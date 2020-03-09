import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class Out extends StatefulWidget {
  final int id;
  final int wid;
  final int goodsType;
  final String type;

  const Out(
    this.id,
    this.wid,
    this.goodsType,
    this.type, {
    Key key,
  }) : super(key: key);

  @override
  _InState createState() => _InState();
}

class _InState extends State<Out> {
  Map detail;
  String num = '';
  String one = '';
  String name = '';

  String px() {
    String str = '';
    if (detail != null) {
      if (detail['type'] == 1) {
        str = '产品';
      } else if (detail['type'] == 2) {
        str = '套盒';
      } else if (detail['type'] == 3) {
        str = '耗材';
      } else if (detail['type'] == 4) {
        str = '内衣';
      }
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('出库操作'),
      ),
      body: detail != null
          ? ListView(
              children: <Widget>[
                MyInput2(
                  label: '品$kg项',
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: '${px()}',
                  enabled: false,
                ),
                MyInput2(
                  label: '商品名称',
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: '${detail['name']}',
                  enabled: false,
                ),
                MyInput2(
                  label: '现有库存',
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: '${detail['stock']}',
                  enabled: false,
                ),
                MyInput2(
                  onChanged: (v) {
                    setState(() {
                      num = v;
                    });
                  },
                  label: '出库数量',
                  hintText: '请输入出库数量',
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                MyInput2(
                  onChanged: (v) {
                    name = v;
                  },
                  label: '出库人',
                  hintText: '请输入出库操作人',
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: MyButton(
                    title: '确认出库',
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

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await post('StockOperation', data: {
      'goods_type': widget.goodsType,
      'id': widget.id,
      'type': 'detail',
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          detail = rs['res'];
        });
      }
    }
  }

  String cb() {
    if (num.length > 0 && one.length > 0) {
      return (double.parse(num) * double.parse(one)).toStringAsFixed(2);
    }
    return 0.00.toString();
  }

  void sub() async {
    if (num.length == 0 || name.length == 0) {
      return tip(context, '请填完以上内容');
    }
    var rs = await post('StockOperation', data: {
      'id': widget.id,
      'type': widget.type,
      'ware': widget.wid,
      'data': {
        'sum': num,
        'human': name,
        'goods_type': widget.goodsType,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }
}
