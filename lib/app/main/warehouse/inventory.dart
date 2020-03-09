import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/app/main/warehouse/inventory_info.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:flutter/cupertino.dart';

class Inventory extends StatefulWidget {
  final int id;

  Inventory(this.id);

  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> with TickerProviderStateMixin {
  List list = [1, 2, 2, 2, 2, 2, 22, 2, 2];
  List un;
  List box;
  List cp;
  List hc;
  String input = '';
  int now = 0;
  TabController _tab;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('库存盘点'),
          bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  TabBar(
                    controller: _tab,
                    tabs: [
                      Tab(
                        text: '产品',
                      ),
                      Tab(
                        text: '套盒',
                      ),
                      Tab(
                        text: '耗材',
                      ),
                      Tab(
                        text: '内衣',
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 20, left: 10, right: 10),
                          height: 35,
                          child: MyInput(
                            prefixIcon: Icon(
                              Icons.search,
                              color: textColor,
                            ),
                            hintText: '输入产品名称',
                            onChanged: (v) {
                              setState(() {
                                input = v;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              preferredSize: Size(getRange(context), 110)),
          actions: <Widget>[
            CupertinoButton(
                child: Text('盈亏数'),
                onPressed: () {
                  jump2(context, InventoryInfo());
                })
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 30),
            child: MyButton(
              onPressed: () {
                sub();
              },
              title: '保存',
            ),
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
                    Expanded(child: Center(child: Text('名称'))),
                    Expanded(child: Center(child: Text('日期'))),
                    Expanded(child: Center(child: Text('库存数量'))),
                    Expanded(child: Center(child: Text('盘点数'))),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(controller: _tab, children: [
                  cp != null
                      ? ListView.builder(
                    itemBuilder: (_, i) => _item(i),
                    itemCount: cp.length,
                  )
                      : Center(
                    child: loading(),
                  ),
                  box != null
                      ? ListView.builder(
                    itemBuilder: (_, i) => _item2(i),
                    itemCount: box.length,
                  )
                      : Center(
                    child: loading(),
                  ),
                  hc != null
                      ? ListView.builder(
                    itemBuilder: (_, i) => _item3(i),
                    itemCount: hc.length,
                  )
                      : Center(
                    child: loading(),
                  ),
                  un != null
                      ? ListView.builder(
                    itemBuilder: (_, i) => _item4(i),
                    itemCount: un.length,
                  )
                      : Center(
                    child: loading(),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      length: 4,
    );
  }

  Widget _item(int i) {
    if (input.length > 0) {
      if (cp[i]['goods_name']
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
                        '${cp[i]['goods_name']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Expanded(
                  child: Center(
                      child: Text('${cp[i]['inventory_time']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${cp[i]['stock']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: MyInput2(
                          label: '',
                          controller: cp[i]['num'],
                          keyboardType: TextInputType.numberWithOptions(),
                          type: 2,
                          hintText: '请填写',
                          height: 60,
                          showBottomLine: false,
                        ),
                      ))),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  Widget _item2(int i) {
    if (input.length > 0) {
      if (box[i]['box_name']
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
                        '${box[i]['box_name']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Expanded(
                  child: Center(
                      child: Text('${box[i]['inventory_time']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${box[i]['stock']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: MyInput2(
                          label: '',
                          controller: box[i]['num'],
                          keyboardType: TextInputType.numberWithOptions(),
                          type: 2,
                          hintText: '请填写',
                          height: 60,
                          showBottomLine: false,
                        ),
                      ))),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  Widget _item3(int i) {
    if (input.length > 0) {
      if (hc[i]['name'].toString().toLowerCase().indexOf(input.toLowerCase()) <
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
                        '${hc[i]['name']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Expanded(
                  child: Center(
                      child: Text('${hc[i]['inventory_time']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${hc[i]['stock']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: MyInput2(
                          label: '',
                          controller: hc[i]['num'],
                          keyboardType: TextInputType.numberWithOptions(),
                          type: 2,
                          hintText: '请填写',
                          height: 60,
                          showBottomLine: false,
                        ),
                      ))),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  Widget _item4(int i) {
    if (input.length > 0) {
      if (un[i]['name'].toString().toLowerCase().indexOf(input.toLowerCase()) <
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
                        '${un[i]['name']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Expanded(
                  child: Center(
                      child: Text('${un[i]['time']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${un[i]['sum']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: MyInput2(
                          label: '',
                          controller: un[i]['num'],
                          keyboardType: TextInputType.numberWithOptions(),
                          type: 2,
                          hintText: '请填写',
                          height: 60,
                          showBottomLine: false,
                        ),
                      ))),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  void sub() async {
    List data = [];
    if (now == 0) {
      for (var v in cp) {
        if (v['num'].text.length > 0) {
          int n = int.parse(v['num'].text);
          int m = n-v['stock'];
          data.add({
            'type': now + 1,
            'name': v['goods_name'],
            'actual_num': n,
            'num': m,
            'goods_id': v['id'],
          });
        }
      }
    } else if (now == 1) {
      for (var v in box) {
        if (v['num'].text.length > 0) {
          int n = int.parse(v['num'].text);
          int m = n-v['stock'];
          data.add({
            'type': now + 1,
            'name': v['box_name'],
            'actual_num': n,
            'num': m,
            'goods_id': v['id'],
          });
        }
      }
    } else if (now == 2) {
      for (var v in hc) {
        if (v['num'].text.length > 0) {
          int n = int.parse(v['num'].text);
          int m = n-v['stock'];
          data.add({
            'type': now + 1,
            'name': v['name'],
            'actual_num': n,
            'num': m,
            'goods_id': v['id'],
          });
        }
      }
    } else if (now == 3) {
      for (var v in un) {
        if (v['num'].text.length > 0) {
          int n = int.parse(v['num'].text);
          int m = n-v['stock'];
          data.add({
            'type': now + 1,
            'name': v['name'],
            'actual_num': n,
            'num': m,
            'goods_id': v['id'],
          });
        }
      }
    }
    if (data.length == 0) {
      return tip(context, '请输入盘点数');
    }//print(data);
    var rs = await post('pd', data: {'data': jsonEncode(data)});
    if (rs != null) {
      if (rs['code'] == 0) {
        if (now == 0) {
          getCp();
        }
        if (now == 1) {
          getTh();
        }
        if (now == 2) {
          getHc();
        }
        if (now == 3) {
          getUn();
        }
        ok(context, '成功', type: 2);
      }
    }
  }

  void showMyDate(BuildContext context,
      {bool showTitleActions = false,
        DateTime minTime,
        DateTime maxTime}) async {
    DatePicker.showDatePicker(context,
        showTitleActions: showTitleActions,
        maxTime: maxTime,
        minTime: minTime,
        locale: LocaleType.zh,
        onChanged: (DateTime d) {});
  }

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
    _tab.addListener(() {
      now = _tab.index;
      //print(now);
    });
    getCp();
    getHc();
    getTh();
    getUn();
  }

  void getUn() async {
    var rs = await get('getUn');
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          for (var v in rs['data']) {
            v['num'] = TextEditingController(text: '');
          }
          un = rs['data'];
        });
      }
    }
  }

  void getTh() async {
    var rs = await get('getTh');
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          for (var v in rs['data']) {
            v['num'] = TextEditingController(text: '');
          }
          box = rs['data'];
        });
      }
    }
  }

  void getHc() async {
    var rs = await get('getHc');
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          for (var v in rs['data']) {
            v['num'] = TextEditingController(text: '');
          }
          hc = rs['data'];
        });
      }
    }
  }

  void getCp() async {
    var rs = await get('getCp');
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          for (var v in rs['data']) {
            v['num'] = TextEditingController(text: '');
          }
          cp = rs['data'];
        });
      }
    }
  }
}
