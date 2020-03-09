import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/recharge/card_recharge_sure.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';

class CardRecharge extends StatefulWidget {
  final int id;

  const CardRecharge(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _CardRechargeState createState() => _CardRechargeState();
}

class _CardRechargeState extends State<CardRecharge> {
  List list;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('RechargeCard', data: {'id': widget.id});
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          list = rs['data'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(list);
    return Scaffold(
      appBar: MyAppBar(
        title: Text('卡项列表'),
      ),
      body: list != null
          ? ListView.separated(
              itemBuilder: (_, i) => _item(i),
              itemCount: list.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 0,
                );
              },
            )
          : Center(
              child: loading(),
            ),
    );
  }

  Widget _item(int i) {
    return Container(
      child: ListTile(
        title: Text(
          '${list[i]['name']}',
        ),
        subtitle: Row(
          children: <Widget>[
            Text('金额：${list[i]['amount']}'),
            Padding(padding: EdgeInsets.all(10)),
            Text(
                '卡类：${list[i]['card_type'] == 1 ? '储值卡' : list[i]['card_type'] == 2 ? '折扣卡' : '全场折扣卡'}'),
          ],
        ),
        trailing: MyButton(
          title: '充值',
          width: 80,
          height: 30,
          onPressed: ()async{
            await jump2(context, CardRechargeSure(list[i]['id']));
            getSj();
          },
        ),
      ),
      color: bg2,
    );
  }
}
