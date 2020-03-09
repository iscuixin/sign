import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyChip.dart';

class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  List list;
  String begin;
  String end;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('员工分析'),
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
      body: list != null
          ? ListView.builder(
              itemBuilder: (_, i) => _item(i),
              itemCount: list.length,
            )
          : Center(
              child: loading(),
            ),
    );
  }

  Widget _item(int i) {
    return Container(
      height: 210,
      decoration:
          BoxDecoration(color: bg2, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${list[i]['name']}'),
              ],
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '消耗金额',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['consume_money']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '操作次数',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['operation_num']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '手工金额',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['manual']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '客户数',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['dis_member']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '新客数',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['new_member']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '项目业绩',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['items_ach']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '套盒业绩',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['box_ach']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '产品业绩',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['goods_ach']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '方案业绩',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['plan_ach']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '卡扣业绩',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['card_ach']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '卡项业绩',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['sale_card_ach']}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '大项目业绩',
                        style: TextStyle(color: Colors.transparent),
                      ),
                      Text(
                        '${list[i]['operation_num']}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.transparent),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
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
    var rs = await post('staff_analysis', data: {'start': start, 'end': end});
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
