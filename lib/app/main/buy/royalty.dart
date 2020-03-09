import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class Royalty extends StatefulWidget {
  final int id;
  final int aid;
  final String type;

  Royalty(this.id, {this.type = '', this.aid});

  @override
  _RoyaltyState createState() => _RoyaltyState();
}

class _RoyaltyState extends State<Royalty> with TickerProviderStateMixin {
  List d = [];
  List g = [];
  List m = [];
  int printType = 0;
  double total = 0;
  double acCardTotal = 0;
  /*List checkM = [];
  List checkD = [];
  List checkG = [];
  List checkMKa = [];
  List checkDKa = [];
  List checkGKa = [];*/
  TabController _tab;
  Map mrs = {'id': '', 'money': '', 'name': ''};
  Map gw = {'id': '', 'money': '', 'name': ''};
  Map dz = {'id': '', 'money': '', 'name': ''};
  List needMrs = [];
  List needGw = [];
  List needDz = [];
  Map mrs2 = {'id': '', 'money': '', 'name': ''};
  Map gw2 = {'id': '', 'money': '', 'name': ''};
  Map dz2 = {'id': '', 'money': '', 'name': ''};
  List needMrs2 = [];
  List needGw2 = [];
  List needDz2 = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('提成录入'),
          actions: <Widget>[
            CupertinoButton(
                child: Text(
                  '取消提成',
                  style: TextStyle(color: c1),
                ),
                onPressed: ()async {
                  if(await showAlert(context, '取消后可到【业绩核对-消费未提成业绩】查看')){
                    back(context);
                  }
                })
          ],
          bottom: PreferredSize(
              child: TabBar(
                controller: _tab,
                tabs: [
                  Tab(
                    text: '普通提成',
                  ),
                  Tab(
                    text: '固定提成',
                  ),
                ],
                indicatorSize: TabBarIndicatorSize.label,
              ),
              preferredSize: Size(getRange(context), 50)),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
            child: MyButton(
              title: '提成录入',
              onPressed: () {
                sub();
              },
            ),
          ),
        ),
        body: TabBarView(controller: _tab, children: [
          ListView(
            children: <Widget>[
              Container(
                color: bg2,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          color: bg2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '可用消费提成金额',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '¥$total',
                                style: TextStyle(fontSize: 16, color: c1),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: bg,
                          height: 10,
                        ),
                        total>0?Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.only(left: 10),
                              color: bg2,
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                '消费提成录入',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            _item(1, 1),
                            _item(1, 2),
                            _item(1, 3),
                            Container(
                              color: bg,
                              height: 10,
                            ),
                          ],
                        ):Offstage()
                      ],
                    ),
                    acCardTotal>0?Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          color: bg2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '可用卡扣提成金额',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '¥$acCardTotal',
                                style: TextStyle(fontSize: 16, color: c1),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: bg,
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 10),
                          color: bg2,
                          alignment: Alignment.centerLeft,
                          height: 50,
                          child: Text(
                            '卡扣提成录入',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        _item(2, 1),
                        _item(2, 2),
                        _item(2, 3),
                      ],
                    ):Offstage(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '注：填完比例后，点击添加',
                        style: TextStyle(color: textColor, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            color: bg2,
            alignment: Alignment.center,
            child: Text('开发中')/*ListView(
              children: <Widget>[
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  color: bg2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '可用消费提成金额',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '¥1800.00',
                        style: TextStyle(fontSize: 16, color: c1),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: bg,
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 10),
                  color: bg2,
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Text(
                    '消费提成录入',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                *//*_item(),
                _item(),
                _item(),*//*
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '注：填完比例后，点击添加',
                    style: TextStyle(color: textColor, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                  child: MyButton(
                    onPressed: () {},
                    title: '提成录入',
                  ),
                ),
              ],
            )*/,
          )
        ]),
      ),
      length: 2,
    );
  }

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
    getSj();
  }

  void getSj() async {
    Map<String, dynamic> data = {};
    if(widget.type=='supp'){
      data = {
        'arrears_id': widget.aid,
        'supp': widget.id,
        'type': widget.type,
      };
    }else{
      data = {
        'order': widget.id,
        'type': widget.type,
      };
    }print(d);
    var rs = await get('save_commission', data: data);//print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          d = rs['res']['d'];
          m = rs['res']['m'];
          g = rs['res']['g'];
          if(widget.type!='supp'){
            printType = rs['res']['print_type'];
            acCardTotal = double.parse(rs['res']['ac_card_total'].toString());
          }
          total = double.parse(rs['res']['total'].toString());
        });
      }
    }
    if (widget.type!='supp'&&printType == 1) {
      if (await showAlert(context, '是否需要打印消费单?')) {
        printOrder();
      }
    }
  }

  void printOrder() async {
    var rs = await post('consume_print', data: {'order': widget.id});
  }

  void getSj2() async {
    var rs = await get('change_percentage', data: {
      'oid': widget.id,
    });print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          d = rs['res']['d'];
          m = rs['res']['m'];
          g = rs['res']['g'];
          printType = rs['res']['print_type'];
          total = rs['res']['total'];
          acCardTotal = rs['res']['ac_card_total'];
        });
      }
    }
  }

  Widget _item(int m, n) {
    String name = '';
    List data2 = [];
    if (n == 1) {
      name = '美容师';
      data2 = this.m;
    } else if (n == 2) {
      name = '顾问';
      data2 = this.g;
    } else if (n == 3) {
      name = '店长';
      data2 = this.d;
    }
    Map now;
    List data;
    if (m == 1 && n == 1) {
      now = mrs;
      data = needMrs;
    } else if (m == 1 && n == 2) {
      now = gw;
      data = needGw;
    } else if (m == 1 && n == 3) {
      now = dz;
      data = needDz;
    } else if (m == 2 && n == 1) {
      now = mrs2;
      data = needMrs2;
    } else if (m == 2 && n == 2) {
      now = gw2;
      data = needGw2;
    } else if (m == 2 && n == 3) {
      now = dz2;
      data = needDz2;
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          color: bg2,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 40,
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Container(
                width: getRange(context) / 4,
                height: 35,
                padding: EdgeInsets.only(left: 8, right: 2),
                child: GestureDetector(
                  onTap: () {
                    if(data2.length>0){
                      setState(() {
                        now['id'] = data2[0]['id'];
                        now['name'] = data2[0]['name'];
                      });
                    }
                    showMyPicker(context, n, now);

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${now['name']}',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: textColor,
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: myColor(240, 241, 242)),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: myColor(240, 241, 242)),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (v) {
                    now['money'] = v;
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      suffix: Text(
                        '% ',
                        style: TextStyle(fontSize: 16),
                      ),
                      suffixStyle: TextStyle(color: textColor),
                      hintText: '请输入数字',
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none),
                ),
                width: getRange(context) / 4,
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: MyButton(
                  onPressed: () {
                    add(m, n);
                  },
                  height: 35,
                  title: '添加',
                  width: getRange(context) / 5,
                  color: c1,
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
        Column(
          children: data.map((v)=>_needWidget(v, m, n)).toList(),
        )
      ],
    );
  }

  Widget _needWidget(Map v, int m, n)=>Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 10),
        color: bg2,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 35,
              child: Text(
                '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: getRange(context) / 4,
              height: 35,
              padding: EdgeInsets.only(left: 8, right: 2),
              child: Text('${v['name']}'),
            ),
            Container(
              alignment: Alignment.center,
              width: getRange(context) / 4,
              height: 35,
              padding: EdgeInsets.only(left: 8, right: 2),
              child: Text('${v['money']}%'),
            ),
            GestureDetector(
              onTap: (){
                rm(v, m, n);
              },
              child: Container(
                width: getRange(context) / 4,
                height: 35,
                child: Icon(Icons.close),
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

  void add(int m, n) {
    Map now;
    List data;
    if (m == 1 && n == 1) {
      now = mrs;
      data = needMrs;
    } else if (m == 1 && n == 2) {
      now = gw;
      data = needGw;
    } else if (m == 1 && n == 3) {
      now = dz;
      data = needDz;
    } else if (m == 2 && n == 1) {
      now = mrs2;
      data = needMrs2;
    } else if (m == 2 && n == 2) {
      now = gw2;
      data = needGw2;
    } else if (m == 2 && n == 3) {
      now = dz2;
      data = needDz2;
    }
    if(now['money'].toString().length==0 || now['name'].toString().length==0){
      return;
    }
    for(var v in data) {
      if(now['id']==v['id']){
        return;
      }
    }
    data.add({'name': now['name'], 'id': now['id'], 'money': now['money']});
    setState(() {

    });
  }

  void rm(Map v, int m, n) {
    Map now;
    List data;
    if (m == 1 && n == 1) {
      now = mrs;
      data = needMrs;
    } else if (m == 1 && n == 2) {
      now = gw;
      data = needGw;
    } else if (m == 1 && n == 3) {
      now = dz;
      data = needDz;
    } else if (m == 2 && n == 1) {
      now = mrs2;
      data = needMrs2;
    } else if (m == 2 && n == 2) {
      now = gw2;
      data = needGw2;
    } else if (m == 2 && n == 3) {
      now = dz2;
      data = needDz2;
    }
    int i = 0;
    for(var x in data) {
      if(x['id']==v['id']){
        data.removeAt(i);
        setState(() {

        });
        return;
      }
      i++;
    }
  }

  void showMyPicker(BuildContext context, int t, Map now) async {
    List data;
    if (t == 1) {
      data = m;
    } else if (t == 2) {
      data = g;
    } else if (t == 3) {
      data = d;
    }
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: getRange(context, type: 2) / 3,
              child: CupertinoApp(
                home: CupertinoPicker(
                    useMagnifier: true,
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1.2,
                    onSelectedItemChanged: (v) {
                      now['name'] = data[v]['name'];
                      now['id'] = data[v]['id'];
                      setState(() {});
                    },
                    children: data
                        .map((v) => Center(child: Text(v['name'])))
                        .toList()),
              ),
            ));
  }

  void sub() async {
    Map<String, dynamic> data;
    if(widget.type=='supp'){
      data = {
        'raise_m': needMrs,
        'raise_g': needGw,
        'raise_d': needDz,
        'ka_raise_m': needMrs2,
        'ka_raise_g': needGw2,
        'ka_raise_d': needDz2,
        'supp': widget.id,
        'arrears_id': widget.aid,
        'type': widget.type,
      };
    }else{
      data = {
        'raise_m': needMrs,
        'raise_g': needGw,
        'raise_d': needDz,
        'ka_raise_m': needMrs2,
        'ka_raise_g': needGw2,
        'ka_raise_d': needDz2,
        'order': widget.id,
        'type': widget.type,
        'cost': 1,
      };
    }
    var rs = await post('save_commission', data: data);
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
  }
}
