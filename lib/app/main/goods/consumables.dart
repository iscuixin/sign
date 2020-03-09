import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/goods/add_card.dart';
import 'package:myh_shop/app/main/goods/add_consumables.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class Consumables extends StatefulWidget {
  @override
  _CardManageState createState() => _CardManageState();
}

class _CardManageState extends State<Consumables> {
  List list;
  String input = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('ConsumablesList');
    if (rs != null) {
      setState(() {
        list = rs['res'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('院装消耗'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('创建'),
              onPressed: () async {
                var rs = await jump2(context, AddConsumables());
                getSj();
              })
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
              child: MyInput(
                onChanged: (v) {
                  setState(() {
                    input = v;
                  });
                },
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
                hintText: '请输入消耗名称查找',
              ),
            ),
            preferredSize: Size(getRange(context), 60)),
      ),
      body: Container(
        color: bg2,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 50,
              child: Text(
                '耗材总数(${list != null ? list.length : 0})',
                style: TextStyle(fontSize: 16),
              ),
              alignment: Alignment.centerLeft,
            ),
            Expanded(
              child: list != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    )
                  : Center(
                      child: loading(),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _item(int i) {
    if (input.length > 0 &&
        list[i]['name'].toString().indexOf(input.toLowerCase()) < 0) {
      return Offstage();
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${list[i]['name']}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  MyButton(
                    width: getRange(context) / 5,
                    titleStyle: TextStyle(fontSize: 14),
                    height: 30,
                    title: '编辑',
                    onPressed: () async {
                      var rs = await jump2(context, AddConsumables(data: list[i],));
                      getSj();
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: getRange(context) / 5),
                    child: RichText(
                        text: TextSpan(
                            text: '规格：',
                            children: [
                              TextSpan(
                                  text: list[i]['spec_name'] != null
                                      ? '${list[i]['spec']}${list[i]['spec_name']}'
                                      : '无',
                                  style: TextStyle(color: c1))
                            ],
                            style: TextStyle(color: textColor))),
                  ),
                  Text('库存：${list[i]['stock']}')
                ],
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
