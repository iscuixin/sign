import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';
import 'package:myh_shop/widget/MyRadio2.dart';
import 'package:myh_shop/widget/plan.dart';

class Entry extends StatefulWidget {
  final int id;

  const Entry(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  List type = [
    {'name': '余额', 'id': 3},
    {'name': '套盒', 'id': 1},
    {'name': '项目', 'id': 2},
    {'name': '卡项', 'id': 4},
    {'name': '方案', 'id': 5},
  ];
  Map now;
  int duration = 2;
  int cycle = 1;
  String begin;
  String end;
  String balance = '';
  String sendBalance = '';
  List box = [];
  List items = [];
  List card = [];
  List plan = [];
  Map nowGoods;
  String price = '';
  String arrearsMoney = '';
  String originallyNum = '';
  String currentNum = '';
  String fee = '';
  String days = '';
  String cAmount = '';
  String cDiscount = '';
  int cateId = 0;
  int cType = 1;
  List boxClass = [];
  List itemsClass = [];
  Map nowClassify;
  Map nowCard;

  @override
  void initState() {
    super.initState();
    now = type[0];
    getSj();
  }

  void getSj() async {
    var rs = await get('get_cate');
    if (rs != null) {
      setState(() {
        boxClass = rs['res']['box'];
        itemsClass = rs['res']['items'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('会员原始数据录入'),
      ),
      bottomNavigationBar: now['id']!=5?BottomAppBar(
        child: Container(
          alignment: Alignment.center,
          child: MyButton(
            onPressed: () {
              sub();
            },
            title: '确认录入',
          ),
          height: 50,
        ),
      ):Offstage(),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showMyPicker(context);
            },
            child: MyItem(
              child: Text(
                now['name'],
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              label: '类$kg型',
            ),
          ),
          now['id'] == 3
              ? Column(
                  children: <Widget>[
                    MyInput2(
                      onChanged: (v) {
                        balance = v;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      label: '原始余额',
                    ),
                    MyInput2(
                      onChanged: (v) {
                        sendBalance = v;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      label: '赠送余额',
                    ),
                  ],
                )
              : Offstage(),
          now['id'] == 1 || now['id'] == 2
              ? Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showName(context);
                      },
                      child: MyItem(
                        child: Text(
                          nowGoods == null
                              ? '请选择商品'
                              : now['id'] == 1
                                  ? nowGoods['box_name']
                                  : nowGoods['pro_name'],
                          style: TextStyle(
                              color:
                                  nowGoods == null ? hintColor : Colors.black,
                              fontSize: 16),
                        ),
                        label: '名$kg称',
                      ),
                    ),
                    MyInput2(
                      onChanged: (v) {
                        price = v;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      label: '价$kg格',
                    ),
                    MyInput2(
                      onChanged: (v) {
                        arrearsMoney = v;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      label: '欠$kg款',
                    ),
                    MyInput2(
                      onChanged: (v) {
                        originallyNum = v;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      label: '原有次数',
                    ),
                    MyInput2(
                      onChanged: (v) {
                        currentNum = v;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      label: '剩余次数',
                    ),
                    GestureDetector(
                      onTap: () {
                        showClassify(context);
                      },
                      child: MyItem(
                        child: Text(
                          nowClassify == null ? '请选择分类' : nowClassify['name'],
                          style: TextStyle(
                              color: nowClassify == null
                                  ? hintColor
                                  : Colors.black,
                              fontSize: 16),
                        ),
                        label: '所属类别',
                      ),
                    ),
                    MyInput2(
                      onChanged: (v) {
                        fee = v;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      label: '手工费',
                    ),
                    MyItem(
                        label: '护理周期',
                        child: MyRadio2(
                          value: cycle,
                          onChanged: (v) {
                            cycle = v;
                          },
                          widget: Text('每周一次'),
                          widget2: Row(
                            children: <Widget>[
                              Text('每'),
                              Container(
                                child: TextField(
                                  onChanged: (v) {
                                    days = v;
                                  },
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5)),
                                  textAlign: TextAlign.center,
                                ),
                                width: 30,
                                alignment: Alignment.center,
                              ),
                              Text('天1次')
                            ],
                          ),
                        )),
                    MyItem(
                        label: '期限范围',
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 15, right: 15),
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
                        )),
                  ],
                )
              : Offstage(),
          now['id'] == 4
              ? Column(
                  children: <Widget>[
                    MyItem(
                        label: '卡类型',
                        child: MyRadio(
                          text: '储值卡',
                          text2: '全场折扣卡',
                          onChanged: (v) {
                            cType = v;
                            setState(() {});
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        showName(context);
                      },
                      child: MyItem(
                        child: Text(
                          nowCard == null ? '请选择卡项' : nowCard['card_name'],
                          style: TextStyle(
                              color: nowCard == null ? hintColor : Colors.black,
                              fontSize: 16),
                        ),
                        label: '卡$kg名',
                      ),
                    ),
                    MyInput2(
                      onChanged: (v) {
                        cAmount = v;
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      label: '额$kg度',
                    ),
                    cType == 2
                        ? MyInput2(
                            onChanged: (v) {
                              cDiscount = v;
                            },
                            keyboardType: TextInputType.numberWithOptions(),
                            label: '折$kg扣',
                          )
                        : Offstage(),
                  ],
                )
              : Offstage(),
          now['id'] == 1 || now['id'] == 2
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '注意：如果没有到期日期可不选择，则表示无使用期限',
                    style: TextStyle(color: textColor),
                  ),
                )
              : Offstage(),
          now['id'] == 5?Column(
            children: plan
                .map((v) => PlanItem(
                      v,
                      trailing: MyButton(
                        title: '录入',
                        width: 70,
                        height: 30,
                        onPressed: ()async{
                          if(await showAlert(context, '是否录入此方案?')){
                            sub(plan: v['id']);
                          }
                        },
                      ),
                    ))
                .toList(),
          ):Offstage()
        ],
      ),
    );
  }

  void sub({int plan = 0}) async {
    if (now['id'] == 3) {
      if (balance.length == 0 && sendBalance.length == 0) {
        return tip(context, '至少填一项');
      }
    } else if (now['id'] == 1) {
      if (price.length == 0 ||
          originallyNum.length == 0 ||
          currentNum.length == 0 ||
          fee.length == 0) {
        return tip(context, '请填完以上内容');
      }
      if (nowGoods == null || nowClassify == null) {
        return tip(context, '请选择商品和分类');
      }
      if (cycle == 2 && days.length == 0) {
        return tip(context, '请输入护理周期');
      }
    } else if (now['id'] == 4) {
      if (nowCard == null) {
        return tip(context, '请选择卡');
      }
      if (cType == 2 && cDiscount.length == 0) {
        return tip(context, '请输入折扣');
      }
    }
    var rs = await post('OldEntry', data: {
      'data': {
        'mid': widget.id,
        'cate_c': now['id'],
        'name': '',
        'price': price,
        'arrears_money': arrearsMoney,
        'originally_num': originallyNum,
        'current_num': currentNum,
        'cateId': nowClassify != null ? nowClassify['id'] : '',
        'fee': fee,
        'cycle': cycle,
        'start': begin,
        'end': end,
        'balance': balance,
        'send_balance': sendBalance,
        'c_name': '',
        'c_amount': cAmount,
        'c_discount': cDiscount,
        'c_type': cType == 1 ? 1 : 3,
        'card_name': now['id'] == 4 && nowCard != null ? nowCard['id'] : '',
        'box_name': now['id'] == 1 && nowGoods != null ? nowGoods['id'] : '',
        'item_name': now['id'] == 2 && nowGoods != null ? nowGoods['id'] : '',
        'plan_id': plan,
        'days': days,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg'], type: 2);
      }
    }
  }

  void showMyPicker(BuildContext context) async {
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
                      setState(() {
                        now = type[v];
                      });
                      if (now['id'] == 1 || now['id'] == 2 || now['id'] == 4 || now['id']==5) {
                        getGoods(now['id']);
                      }
                    },
                    children: type
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }

  void showName(BuildContext context) async {
    List data = [];
    if (now['id'] == 1) {
      data = box;
    } else if (now['id'] == 2) {
      data = items;
    } else if (now['id'] == 4) {
      data = card;
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
                      setState(() {
                        if (now['id'] == 4) {
                          nowCard = data[v];
                        } else {
                          nowGoods = data[v];
                        }
                      });
                    },
                    children: data
                        .map((v) => Center(
                            child: Text(
                                '${now['id'] == 1 ? v['box_name'] : now['id'] == 2 ? v['pro_name'] : v['card_name']}')))
                        .toList()),
              ),
            ));
  }

  void showClassify(BuildContext context) async {
    List data = [];
    if (now['id'] == 1) {
      data = boxClass;
    } else if (now['id'] == 2) {
      data = itemsClass;
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
                      setState(() {
                        nowClassify = data[v];
                      });
                    },
                    children: data
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }

  void getGoods(int id) async {
    int type = id == 4 ? 3 : id == 5 ? 4 : id;
    var rs = await post('check_entry_name', data: {
      'type': type,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        if (id == 1) {
          box = rs['res'];
        }else
        if (id == 2) {
          items = rs['res'];
        }else
        if (id == 4) {
          card = rs['res'];
        }else
        if (id == 5) {
          plan = rs['res'];
        }
        setState(() {});
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
      setState(() {});
    });
  }
}
