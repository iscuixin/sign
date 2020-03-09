import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/recharge/card_recharge.dart';
import 'package:myh_shop/app/main/recharge/recharge.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class RechargeManage extends StatelessWidget {
  final int id;

  const RechargeManage(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('充值管理'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              color: c1,
            ),
            title: Text('账户充值'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(context, Recharge(id));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            onTap: () {
              jump2(context, CardRecharge(id));
            },
            leading: Icon(
              Icons.credit_card,
              color: c1,
            ),
            title: Text('卡项充值'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
