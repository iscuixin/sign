import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/app/main/performance_check/commission_detail.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:flutter/cupertino.dart';

class Month extends StatefulWidget {
  @override
  _DilyWaterState createState() => _DilyWaterState();
}

class _DilyWaterState extends State<Month> {
  List list;
  double xfTotal = 0;
  double xhTotal = 0;
  double feeTotal = 0;
  double total = 0;
  String time = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_per_detail', data: {
      'type': time.length==0?'list':'search',
      'time': time,
    });
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res']['staffArr'];
          for (var v in list) {
            xfTotal += v['xf_total'];
            xhTotal += v['xh_total'];
            feeTotal += v['fee_total'];
            total += v['raise_money'];
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('每月业绩核对'),
        actions: <Widget>[
          CupertinoButton(
              child: Icon(Icons.date_range),
              onPressed: () {
                showMyDate(context);
              })
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
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
                          Text(xfTotal.toStringAsFixed(2),
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
                            '消耗总业绩',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(xhTotal.toStringAsFixed(2),
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
                            '总手工',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(feeTotal.toStringAsFixed(2),
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
                            myColor(130, 189, 253),
                            myColor(81, 141, 250)
                          ]),
                          borderRadius: BorderRadius.circular(10)),
                      height: 60,
                      width: getRange(context) / 4 - 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '总提成',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(total.toStringAsFixed(2),
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
            onPressed: () {},
            title: '全部业绩',
          ),
          height: 50,
        ),
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
                    Expanded(child: Center(child: Text('员工'))),
                    Expanded(child: Center(child: Text('总消费'))),
                    Expanded(child: Center(child: Text('消费提成'))),
                    Expanded(child: Center(child: Text('总消耗'))),
                    Expanded(child: Center(child: Text('消耗提成'))),
                    Expanded(child: Center(child: Text('卡扣'))),
                    Expanded(child: Center(child: Text('卡扣提成'))),
                    Expanded(child: Center(child: Text('总手工'))),
                    Expanded(child: Center(child: Text('总提成'))),
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
                '${list[i]['name']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: GestureDetector(
                onTap: () async {
                  await jump2(context, CommissionDetail(1, list[i]['id']));
                  getSj();
                },
                child: Center(
                    child: Text(
                  '${list[i]['xf_total'] ?? 0}',
                  maxLines: 1,
                  style: TextStyle(color: c1, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                )),
              )),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['xf_total_raise'] ?? 0}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: GestureDetector(
                onTap: () async {
                  await jump2(context, CommissionDetail(2, list[i]['id']));
                  getSj();
                },
                child: Center(
                    child: Text('${list[i]['xh_total'] ?? 0}',
                        style:
                            TextStyle(color: c1, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),
              )),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['xh_total_raise'] ?? 0}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: GestureDetector(
                onTap: () async {
                  await jump2(context, CommissionDetail(4, list[i]['id']));
                  getSj();
                },
                child: Center(
                    child: Text('${list[i]['card_total'] ?? 0}',
                        style:
                            TextStyle(color: c1, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),
              )),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['card_total_raise'] ?? 0}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: GestureDetector(
                onTap: () async {
                  await jump2(context, CommissionDetail(3, list[i]['id']));
                  getSj();
                },
                child: Center(
                    child: Text('${list[i]['fee_total'] ?? 0}',
                        style:
                            TextStyle(color: c1, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),
              )),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['raise_money'] ?? 0}',
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
        locale: LocaleType.zh,
        onConfirm: (DateTime d) {
      time = '${d.year}-${d.month}';
      getSj();
        });
  }
}
