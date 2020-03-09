import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/app/main/buy/royalty.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:flutter/cupertino.dart';

class NoCommission extends StatefulWidget {
  @override
  _NoCommissionState createState() => _NoCommissionState();
}

class _NoCommissionState extends State<NoCommission> {
  List list;
  List detail;
  String time = '';

  @override
  void initState() {
    super.initState();
    DateTime d = DateTime.now();
    time = '${d.year}-${d.month}-${d.day}';
    setState(() {});
    getSj();
  }

  void getSj() async {
    var rs = await get('not_raise_operation', data: {
      'time': time,
      'type': 1,
    });
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res']['list'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(time),
        actions: <Widget>[
          CupertinoButton(child: Icon(Icons.date_range), onPressed: (){
            showMyDate(context);
          })
        ],
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

  Widget _item(int i, {int status = -1}) {
    int s = list[i]['status'];
    String zt = '未付款';
    Widget ws = MyButton(
      width: getRange(context) / 5,
      onPressed: ()async {
        await jump2(context, Royalty(list[i]['id']));
        getSj();
      },
      titleStyle: TextStyle(fontSize: 13),
      title: '补提',
    );
    if (s == 1) {
      zt = "未付清";
    } else if (s == 2) {
      zt = "已付清";
    } else if (s == 3) {
      zt = "已取消";
    } else if (s == 4) {
      zt = "已退款";
    }
    if (status >= 0) {
      if (status == list[i]['status']) {
        return GestureDetector(
          onTap: () {
            showModel(list[i]['id']);
          },
          child: Container(
            decoration: BoxDecoration(
                color: bg2, borderRadius: BorderRadius.circular(10)),
            height: 200,
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          getImg('3_14'),
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text('${list[i]['store_name']}'),
                        ),
                      ],
                    ),
                    Text(
                      zt,
                      style: TextStyle(color: c1),
                    )
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Divider(
                    height: 0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                              text: TextSpan(
                                  text: '会员：',
                                  style: TextStyle(color: textColor),
                                  children: [
                                TextSpan(
                                    text: '${list[i]['name']}',
                                    style: TextStyle(color: Colors.black))
                              ])),
                          RichText(
                              text: TextSpan(
                                  text: '品项：',
                                  style: TextStyle(color: textColor),
                                  children: [
                                TextSpan(
                                    text: getType(list[i]['type']),
                                    style: TextStyle(color: Colors.black))
                              ])),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                        child: RichText(
                            text: TextSpan(
                                text: '订单编号：',
                                style: TextStyle(color: textColor),
                                children: [
                              TextSpan(
                                  text: '${list[i]['sn']}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500))
                            ])),
                      ),
                      RichText(
                          text: TextSpan(
                              text: '订单时间：',
                              style: TextStyle(color: textColor),
                              children: [
                            TextSpan(
                                text: '${list[i]['create_time']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500))
                          ])),
                    ],
                  ),
                  flex: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Divider(
                    height: 0,
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: '价格：',
                            style: TextStyle(color: textColor),
                            children: [
                          TextSpan(
                              text: '¥${list[i]['price']}',
                              style: TextStyle(
                                  color: c1, fontWeight: FontWeight.w500))
                        ])),
                    ws
                  ],
                )),
              ],
            ),
          ),
        );
      }
      return Offstage();
    } else {
      return GestureDetector(
        onTap: () {
          showModel(list[i]['id']);
        },
        child: Container(
          decoration: BoxDecoration(
              color: bg2, borderRadius: BorderRadius.circular(10)),
          height: 200,
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        getImg('3_14'),
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text('${list[i]['store_name']}'),
                      ),
                    ],
                  ),
                  Text(
                    zt,
                    style: TextStyle(color: c1),
                  )
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Divider(
                  height: 0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                            text: TextSpan(
                                text: '会员：',
                                style: TextStyle(color: textColor),
                                children: [
                              TextSpan(
                                  text: '${list[i]['name']}',
                                  style: TextStyle(color: Colors.black))
                            ])),
                        RichText(
                            text: TextSpan(
                                text: '品项：',
                                style: TextStyle(color: textColor),
                                children: [
                              TextSpan(
                                  text: getType(list[i]['type']),
                                  style: TextStyle(color: Colors.black))
                            ])),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: RichText(
                          text: TextSpan(
                              text: '订单编号：',
                              style: TextStyle(color: textColor),
                              children: [
                            TextSpan(
                                text: '${list[i]['sn']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500))
                          ])),
                    ),
                    RichText(
                        text: TextSpan(
                            text: '订单时间：',
                            style: TextStyle(color: textColor),
                            children: [
                          TextSpan(
                              text: '${list[i]['create_time']}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500))
                        ])),
                  ],
                ),
                flex: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Divider(
                  height: 0,
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                      text: TextSpan(
                          text: '价格：',
                          style: TextStyle(color: textColor),
                          children: [
                        TextSpan(
                            text: '¥${list[i]['price']}',
                            style: TextStyle(
                                color: c1, fontWeight: FontWeight.w500))
                      ])),
                  ws
                ],
              )),
            ],
          ),
        ),
      );
    }
  }

  void showModel(int id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => StatefulBuilder(builder: (_, state) {
              if (detail == null) {
                getDetail(id, state);
              }
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
                      title: Text('订单详情'),
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
                    body: detail != null
                        ? ListView.builder(
                            padding: EdgeInsets.all(15),
                            itemBuilder: (_, i) => _item2(i),
                            itemCount: detail.length,
                          )
                        : Center(
                            child: loading(),
                          ),
                  ),
                ),
              );
            }));
  }

  Widget _item2(int i) => Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '${detail[i]['name']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                Expanded(child: Center(child: Text('${detail[i]['sum']}'))),
                Expanded(child: Center(child: Text('${detail[i]['price']}'))),
              ],
            ),
          ),
          Divider()
        ],
      );

  void getDetail(int id, StateSetter state) async {
    //get_order_detail
    var rs = await post('get_order_detail', data: {
      'oid': id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        detail = rs['res'];
        state(() {});
      }
    }
  }

  String getType(int i) {
    String str = '';
    if (i == 1) {
      str = '产品';
    } else if (i == 2) {
      str = '套盒';
    } else if (i == 3) {
      str = '项目';
    } else if (i == 4) {
      str = '方案';
    } else if (i == 5) {
      str = '卡项';
    }
    return str;
  }
}
