import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/goods/add_card.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class CardManage extends StatefulWidget {
  @override
  _CardManageState createState() => _CardManageState();
}

class _CardManageState extends State<CardManage> {
  List list;
  String input = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_card');
    if (rs != null) {
      setState(() {
        list = rs['card']['list'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('卡项管理'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('创建'),
              onPressed: () async {
                var rs = await jump2(context, AddCard());
                getSj();
              })
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
              child: MyInput(
                onChanged: (v){
                  setState(() {
                    input = v;
                  });
                },
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
                hintText: '请输入卡项名称查找',
              ),
            ),
            preferredSize: Size(getRange(context), 60)),
      ),
      body: Container(
        color: bg2,
        margin: EdgeInsets.only(top: 10),
        child: list != null
            ? Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 50,
                    child: Text(
                      '卡项总数(${list.length})',
                      style: TextStyle(fontSize: 16),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    ),
                  )
                ],
              )
            : Center(
                child: loading(),
              ),
      ),
    );
  }

  String getType(int t) {
    String str = '';
    if(t==1){
      str = '储值卡';
    }
    if(t==2){
      str = '折扣储值卡';
    }
    if(t==3){
      str = '全场折扣卡';
    }
    return str;
  }

  Widget _item(int i) {
    if(input.length>0 && list[i]['card_name'].toString().toLowerCase().indexOf(input.toLowerCase()) < 0){
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
                    '${list[i]['card_name']}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  MyButton(
                    width: getRange(context) / 5,
                    titleStyle: TextStyle(fontSize: 14),
                    height: 30,
                    title: '编辑',
                    onPressed: () async {
                      var rs = await jump2(context, AddCard(data: list[i],));
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
                            text: '余额：',
                            children: [
                              TextSpan(
                                  text: '¥${list[i]['amount']}', style: TextStyle(color: c1))
                            ],
                            style: TextStyle(color: textColor))),
                  ),
                  Text('卡类：${getType(list[i]['card_type'])}')
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
