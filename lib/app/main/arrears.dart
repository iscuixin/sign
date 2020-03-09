import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/pay.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class Arrears extends StatefulWidget {
  @override
  _ArrearsState createState() => _ArrearsState();
}

class _ArrearsState extends State<Arrears> {
  List list;
  double totalMoney = 0;
  int people = 0;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get(
      'ArrearsList',
    );
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res']['list'];
          people = rs['res']['count'];
          totalMoney =
              double.parse(rs['res']['total_money'].toStringAsFixed(2));
        });
      } else {
        tip(context, rs['error']);
      }
    }
    //print(rs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('欠款跟进'),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MyInput(
                      prefixIcon: Icon(
                        Icons.search,
                        color: textColor,
                      ),
                      hintText: '输入姓名和电话',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '总欠款金额',
                              style: TextStyle(color: textColor, fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text('¥$totalMoney',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '总欠款人数',
                              style: TextStyle(color: textColor, fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text('$people',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            preferredSize: Size(getRange(context), 110)),
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
                    Expanded(child: Center(child: Text('#'))),
                    Expanded(child: Center(child: Text('品项'))),
                    Expanded(child: Center(child: Text('消费时间'))),
                    Expanded(child: Center(child: Text('会员'))),
                    Expanded(child: Center(child: Text('欠款金额'))),
                    Expanded(child: Center(child: Text('操作'))),
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
    String px = '';
    String time = list[i]['time'];
    String name = list[i]['name'];
    String money = list[i]['money'];
    if(list[i]['type']==1){
      px = '产品';
    }
    if(list[i]['type']==2){
      px = '套盒';
    }
    if(list[i]['type']==3){
      px = '项目';
    }
    if(list[i]['type']==4){
      px = '方案';
    }
    if(list[i]['type']==5){
      px = '卡项';
    }
    if(list[i]['type']==6){
      px = '内衣';
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 60,
          color: bg2,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Center(
                      child: Text(
                        '${i+1}',
                      ))),
              Expanded(
                  child: Chip(
                    label: Text(
                      px,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: c1,
                  )),
              Expanded(
                  child: Center(
                      child: Text(
                        time,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Expanded(
                  child: Center(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Expanded(
                  child: Center(
                      child: Text(money,
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(
                      onPressed: ()async {
                        await jump2(context, Pay(list[i]['id'], 0));
                        getSj();
                      },
                      title: '补款',
                    ),
                  )),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }
}
