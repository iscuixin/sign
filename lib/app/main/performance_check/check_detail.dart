import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/app/main/performance_check/edit_data.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/widget/MyButton.dart';

class CheckDetail extends StatefulWidget {
  @override
  _CheckDetailState createState() => _CheckDetailState();
}

class _CheckDetailState extends State<CheckDetail> {
  List list = [1, 1, 1, 1, 1, 1, 1, 1];
  bool zt = false;
  bool zt2 = false;
  bool zt3 = false;
  bool zt4 = false;
  String time = '';
  List consume = [1];
  List consumption = [1];
  List labour = [1];
  List card = [1];

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await post('get_day_achievement', data: {
      'time': time,
    });
    if (rs != null) {
      //print(rs);
      if (rs['code'] == 1) {
        consume = [1];
        consumption = [1];
        labour = [1];
        card = [1];
        for (var v in rs['res']['consume']) {
          consume.add(v);
        }
        for (var v in rs['res']['consumption']) {
          consumption.add(v);
        }
        for (var v in rs['res']['labour']) {
          labour.add(v);
        }
        for (var v in rs['res']['card']) {
          card.add(v);
        }
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(time),
        actions: <Widget>[
          CupertinoButton(
              child: Icon(
                Icons.date_range,
              ),
              onPressed: () {
                showMyDate(context);
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    setState(() {
                      zt = !zt;
                    });
                  },
                  title: Text('消费提成（${consumption.length - 1}）'),
                  trailing: zt
                      ? Icon(Icons.keyboard_arrow_down)
                      : Icon(Icons.chevron_right),
                ),
                AnimatedCrossFade(
                    firstChild: Offstage(),
                    secondChild: Container(
                      width: getRange(context) * 2,
                      height:
                          double.parse((50 * consumption.length).toString()),
                      constraints: BoxConstraints(
                          maxHeight: getRange(context, type: 2) / 2),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                              color: tableBg,
                              width: getRange(context) * 2,
                              child: ListView.builder(
                                itemBuilder: (_, i) => _item(i, 1),
                                itemCount: consumption.length,
                              ))
                        ],
                      ),
                    ),
                    crossFadeState: zt
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 200))
              ],
            ),
            color: bg2,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    setState(() {
                      zt2 = !zt2;
                    });
                  },
                  title: Text('消耗提成（${consume.length - 1}）'),
                  trailing: zt2
                      ? Icon(Icons.keyboard_arrow_down)
                      : Icon(Icons.chevron_right),
                ),
                AnimatedCrossFade(
                    firstChild: Offstage(),
                    secondChild: Container(
                      width: getRange(context) * 2,
                      height:
                          double.parse((50 * consumption.length).toString()),
                      constraints: BoxConstraints(
                          maxHeight: getRange(context, type: 2) / 2),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                              color: tableBg,
                              width: getRange(context) * 2,
                              child: ListView.builder(
                                itemBuilder: (_, i) => _item(i, 2),
                                itemCount: consume.length,
                              ))
                        ],
                      ),
                    ),
                    crossFadeState: zt2
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 200))
              ],
            ),
            color: bg2,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    setState(() {
                      zt3 = !zt3;
                    });
                  },
                  title: Text('手工提成（${labour.length - 1}）'),
                  trailing: zt3
                      ? Icon(Icons.keyboard_arrow_down)
                      : Icon(Icons.chevron_right),
                ),
                AnimatedCrossFade(
                    firstChild: Offstage(),
                    secondChild: Container(
                      width: getRange(context) * 2,
                      height:
                          double.parse((50 * labour.length).toString()),
                      constraints: BoxConstraints(
                          maxHeight: getRange(context, type: 2) / 2),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                              color: tableBg,
                              width: getRange(context) * 2,
                              child: ListView.builder(
                                itemBuilder: (_, i) => _item(i, 3),
                                itemCount: labour.length,
                              ))
                        ],
                      ),
                    ),
                    crossFadeState: zt3
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 200))
              ],
            ),
            color: bg2,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    setState(() {
                      zt4 = !zt4;
                    });
                  },
                  title: Text('卡扣提成（${card.length - 1}）'),
                  trailing: zt4
                      ? Icon(Icons.keyboard_arrow_down)
                      : Icon(Icons.chevron_right),
                ),
                AnimatedCrossFade(
                    firstChild: Offstage(),
                    secondChild: Container(
                      width: getRange(context) * 2,
                      height:
                          double.parse((50 * card.length).toString()),
                      constraints: BoxConstraints(
                          maxHeight: getRange(context, type: 2) / 2),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                              color: tableBg,
                              width: getRange(context) * 2,
                              child: ListView.builder(
                                itemBuilder: (_, i) => _item(i, 4),
                                itemCount: card.length,
                              ))
                        ],
                      ),
                    ),
                    crossFadeState: zt4
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 200))
              ],
            ),
            color: bg2,
          ),
        ],
      ),
    );
  }

  Widget _item(int i, t) {
    if (i == 0) {
      if (t == 1 || t == 2) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  child: Text('员工'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('提成类型'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('名称'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('客户'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('总消费'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('提成业绩'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('时间'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('操作'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
              ],
            ),
            Divider(
              height: 0,
            ),
          ],
        );
      }
      if (t == 3||t==4) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  child: Text('员工'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('客户'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('总手工'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('获得手工'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('时间'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('操作'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
              ],
            ),
            Divider(
              height: 0,
            ),
          ],
        );
      }
      if (t == 4) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  child: Text('员工'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('客户'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('卡扣金额'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('提成业绩'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('时间'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('操作'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
              ],
            ),
            Divider(
              height: 0,
            ),
          ],
        );
      }
    } else {
      if (t == 1 || t == 2) {
        Map data;
        if (t == 1) {
          data = consumption[i];
        } else if (t == 2) {
          data = consume[i];
        }
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                  child: Text('${data['staff_name']}'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text(
                      '${data['raise_type'] == 1 ? '按提成' : data['raise_type'] == 2 ? '按业绩' : ''}'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text(
                    '${t == 1 ? data['buy_name'] : data['consume_name']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('${data['m_name']}'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('${data['total_money']}'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('${data['money']}'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Container(
                  child: Text('${data['time']}'),
                  alignment: Alignment.center,
                  color: tableBg,
                  height: 50,
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: MyButton(
                    title: '修改',
                    height: 30,
                    titleStyle: TextStyle(fontSize: 14),
                    onPressed: () async {
                      await jump2(context, EditData(t, data['id']));
                      getSj();
                    },
                  ),
                )),
              ],
            ),
            Divider(
              height: 0,
            ),
          ],
        );
      }
      if(t==3 || t==4){
        Map data;
        if(t==3){
          data = labour[i];
        }else
        if(t==4){
          data = card[i];
        }
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      child: Text('${data['staff_name']}'),
                      alignment: Alignment.center,
                      color: tableBg,
                      height: 50,
                    )),
                Expanded(
                    child: Container(
                      child: Text('${data['m_name']}'),
                      alignment: Alignment.center,
                      color: tableBg,
                      height: 50,
                    )),
                Expanded(
                    child: Container(
                      child: Text('${data['total_fee']}'),
                      alignment: Alignment.center,
                      color: tableBg,
                      height: 50,
                    )),
                Expanded(
                    child: Container(
                      child: Text('${data['fee']}'),
                      alignment: Alignment.center,
                      color: tableBg,
                      height: 50,
                    )),
                Expanded(
                    child: Container(
                      child: Text('${data['time']}'),
                      alignment: Alignment.center,
                      color: tableBg,
                      height: 50,
                    )),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: MyButton(
                        title: '修改',
                        height: 30,
                        titleStyle: TextStyle(fontSize: 14),
                        onPressed: () async {
                          await jump2(context, EditData(t, data['id']));
                          getSj();
                        },
                      ),
                    )),
              ],
            ),
            Divider(
              height: 0,
            ),
          ],
        );
      }
    }
    return Offstage();
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
      time = '${d.year}-${d.month}-${d.day}';
      getSj();
    });
  }
}
