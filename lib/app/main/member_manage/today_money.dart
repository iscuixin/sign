import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyChip.dart';
import 'package:myh_shop/widget/MyInput.dart';
import 'package:flutter/cupertino.dart';

class TodayMoney extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<TodayMoney> {
  List list;
  String begin;
  String end;
  String input = '';
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('今日总营业额'),
        actions: <Widget>[
          Center(
              child: Text(
            '$total',
            style: TextStyle(fontSize: 16),
          ))
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              getSj();
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MyInput(
                      onChanged: (v) {
                        setState(() {
                          input = v;
                        });
                      },
                      hintText: '输入姓名查询',
                      prefixIcon: Icon(
                        Icons.search,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size(getRange(context), 100)),
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
                    Expanded(child: Center(child: Text('品项'))),
                    Expanded(child: Center(child: Text('时间'))),
                    Expanded(child: Center(child: Text('客户'))),
                    Expanded(child: Center(child: Text('商品名称'))),
                    Expanded(child: Center(child: Text('类型'))),
                    Expanded(child: Center(child: Text('状态'))),
                    Expanded(child: Center(child: Text('已支付'))),
                    Expanded(child: Center(child: Text('明细'))),
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
    if (input.length > 0) {
      if (list[i]['name']
              .toString()
              .toLowerCase()
              .indexOf(input.toLowerCase()) <
          0) {
        return Offstage();
      }
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 60,
          width: getRange(context) * 2,
          color: bg2,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Center(
                      child: Text(
                '${getType(list[i]['type'])}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['time']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['name']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['goods_name']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${getStatus(list[i])}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${getStatus2(list[i])}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['money']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              MyButton(
                title: '详情',
                width: 80,
                height: 30,
                onPressed: () {
                  show(list[i]);
                },
                titleStyle: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  String getStatus2(Map v) {
    String str = '';
    if (v['is_back'] == 1) {
      str = '正常';
    } else if (v['is_back'] == 2) {
      str = '退单';
    } else if (v['is_back'] == 3) {
      str = '欠款';
    } else if (v['is_back'] == 4) {
      str = '赠送';
    }
    return str;
  }

  String getStatus(Map v) {
    if (double.parse(v['one_total'].toString()) > 0 &&
        double.parse(v['money'].toString()) > 0) {
      if (v['status'] == 1 && v['type'] != 6) {
        if (double.parse(v['card_pay'].toString()) > 0) {
          return '消费 / 卡扣';
        }
        return '消费';
      }
      if (v['status'] == 2 && v['type'] != 6) {
        return '消耗';
      }
      if (v['type'] == 3) {
        return '充值';
      }
    }
    if (v['status'] == 1 &&
        v['type'] != 6 &&
        (v['one_total'] == 0 || v['money'] == 0)) {
      return '赠送';
    }
    return '';
  }

  String getType(int t) {
    String str = '';
    if (t == 1) {
      str = '产品';
    } else if (t == 2) {
      str = '套盒';
    } else if (t == 3) {
      str = '项目';
    } else if (t == 4) {
      str = '方案';
    } else if (t == 5) {
      str = '卡项';
    } else if (t == 6) {
      str = '账户';
    } else if (t == 7) {
      str = '内衣';
    }
    return str;
  }

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
        getSj(start: begin, end: end);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj({String start = '', end = ''}) async {
    var rs = await get('memberTotal', data: {'start': start, 'end': end});
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res']['arr'];
          total = double.parse(rs['res']['xf_total_money'].toString());
        });
      }
    }
  }

  void show(Map v) async {
    //print(v);
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('详情'),
              content: Container(
                height: getRange(context, type: 2) / 3,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '卡扣支付：¥${v['card_pay'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '余额支付：¥${v['account_pay'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '现金支付：¥${v['cash_pay'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '微信支付：¥${v['wx_pay'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '支付宝支付：¥${v['zfb_pay'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '银行卡支付：¥${v['bank'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '美团支付：¥${v['mt'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '大众点评支付：¥${v['dzdp'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '收钱包支付：¥${v['sqb'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '优惠券抵扣：¥${v['counpon'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '合计消费：¥${v['money'] ?? 0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('关闭'),
                  onPressed: () {
                    back(context);
                  },
                )
              ],
            ));
  }
}
