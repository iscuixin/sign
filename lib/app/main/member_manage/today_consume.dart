import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyChip.dart';
import 'package:myh_shop/widget/MyInput.dart';

class TodayConsume extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<TodayConsume> {
  List list;
  String begin;
  String end;
  String input = '';
  List detail;
  StateSetter state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('今日操作汇总'),
        actions: <Widget>[
          CupertinoButton(child: Text('退单记录'), onPressed: () {
            jump(context, 'refund_logs');
          })
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
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
                                color: begin == null ? textColor : Colors.black,
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
                                  color: end == null ? textColor : Colors.black,
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
            ),
            preferredSize: Size(getRange(context), 50)),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                width: getRange(context) + 200,
                color: bg2,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Center(child: Text('会员'))),
                    Expanded(child: Center(child: Text('总消耗金额'))),
                    Expanded(child: Center(child: Text('总次数'))),
                    Expanded(child: Center(child: Text('时间'))),
                    Expanded(
                      child: Center(child: Text('操作')),
                      flex: 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: getRange(context) + 200,
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
          width: getRange(context) + 200,
          color: bg2,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['user']['name']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['total_money']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['consume_num']}',
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
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyButton(
                      title: '查看',
                      onPressed: () {
                        getDetail(list[i]['id']);
                        showModel();
                      },
                      width: 70,
                      height: 30,
                      titleStyle: TextStyle(fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: MyButton(
                          title: '退单',
                          onPressed: () async {
                            if(await showAlert(context, '是否确定退单？')){
                              refund(list[i]['id']);
                            }
                          },
                          color: Colors.red,
                          width: 70,
                          titleStyle: TextStyle(fontSize: 14),
                          height: 30),
                    ),
                  ],
                ),
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

  void refund(int id) async {
    var rs = await post('consumeRefund', data: {
      'id': id
    });
    if(rs!=null){
      if(rs['code']==0){
        getSj(start: begin??'', end: end??'');
      }
    }
  }

  void showModel() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => StatefulBuilder(builder: (_, state){
          this.state = state;
          return Container(
            margin: EdgeInsets.only(
                top: getRange(context, type: 2) / 8,
                bottom: getRange(context, type: 2) / 8,
                left: 15,
                right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Scaffold(
                backgroundColor: bg2,
                appBar: MyAppBar(
                  title: Text('消耗详情'),
                  leading: Offstage(),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          detail = null;
                          back(context);
                        })
                  ],
                ),
                body: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      color: bg2,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Center(child: Text('消耗名称')),
                          ),
                          Expanded(child: Center(child: Text('消耗金额'))),
                          Expanded(child: Center(child: Text('次数'))),
                          Expanded(child: Center(child: Text('操作人'))),
                        ],
                      ),
                    ),
                    Expanded(
                        child: detail != null
                            ? ListView.builder(
                          itemBuilder: (_, i) => Column(
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
                                              '${detail[i]['designation_name']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ))),
                                    Expanded(
                                        child: Center(
                                            child: Text('${detail[i]['consume_money']}',
                                                maxLines: 1, overflow: TextOverflow.ellipsis))),
                                    Expanded(
                                        child: Center(
                                            child: Text('${detail[i]['consume_num']}',
                                                style: TextStyle(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis))),
                                    Expanded(
                                        child: Center(
                                            child: Text('${detail[i]['operation']}',
                                                style: TextStyle(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis))),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 0,
                              ),
                            ],
                          ),
                          itemCount: detail.length,
                        )
                            : Center(
                          child: loading(),
                        ))
                  ],
                ),
              ),
            ),
          );
        },));
  }

  void getDetail(int id) async {
    var rs = await post('consumeDetail', data: {
      'id': id
    });
    if(rs!=null){
      if(rs['code']==0){
        detail = rs['data'];
        state((){});
      }
    }
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
    var rs = await post('getConsume', data: {'s': start, 'e': end});
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          list = rs['data'];
        });
      }
    }
    //print(rs);
  }
}
