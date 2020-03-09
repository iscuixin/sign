import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/app/main/count/consume_info.dart';
import 'package:myh_shop/app/main/count/count_logs.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/model/count.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';
import 'package:scoped_model/scoped_model.dart';

class Count extends StatefulWidget {
  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  double h = 70;
  CountModel count;
  String begin;
  String end;

  void showMyDate(BuildContext context, int t,
      {bool showTitleActions = true,
      DateTime minTime,
      DateTime maxTime}) async {
    DatePicker.showDatePicker(context,
        showTitleActions: showTitleActions,
        maxTime: maxTime,
        minTime: minTime,
        locale: LocaleType.zh, onConfirm: (DateTime d) {
      if (t == 1) {
        begin = '${d.year}-${d.month}-${d.day}';
      } else {
        end = '${d.year}-${d.month}-${d.day}';
      }
      if (begin != null && end != null) {
        getCountData(start: begin, end: end);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CountModel>(
      child: ScopedModelDescendant<CountModel>(builder: (_, __, v) {
        if (v.payTotal != null) {
          count = v;
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text('营业收入'),
                floating: true,
                leading: Offstage(),
                expandedHeight: 190,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.only(
                        top: 55 + getRange(context, type: 3),
                        left: 10,
                        right: 10,
                        bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      showMyDate(context, 1);
                                    },
                                    child: Text(
                                      begin == null ? '选择开始日期' : begin,
                                      style: TextStyle(
                                          color: begin == null
                                              ? textColor
                                              : Colors.black,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    '至',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showMyDate(context, 2);
                                    },
                                    child: Text(end == null ? '选择结束日期' : end,
                                        style: TextStyle(
                                            color: end == null
                                                ? textColor
                                                : Colors.black,
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: IconButton(
                                  icon: Icon(Icons.refresh),
                                  onPressed: () {
                                    setState(() {
                                      begin = null;
                                      end = null;
                                    });
                                    getCountData();
                                  }),
                            ),
                          ],
                        ),
                        /*MyInput(
                              prefixIcon: Icon(
                                Icons.search,
                                color: textColor,
                              ),
                              hintText: '输入姓名/电话/员工编号',
                            ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            PhysicalShape(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              color: Colors.transparent,
                              elevation: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      myColor(226, 144, 136),
                                      myColor(208, 81, 53)
                                    ]),
                                    borderRadius: BorderRadius.circular(10)),
                                height: h,
                                width: getRange(context) / 3 - 15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '收入合计',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text('${count.payTotal}',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            PhysicalShape(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              color: Colors.transparent,
                              elevation: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [myColor(130, 189, 253), c1]),
                                    borderRadius: BorderRadius.circular(10)),
                                height: h,
                                width: getRange(context) / 3 - 15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '消耗合计',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text('${double.parse(count.consumeTotal.toString()).toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                            PhysicalShape(
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              color: Colors.transparent,
                              elevation: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      myColor(238, 218, 152),
                                      myColor(232, 181, 74)
                                    ]),
                                    borderRadius: BorderRadius.circular(10)),
                                height: h,
                                width: getRange(context) / 3 - 15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '赠送合计',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text('0',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  color: bg2,
                  child: Column(
                    children: sr(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  color: bg2,
                  child: Column(
                    children: sr(type: 2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  color: bg2,
                  child: Column(
                    children: sr(type: 3),
                  ),
                ),
              ]))
            ],
          );
        } else {
          return Center(
            child: loading(),
          );
        }
      }),
      model: countModel,
    );
  }

  List<Widget> sr({int type = 1}) {
    String title = '收入合计';
    double money = count.payTotal;
    if (type == 2) {
      title = '消耗合计';
      money = count.consumeTotal;
    } else if (type == 3) {
      title = '赠送合计';
      money = 0;
    }
    List<Widget> list = [
      Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Text(
              '${money.toStringAsFixed(2)}',
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 16, color: c1),
            ),
          ],
        ),
      ),
      Column(
        children: <Widget>[
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Center(
                  child: Text('品项'),
                )),
                Expanded(
                    child: Center(
                  child: Text('数量'),
                )),
                Expanded(
                    child: Center(
                  child: Text('金额'),
                )),
                Center(
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
          Divider(),
        ],
      )
    ];
    if (type == 1) {
      List data = [
        {
          'money': '${count.cateData['pro']}',
          'name': '产品',
          'num': '${count.cateSumData['pro']}',
          'type': 'pro'
        },
        {
          'money': '${count.cateData['box']}',
          'name': '套盒',
          'num': '${count.cateSumData['box']}',
          'type': 'box'
        },
        {
          'money': '${count.cateData['item']}',
          'name': '项目',
          'num': '${count.cateSumData['item']}',
          'type': 'items'
        },
        {
          'money': '${count.cateData['card']}',
          'name': '卡项',
          'num': '${count.cateSumData['card']}',
          'type': 'card'
        },
        {
          'money': '${count.cateData['plan']}',
          'name': '方案',
          'num': '${count.cateSumData['plan']}',
          'type': 'plan'
        },
        {
          'money': '${count.cateData['underwear']}',
          'name': '内衣',
          'num': '${count.cateSumData['underwear']}',
          'type': 'plan'
        },
        {
          'money': '${count.cateData['recharge']}',
          'name': '充值',
          'num': '${count.cateSumData['recharge']}',
          'type': 'plan'
        },
        {'money': '0', 'name': '体验项目', 'num': '0', 'type': 'plan'},
      ];
      for (var v in data) {
        list.add(Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                jump2(context, CountLogs(v['type']));
              },
              child: Container(
                height: 40,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Center(
                      child: Text(
                        v['name'],
                      ),
                    )),
                    Expanded(
                        child: Center(
                      child: Text(v['num'],
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    )),
                    Expanded(
                        child: Center(
                      child: Text(
                        double.parse(v['money'].toString()).toStringAsFixed(2),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )),
                    Center(
                      child: Icon(Icons.chevron_right),
                    )
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ));
      }
    } else if (type == 2) {
      list.add(Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              jump2(
                  context,
                  ConsumeInfo(
                    type: 'items',
                  ));
            },
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Center(
                    child: Text(
                      '项目',
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Text('${count.consumeData['c_item_num']}',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(
                      '${double.parse(count.consumeData['c_item'].toString()).toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )),
                  Center(
                    child: Icon(Icons.chevron_right),
                  )
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ));
      list.add(Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              jump2(
                  context,
                  ConsumeInfo(
                    type: 'box',
                  ));
            },
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Center(
                    child: Text(
                      '套盒',
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Text('${count.consumeData['c_box_num']}',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(
                      '${count.consumeData['c_box']}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )),
                  Center(
                    child: Icon(Icons.chevron_right),
                  )
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ));
    } else if (type == 3) {
      List data = [
        {
          'money': '${count.sendData['s_pro']}',
          'name': '产品',
          'num': '${count.sendData['s_pro_num']}'
        },
        {
          'money': '${count.sendData['s_box']}',
          'name': '套盒',
          'num': '${count.sendData['s_box_num']}'
        },
        {
          'money': '${count.sendData['s_item']}',
          'name': '项目',
          'num': '${count.sendData['s_item_num']}'
        },
        {
          'money': '${count.sendData['s_card']}',
          'name': '卡项',
          'num': '${count.sendData['s_card_num']}'
        },
        {
          'money': '${count.sendData['s_plan']}',
          'name': '方案',
          'num': '${count.sendData['s_plan_num']}'
        },
        {
          'money': '${count.sendData['s_under']}',
          'name': '内衣',
          'num': '${count.sendData['s_under_num']}'
        },
        {'money': '0', 'name': '体验项目', 'num': '0'},
      ];
      for (var v in data) {
        list.add(Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                //jump2(context, CountLogs());
              },
              child: Container(
                height: 40,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Center(
                      child: Text(
                        v['name'],
                      ),
                    )),
                    Expanded(
                        child: Center(
                      child: Text(v['num'],
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    )),
                    Expanded(
                        child: Center(
                      child: Text(
                        v['money'],
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )),
                    Center(
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ));
      }
    }
    if (type == 1) {
      list.add(Container(
        color: bg2,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _item('现金', '${count.payTypeData['cash']}'),
                _item('刷卡', '${count.payTypeData['pos']}'),
                _item('微信', '${count.payTypeData['wx']}'),
                _item('支付宝', '${count.payTypeData['zfb']}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _item('美团', '${count.payTypeData['mt']}'),
                _item('大众点评', '${count.payTypeData['dz']}'),
                _item('收钱吧', '${count.payTypeData['sqb']}'),
                _item('亚索', '123.22'),
              ],
            )
          ],
        ),
      ));
    } else if (type == 2) {
      list.add(Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
                text: TextSpan(
                    text: '余额消耗',
                    children: [
                      TextSpan(
                          text: ' ${count.consumeData['c_balance']}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500))
                    ],
                    style: TextStyle(color: textColor))),
            RichText(
                text: TextSpan(
                    text: '卡项消耗',
                    children: [
                      TextSpan(
                          text: ' ${count.consumeData['c_card']}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500))
                    ],
                    style: TextStyle(color: textColor))),
          ],
        ),
      ));
    } else if (type == 3) {}
    return list;
  }

  Widget _item(String name, p) => Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                  color: name == '亚索' ? Colors.transparent : textColor),
            ),
            Text(
              p,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: name == '亚索' ? Colors.transparent : Colors.black),
            ),
          ],
        ),
      );
}
