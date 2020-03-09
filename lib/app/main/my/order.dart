import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/app/main/buy/pay.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List list;
  List detail;
  String begin;
  String end;
  String input = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj({String start, end}) async {
    var rs = await get('get_order', data: {
      'type': 'all',
      'status': '',
      'start': start == null ? '' : start,
      'end': end == null ? '' : end,
    });
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        list = rs['res']['list'];
        setState(() {});
      }
    }
  }

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

  int getNum(int s) {
    int n = 0;
    for (var v in list) {
      if (v['status'] == s) {
        n++;
      }
    }
    //print(n);
    return n;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('订单中心'),
          actions: <Widget>[
            //CupertinoButton(child: Text('日期查询'), onPressed: () {})
          ],
          bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
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
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 30, right: 30),
                    child: MyInput(
                      onChanged: (v) {
                        setState(() {
                          input = v;
                        });
                      },
                      prefixIcon: Icon(
                        Icons.search,
                        color: textColor,
                      ),
                      hintText: '输入姓名/品项',
                    ),
                  ),
                  TabBar(
                    tabs: [
                      Tab(
                        text: '全部',
                      ),
                      Tab(
                        text: '未付款',
                      ),
                      Tab(
                        text: '未付清',
                      ),
                      Tab(
                        text: '已付清',
                      ),
                      Tab(
                        text: '已取消',
                      ),
                      Tab(
                        text: '已退款',
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.all(0),
                    indicatorColor: c1,
                    labelColor: c1,
                    unselectedLabelColor: textColor,
                    indicatorPadding:
                        EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  )
                ],
              ),
              preferredSize: Size(getRange(context), 150)),
        ),
        body: TabBarView(children: [
          list != null
              ? ListView.builder(
                  itemBuilder: (_, i) => _item(
                        i,
                      ),
                  itemCount: list.length,
                )
              : Center(
                  child: loading(),
                ),
          list != null
              ? ListView.builder(
                  itemBuilder: (_, i) => _item(i, status: 0),
                  itemCount: list.length,
                )
              : Center(
                  child: loading(),
                ),
          list != null
              ? ListView.builder(
                  itemBuilder: (_, i) => _item(i, status: 1),
                  itemCount: list.length,
                )
              : Center(
                  child: loading(),
                ),
          list != null
              ? ListView.builder(
                  itemBuilder: (_, i) => _item(i, status: 2),
                  itemCount: list.length,
                )
              : Center(
                  child: loading(),
                ),
          list != null
              ? ListView.builder(
                  itemBuilder: (_, i) => _item(i, status: 3),
                  itemCount: list.length,
                )
              : Center(
                  child: loading(),
                ),
          list != null
              ? ListView.builder(
                  itemBuilder: (_, i) => _item(i, status: 4),
                  itemCount: list.length,
                )
              : Center(
                  child: loading(),
                ),
        ]),
      ),
      length: 6,
    );
  }

  Widget _item(int i, {int status = -1}) {
    if (input.length > 0) {
      int t = 0;
      if (input == '产品') {
        t = 1;
      } else if (input == '套盒') {
        t = 2;
      } else if (input == '项目') {
        t = 3;
      } else if (input == '方案') {
        t = 4;
      } else if (input == '卡项') {
        t = 5;
      }
      if (t == 0 &&
          list[i]['name']
                  .toString()
                  .toLowerCase()
                  .indexOf(input.toLowerCase()) <
              0) {
        return Offstage();
      } else {
        if (list[i]['type'] != t &&
            list[i]['name']
                    .toString()
                    .toLowerCase()
                    .indexOf(input.toLowerCase()) <
                0) {
          return Offstage();
        }
      }
    }
    int s = list[i]['status'];
    String zt = '未付款';
    Widget ws = Row(
      children: <Widget>[
        MyButton(
          width: getRange(context) / 5,
          onPressed: () async {
            getArr(list[i]['id']);
          },
          titleStyle: TextStyle(fontSize: 13),
          title: '支付',
        ),
        Padding(padding: EdgeInsets.only(left: 10)),
        MyButton(
          width: getRange(context) / 5,
          onPressed: () async {
            var rs = await showAlert(context, '是否取消该订单？');
            if (rs) {
              cancelOrder(list[i]['id']);
            }
          },
          title: '取消订单',
          titleStyle: TextStyle(fontSize: 13),
          color: myColor(178, 179, 180),
        ),
      ],
    );
    if (s == 1) {
      zt = "未付清";
      ws = Row(
        children: <Widget>[
          MyButton(
            width: getRange(context) / 5,
            onPressed: () {
              getArr(list[i]['id'], t: 2);
            },
            titleStyle: TextStyle(fontSize: 13),
            title: '补款',
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          MyButton(
            width: getRange(context) / 5,
            onPressed: () async {
              var rs = await showAlert(context, '是否退款？');
              if (rs) {
                refundOrder(list[i]['id']);
              }
            },
            title: '退款/换货',
            titleStyle: TextStyle(fontSize: 13),
            color: myColor(178, 179, 180),
          ),
        ],
      );
    } else if (s == 2) {
      zt = "已付清";
      ws = Row(
        children: <Widget>[
          MyButton(
            width: getRange(context) / 5,
            onPressed: () async {
              var rs = await showAlert(context, '是否退款？');
              if (rs) {
                refundOrder(list[i]['id']);
              }
            },
            title: '退款/换货',
            titleStyle: TextStyle(fontSize: 13),
            color: myColor(178, 179, 180),
          ),
        ],
      );
    } else if (s == 3) {
      zt = "已取消";
      ws = Offstage();
    } else if (s == 4) {
      zt = "已退款";
      ws = Offstage();
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

  void cancelOrder(int id) async {
    var rs = await post('CancelOrder', data: {'id': id});
    if (rs != null) {
      if (rs['code'] == 1) {
        getSj(start: begin ?? '', end: end ?? '');
      }
    }
  }

  void refundOrder(int id) async {
    var rs = await post('refund_order', data: {'oid': id});
    if (rs != null) {
      if (rs['code'] == 1) {
        getSj(start: begin ?? '', end: end ?? '');
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

  String getStatus(int i) {
    String str = '';
    if (i == 0) {
      str = '未付款';
    } else if (i == 1) {
      str = '未付清';
    } else if (i == 2) {
      str = '已付清';
    } else if (i == 3) {
      str = '已取消';
    } else if (i == 4) {
      str = '已退款';
    }
    return str;
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
                        ? Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                color: bg2,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Center(child: Text('名称')), flex: 2,),
                                    Expanded(
                                        child: Center(child: Text('数量'))),
                                    Expanded(
                                        child: Center(child: Text('价格'))),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.all(15),
                                  itemBuilder: (_, i) => _item2(i),
                                  itemCount: detail.length,
                                ),
                              ),
                            ],
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

  void getArr(int id, {t = 1}) async {
    var rs = await post('check_arrears', data: {
      'oid': id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        if (t == 2) {
          await jump2(context, Pay(rs['res'], 0));
        } else {
          await jump2(context, Pay(id, rs['res']));
        }
        getSj();
      }
    }
  }
}
