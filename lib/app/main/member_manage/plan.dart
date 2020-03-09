import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/app/main/buy/buy_items.dart';
import 'package:myh_shop/app/main/buy/buy_plan.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class Plan extends StatelessWidget {
  final int id;

  Plan(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('会员方案'),
        actions: <Widget>[
          CupertinoButton(
              child: Text(
                '购买方案',
                style: TextStyle(color: c1),
              ),
              onPressed: () {
                jump2(context, BuyPlan(2));
              })
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}
