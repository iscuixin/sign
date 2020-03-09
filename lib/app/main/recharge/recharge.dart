import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/recharge/recharge_logs.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';

class Recharge extends StatefulWidget {
  final int id;

  const Recharge(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _RechargeState createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  String balance = '';
  String one = '';
  String two = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('账户充值'),
        actions: <Widget>[
          CupertinoButton(child: Text('充值记录'), onPressed: () {
            jump2(context, RechargeLogs(widget.id));
          })
        ],
      ),
      body: ListView(
        children: <Widget>[
          MyItem(
            child: Text(
              '$balance',
              style: TextStyle(fontSize: 18),
            ),
            label: '当前余额',
          ),
          MyInput2(
            onChanged: (v) {
              one = v;
            },
            keyboardType: TextInputType.numberWithOptions(),
            label: '充值金额',
            hintText: '请输入充值金额',
          ),
          MyInput2(
            onChanged: (v) {
              two = v;
            },
            keyboardType: TextInputType.numberWithOptions(),
            label: '赠送金额',
            hintText: '赠送金额',
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: MyButton(
              title: '确认充值',
              onPressed: () {
                sub();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('RechargeAccount', data: {
      'id': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          balance = rs['data'];
        });
      }
    }
  }

  void sub() async {
    if (one.length == 0 && two.length == 0) {
      return tip(context, '至少输入一项');
    }
    var rs = await post('RechargeAccount', data: {
      'money': one,
      'send': two,
    }, t: widget.id);
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, '充值成功');
      }
    }
  }
}
