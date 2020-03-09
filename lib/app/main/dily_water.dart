import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';

class DilyWater extends StatefulWidget {
  @override
  _DilyWaterState createState() => _DilyWaterState();
}

class _DilyWaterState extends State<DilyWater> {
  List list;
  String cardPayTotal = '0';
  String consumeTotal = '0';
  int count = 0;
  String totalMoney = '0';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj({String t = ''}) async {
    var rs = await post('DailyIncomeDetail', data: {'day': t});
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res']['res'];
          cardPayTotal = double.parse(rs['res']['card_pay_total'].toString()).toStringAsFixed(2);
          consumeTotal = double.parse(rs['res']['consume_total'].toString()).toStringAsFixed(2);
          count = int.parse(rs['res']['count'].toString());
          totalMoney = double.parse(rs['res']['total_money'].toString()).toStringAsFixed(2);
        });
      } else {
        tip(context, rs['error']);
      }
    }
  }

  String getType(int type) {
    String str = '';
    if (type == 1) {
      str = '产品';
    }
    if (type == 2) {
      str = '套盒';
    }
    if (type == 3) {
      str = '项目';
    }
    if (type == 4) {
      str = '方案';
    }
    if (type == 5) {
      str = '卡项';
    }
    if (type == 6) {
      str = '账户/卡';
    }
    if (type == 7) {
      str = '内衣';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('每日业绩流水'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.date_range),
              onPressed: () {
                showMyDate(context);
              })
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
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
                      height: 60,
                      width: getRange(context) / 4 - 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '消费业绩',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('$totalMoney',
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
                      height: 60,
                      width: getRange(context) / 4 - 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '消耗业绩',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('$consumeTotal',
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
                            myColor(230, 133, 161),
                            myColor(225, 80, 95)
                          ]),
                          borderRadius: BorderRadius.circular(10)),
                      height: 60,
                      width: getRange(context) / 4 - 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '实操项目数',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('$count', style: TextStyle(color: Colors.white)),
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
                      height: 60,
                      width: getRange(context) / 4 - 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '卡扣业绩',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('$cardPayTotal',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size(getRange(context), 70)),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          alignment: Alignment.center,
          child: MyButton(
            onPressed: () {
              getSj();
            },
            title: '全部业绩',
          ),
          height: 50,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              color: bg2,
              child: Row(
                children: <Widget>[
                  Expanded(child: Center(child: Text('品项'))),
                  Expanded(child: Center(child: Text('姓名'))),
                  Expanded(child: Center(child: Text('名称'))),
                  Expanded(child: Center(child: Text('类型'))),
                  Expanded(child: Center(child: Text('金额'))),
                ],
              ),
            ),
            Expanded(
              child: list == null
                  ? Center(
                      child: loading(),
                    )
                  : ListView.builder(
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _item(int i) {
    String t = '';
    if (list[i]['status'] == 1 && list[i]['money'] != 0) {
      t = '消费';
    }
    if (list[i]['status'] == 2 && list[i]['money'] != 0) {
      t = '消耗';
    }
    if (list[i]['status'] == 3 && list[i]['money'] != 0) {
      t = '充值';
    }
    if (double.parse(list[i]['money'].toString()) == 0) {
      t = '欠款';
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
                  child: Chip(
                label: Text(
                  getType(list[i]['type']),
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: c1,
              )),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['m_name']}',
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
                      child: Text(t,
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['money']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  void showMyDate(BuildContext context,
      {bool showTitleActions = true,
      DateTime minTime,
      DateTime maxTime}) async {
    DatePicker.showDatePicker(context,
        showTitleActions: showTitleActions,
        maxTime: maxTime,
        minTime: minTime,
        locale: LocaleType.zh, onConfirm: (DateTime d) {
      getSj(t: '${d.year}-${d.month}-${d.day}');
    });
  }
}
