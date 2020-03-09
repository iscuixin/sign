import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyButton2.dart';
import 'package:myh_shop/widget/MyInput.dart';
import 'package:myh_shop/widget/MyRadio.dart';

class ConsumptionEntry extends StatefulWidget {
  final int id;
  final int arrId;

  const ConsumptionEntry(
    this.id,
    this.arrId, {
    Key key,
  }) : super(key: key);

  @override
  _ConsumptionEntryState createState() => _ConsumptionEntryState();
}

class _ConsumptionEntryState extends State<ConsumptionEntry>
    with TickerProviderStateMixin {
  int sg_type = 1;
  bool zt = false;
  bool boxZt = false;
  bool planZt = false;
  bool amountZt = false;
  List box = [];
  List items = [];
  List plan = [];
  List staff = [];
  List storeItems = [];
  List m = [];
  List j = [];
  List g = [];
  List d = [];
  List card = [];
  String balance = '0';
  List arr = [];
  Map now;
  String input = '';
  String price;
  List sArr = [];
  List mArr = [];
  List gArr = [];
  List dArr = [];
  List kaMArr = [];
  List kaGArr = [];
  List kaDArr = [];
  Map sArrOne = {'id': '', 'name': '', 'money': ''};
  Map mArrOne = {'id': '', 'name': '', 'money': ''};
  Map gArrOne = {'id': '', 'name': '', 'money': ''};
  Map dArrOne = {'id': '', 'name': '', 'money': ''};
  Map kaMArrOne = {'id': '', 'name': '', 'money': ''};
  Map kaGArrOne = {'id': '', 'name': '', 'money': ''};
  Map kaDArrOne = {'id': '', 'name': '', 'money': ''};

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('getDetails', data: {'mid': widget.id});
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          box = rs['back']['boxArr'];
          if (box.length > 0) {
            for (var v in box) {
              v['check_num'] = 0;
            }
          }
          items = rs['back']['itemsArr'];
          if (items.length > 0) {
            for (var v in items) {
              v['check_num'] = 0;
            }
          }
          plan = rs['back']['planArr'];
          if (plan.length > 0) {
            for (var v in plan) {
              v['check_num'] = 0;
            }
          }
          staff = rs['back']['staff'];
          storeItems = rs['back']['store_items'];
          if (storeItems.length > 0) {
            for (var v in storeItems) {
              v['check_num'] = 0;
            }
          }
          m = rs['back']['m'];
          j = rs['back']['j'];
          g = rs['back']['g'];
          d = rs['back']['d'];
          card = rs['back']['card'];
          balance = rs['back']['balance'].toString();
          arr.add({'name': '会员余额', 'amount': balance, 'id': 0});
          for (var v in card) {
            arr.add(v);
          }
          now = arr[0];
        });
      }
    }
  }

  List<Widget> xmWidget(int t) {
    List<Widget> list = [];
    int i = 0;
    for (var v in items) {
      list.add(_items(i, t: t));
      i++;
    }
    return list;
  }

  List<Widget> boxWidget(int t) {
    List<Widget> list = [];
    int i = 0;
    for (var v in box) {
      list.add(_items(i, t: t));
      i++;
    }
    return list;
  }

  List<Widget> planWidget(int t) {
    List<Widget> list = [];
    int i = 0;
    for (var v in plan) {
      list.add(_items(i, t: t));
      i++;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('消耗录入'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
          child: MyButton(
            title: '提成录入',
            onPressed: () async {
              var ok = await showAlert(context, '是否确认消耗录入？');
              if (ok) {
                sub();
              }
            },
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            color: bg2,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('会员自有项目(${items.length})'),
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    setState(() {
                      zt = !zt;
                    });
                  },
                ),
                AnimatedSize(
                  duration: Duration(milliseconds: 200),
                  vsync: this,
                  child: SizedBox(
                    height: zt
                        ? double.parse((80 * xmWidget(1).length).toString())
                        : 0,
                    child: Column(
                      children: xmWidget(1),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 10),
              color: bg2,
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      setState(() {
                        boxZt = !boxZt;
                      });
                    },
                    title: Text('会员自有套盒(${box.length})'),
                    contentPadding: EdgeInsets.only(left: 10, right: 10),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  AnimatedSize(
                    duration: Duration(milliseconds: 200),
                    vsync: this,
                    child: SizedBox(
                      height: boxZt
                          ? double.parse((80 * boxWidget(2).length).toString())
                          : 0,
                      child: Column(
                        children: boxWidget(2),
                      ),
                    ),
                  )
                ],
              )),
          Container(
              margin: EdgeInsets.only(bottom: 10),
              color: bg2,
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      setState(() {
                        planZt = !planZt;
                      });
                    },
                    title: Text('会员自有方案(${plan.length})'),
                    contentPadding: EdgeInsets.only(left: 10, right: 10),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  AnimatedSize(
                    duration: Duration(milliseconds: 200),
                    vsync: this,
                    child: SizedBox(
                      height: planZt
                          ? double.parse((80 * planWidget(3).length).toString())
                          : 0,
                      child: Column(
                        children: planWidget(3),
                      ),
                    ),
                  )
                ],
              )),
          Container(
              margin: EdgeInsets.only(bottom: 10),
              color: bg2,
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      setState(() {
                        amountZt = !amountZt;
                      });
                    },
                    title: GestureDetector(
                      onTap: () {
                        showMyPicker(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            now != null
                                ? now['name'].toString() +
                                    ' ' +
                                    now['amount'].toString()
                                : '',
                            style: TextStyle(color: c1),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: c1,
                          ),
                        ],
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10, right: 10),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  AnimatedSize(
                    duration: Duration(milliseconds: 200),
                    vsync: this,
                    child: SizedBox(
                      height: amountZt
                          ? double.parse(
                              (80 * storeItems.length + 60).toString())
                          : 0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: tableBg,
                            padding: const EdgeInsets.all(10.0),
                            child: MyInput(
                              prefixIcon: Icon(
                                Icons.search,
                                color: textColor,
                              ),
                              fillColor: bg,
                              hintText: '输入名称查找',
                              onChanged: (v) {
                                setState(() {
                                  input = v;
                                });
                              },
                            ),
                          ),
                          Column(
                            children: _storeWidget(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  width: getRange(context),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.bottomLeft,
                  color: bg2,
                  child: Row(
                    children: <Widget>[
                    Text(
                    '手工录入',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  MyRadio(
                  onChanged: (v) {
                    setState(() {
                    sg_type = v;
                    });
                    },
                      value: sg_type,
                      text: '百分比',
                      text2: '金额',
                    ),
                            ],
                  )

                ),
                _item(1, 1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  width: getRange(context),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.bottomLeft,
                  color: bg2,
                  child: Text(
                    '消费提成录入',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                _item(1, 2),
                _item(2, 3),
                _item(3, 4),
                Container(
                  color: bg2,
                  width: getRange(context),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '注：填完比例后，点击添加',
                    style: TextStyle(color: textColor, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          isShowKa()?Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  width: getRange(context),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.bottomLeft,
                  color: bg2,
                  child: Text(
                    '卡扣提成录入',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                _item(1, 5),
                _item(2, 6),
                _item(3, 7),
                Container(
                  color: bg2,
                  width: getRange(context),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '注：填完比例后，点击添加',
                    style: TextStyle(color: textColor, fontSize: 15),
                  ),
                ),
              ],
            ),
          ):Offstage(),
        ],
      ),
    );
  }

  bool isShowKa() {
    if(now!=null&&now['id'] == 0){
      return false;
    }
    for(var v in storeItems) {
      if(v['check_num']>0){
        return true;
      }
    }
    return false;
  }

  List<Widget> _storeWidget() {
    List<Widget> l = [];
    for (var v in storeItems) {
      l.add(_items2(v));
    }
    return l;
  }

  Widget _items(int i, {int t = 1}) {
    List data;
    if (t == 1) {
      data = items;
    } else if (t == 2) {
      data = box;
    } else if (t == 3) {
      data = plan;
    }
    return Column(
      children: <Widget>[
        Container(
          color: tableBg,
          height: 80,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  '${data[i]['name']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                        text: TextSpan(
//                              text: '余额：',
                            children: [
                          TextSpan(
                              text: '¥',
                              style: TextStyle(color: c1, fontSize: 13)),
                          TextSpan(
                              text: '${data[i]['price']}',
                              style: TextStyle(color: c1, fontSize: 16)),
                        ],
                            style: TextStyle(
                              color: textColor,
                            ))),
                  ),
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: '次数：',
                            children: [
                              TextSpan(
                                  text:
                                      '${data[i]['current_num']}/${data[i]['originally_num']}',
                                  style: TextStyle(color: Colors.black))
                            ],
                            style: TextStyle(
                              color: textColor,
                            ))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          MyButton2(
                            icon: Icons.remove,
                            color: data[i]['check_num'] > 0 ? c1 : disColor,
                            onPress: () {
                              if (data[i]['check_num'] > 0) {
                                data[i]['check_num']--;
                                setState(() {});
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              '${data[i]['check_num']}',
                              style: TextStyle(color: textColor, fontSize: 18),
                            ),
                          ),
                          MyButton2(
                            icon: Icons.add,
                            onPress: () {
                              if (data[i]['current_num'] >
                                  data[i]['check_num']) {
                                data[i]['check_num']++;
                                setState(() {});
                              }
                            },
                          ),
                          //IconButton(icon: Icon(Icons.add), onPressed: (){}),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  Widget _items2(Map v) {
    if (input.length > 0) {
      if (v['pro_name'].toString().toLowerCase().indexOf(input.toLowerCase()) <
          0) {
        return Offstage();
      }
    }
    return Column(
      children: <Widget>[
        Container(
          color: tableBg,
          height: 80,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  '${v['pro_name']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            children: [
                          TextSpan(
                              text: '¥',
                              style: TextStyle(color: c1, fontSize: 13)),
                          TextSpan(
                              text: '${v['price']}',
                              style: TextStyle(color: c1, fontSize: 16)),
                        ],
                            style: TextStyle(
                              color: textColor,
                            ))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          MyButton2(
                            icon: Icons.remove,
                            color: v['check_num'] > 0 ? c1 : disColor,
                            onPress: () {
                              if (v['check_num'] > 0) {
                                v['check_num']--;
                                setState(() {});
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              '${v['check_num']}',
                              style: TextStyle(color: textColor, fontSize: 18),
                            ),
                          ),
                          MyButton2(
                            icon: Icons.add,
                            onPress: () {
                              v['check_num']++;
                              setState(() {});
                            },
                          ),
                          //IconButton(icon: Icon(Icons.add), onPressed: (){}),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      editPrice(v);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '修改价格',
                        style: TextStyle(fontSize: 16, color: Colors.orange),
                      ),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  Widget _item(int t, num) {
    String name = '';
    if (t == 1) {
      name = '美容师';
    } else if (t == 2) {
      name = '顾问';
    } else if (t == 3) {
      name = '店长';
    }
    Map data = {};
    List check = [];
    if (num == 1) {
      data = sArrOne;
      check = sArr;
    }else if (num == 2) {
      data = mArrOne;
      check = mArr;
    }else if (num == 3) {
      data = gArrOne;
      check = gArr;
    }else if (num == 4) {
      data = dArrOne;
      check = dArr;
    }else if (num == 5) {
      data = kaMArrOne;
      check = kaMArr;
    }else if (num == 6) {
      data = kaGArrOne;
      check = kaGArr;
    }else if (num == 7) {
      data = kaDArrOne;
      check = kaDArr;
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
              GestureDetector(
                onTap: () {
                  surePeople(context, num);
                },
                child: Container(
                  width: getRange(context) / 4,
                  height: 35,
                  padding: EdgeInsets.only(left: 8, right: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          data['name'].length==0 ? '点击选择' : data['name'],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
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
                  decoration: BoxDecoration(
                      border: Border.all(color: myColor(240, 241, 242)),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: myColor(240, 241, 242)),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (v){
                    data['money'] = v;
                    setState(() {

                    });
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
                    if(data['name'].length>0&&data['money'].length>0) {
                      for(var v in check) {
                        if(v['id'] == data['id']){
                          return tip(context, '已存在');
                        }
                      }
                      /*if(data['name'].length==0 || data['money'].length==0){
                        return tip(context, '请输入内容');
                      }*/
                      check.add({'id': data['id'], 'money': data['money'], 'name': data['name']});
                      setState(() {

                      });
                    }
                  },
                  height: 35,
                  title: '添加',
                  width: getRange(context) / 5,
                  color: data['name'].length>0&&data['money'].length>0?c1:disColor,
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
        Column(
          children: check.map((v){
            return Container(
              color: disColor,
              alignment: Alignment.center,
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('name', style: TextStyle(color: Colors.transparent),)),
                  Expanded(child: Text(v['name'].toString())),
                  Expanded(child: Text('${v['money']}%')),
                  Expanded(child: GestureDetector(child: Icon(Icons.close), onTap: (){
                    int i = 0;
                    for(var x in check) {
                      if(x['id']==v['id']){
                        check.removeAt(i);
                        break;
                      }
                      i++;
                    }
                    setState(() {

                    });
                  },)),
                ],
              ),
            );
          }).toList(),
        )
      ],
    );
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
                        now = arr[v];
                      });
                    },
                    children: arr
                        .map((v) =>
                            Center(child: Text('${v['name']}(${v['amount']})')))
                        .toList()),
              ),
            ));
  }

  void editPrice(Map data) async {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('修改金额'),
              content: CupertinoTextField(
                keyboardType: TextInputType.numberWithOptions(),
                placeholder: '0.00',
                onChanged: (v) {
                  price = v;
                },
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('取消'),
                  onPressed: () {
                    price = null;
                    back(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('确定'),
                  onPressed: () {
                    data['price'] = price;
                    setState(() {});
                    back(context);
                  },
                ),
              ],
            ));
  }

  void surePeople(BuildContext context, int t) async {
    List data;
    if (t == 1) {
      data = staff;
    }else if(t==2){
      data = m;
    }else if(t==3){
      data = g;
    }else if(t==4){
      data = d;
    }else if(t==5){
      data = m;
    }else if(t==6){
      data = g;
    }else if(t==7){
      data = d;
    }
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: getRange(context, type: 2) / 3,
              child: CupertinoApp(
                home: data.length==0?Center(child: Text('请添加该人员'),):CupertinoPicker(
                    useMagnifier: true,
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1.2,
                    onSelectedItemChanged: (v) {
                      if (t == 1) {
                        sArrOne['id'] = data[v]['id'];
                        sArrOne['name'] = data[v]['name'];
                      }else if (t == 2) {
                        mArrOne['id'] = data[v]['id'];
                        mArrOne['name'] = data[v]['name'];
                      }else if (t == 3) {
                        gArrOne['id'] = data[v]['id'];
                        gArrOne['name'] = data[v]['name'];
                      }else if (t == 4) {
                        dArrOne['id'] = data[v]['id'];
                        dArrOne['name'] = data[v]['name'];
                      }else if (t == 5) {
                        kaMArrOne['id'] = data[v]['id'];
                        kaMArrOne['name'] = data[v]['name'];
                      }else if (t == 6) {
                        kaGArrOne['id'] = data[v]['id'];
                        kaGArrOne['name'] = data[v]['name'];
                      }else if (t == 7) {
                        kaDArrOne['id'] = data[v]['id'];
                        kaDArrOne['name'] = data[v]['name'];
                      }
                      setState(() {});
                    },
                    children: data
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }

  void sub() async {
    var rs = await post('ConsumeEntry', data: {
      'm': mArr,
      'g': gArr,
      'd': dArr,
      's': sArr,
      'ka_m': kaMArr,
      'ka_g': kaGArr,
      'ka_d': kaDArr,
      'mid': widget.id,
      'arr': widget.arrId,
      'c_b': now['id'] == 0 ? 1 : 2,
      'consume_card': now['id'] == 0 ? 0 : now['id'],
      'amount_items': storeItems,
      'plan': plan,
      'box': box,
      'items': items,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }
}
