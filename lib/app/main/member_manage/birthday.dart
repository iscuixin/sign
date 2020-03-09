import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyChip.dart';
import 'package:myh_shop/widget/MyInput.dart';

class Birthday extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Birthday> {
  List list;
  String begin;
  String end;
  String input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('生日列表'),
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
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: bg2,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(child: Text('姓名')),
                ),
                Expanded(child: Center(child: Text('生日'))),
                Expanded(child: Center(child: Text('电话'))),
              ],
            ),
          ),
          Expanded(
              child: list != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    )
                  : Center(
                      child: loading(),
                    ))
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
                  child: Center(
                      child: Text('${list[i]['birthday']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['tel']}',
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
    );
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
    var rs = await post('BirthdayDetail',
        data: {'start': start, 'end': end, 'search': 'day'});
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res'];
        });
      }
    }
    //print(rs);
  }
}
