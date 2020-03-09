import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyButton2.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyInput3.dart';

class AddPlan extends StatefulWidget {
  @override
  _AddPlanState createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  List cp = [];
  List box = [];
  List items = [];
  List car = [];
  String name = '';
  String sale = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('add_plan');
    if (rs != null) {
      for (var v in rs['data']['goods']) {
        v['needNum'] = 0;
      }
      for (var v in rs['data']['project']) {
        v['needNum'] = 0;
      }
      for (var v in rs['data']['box']) {
        v['needNum'] = 0;
      }
      setState(() {
        cp = rs['data']['goods'];
        items = rs['data']['project'];
        box = rs['data']['box'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('新增方案'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: ListTile(
              title: Text('项目'),
              trailing: CupertinoButton(
                  padding: EdgeInsets.only(left: 10, right: 0),
                  child: Text('添加'),
                  onPressed: () {
                    showModel(1);
                  }),
            ),
            color: bg2,
          ),
          Column(
            children: car.map((v) {
              if (v['type'] == '项目') {
                return _item2(v);
              }
              return Offstage();
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ListTile(
              title: Text('套盒'),
              trailing: CupertinoButton(
                child: Text('添加'),
                onPressed: () {
                  showModel(2);
                },
                padding: EdgeInsets.only(left: 10, right: 0),
              ),
            ),
            color: bg2,
          ),
          Column(
            children: car.map((v) {
              if (v['type'] == '套盒') {
                return _item2(v);
              }
              return Offstage();
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ListTile(
              title: Text('产品'),
              trailing: CupertinoButton(
                child: Text('添加'),
                onPressed: () {
                  showModel(3);
                },
                padding: EdgeInsets.only(left: 10, right: 0),
              ),
            ),
            color: bg2,
          ),
          Column(
            children: car.map((v) {
              if (v['type'] == '产品') {
                return _item2(v);
              }
              return Offstage();
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                MyInput2(
                  label: '方案名称',
                  onChanged: (v) {
                    name = v;
                  },
                  hintText: '请填写方案名称',
                  showBottomLine: false,
                ),
                Divider(
                  height: 0,
                ),
                MyInput2(
                  label: '价$kg格',
                  onChanged: (v) {
                    setState(() {
                      sale = v;
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: '请填写方案价格',
                  showBottomLine: false,
                ),
              ],
            ),
            color: bg2,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                MyInput2(
                  enabled: false,
                  hintStyle: TextStyle(color: Colors.black),
                  label: '应收金额',
                  hintText: '¥${ys()}',
                  showBottomLine: false,
                ),
                Divider(
                  height: 0,
                ),
                MyInput2(
                  enabled: false,
                  hintStyle: TextStyle(color: Colors.black),
                  label: '实收金额',
                  hintText: '¥${ss()}',
                  showBottomLine: false,
                ),
              ],
            ),
            color: bg2,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
          height: 50,
          child: MyButton(
            onPressed: () {
              save();
            },
            title: '确定添加',
          ),
        ),
      ),
    );
  }

  Widget _item2(Map v) => Column(
        children: <Widget>[
          Divider(
            height: 0,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: getRange(context),
            color: bg2,
            child: Wrap(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(child: Text(v['name'])),
                                Expanded(
                                  child: Text(
                                    '次数：${v['times']}',
                                    style: TextStyle(color: textColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(child: priceWidget('${v['price']}')),
                                Expanded(
                                  child: Text(
                                    '期限：是',
                                    style: TextStyle(color: Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              int t = 1;
                              if (v['type'] == '项目') {
                                t = 1;
                              } else if (v['type'] == '套盒') {
                                t = 2;
                              } else if (v['type'] == '产品') {
                                t = 3;
                              }
                              rm(t, v['id']);
                            },
                            child: Text(
                              '删除',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('优惠方式'),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              v['yh'] = 1;
                              v['new_price'].text = v['price'].toString();
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                getImg(v['yh'] == 1 ? 'radio_yes' : 'radio_no'),
                                height: 20,
                                color: v['yh'] == 1 ? c1 : textColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('打折',
                                    style: TextStyle(
                                        color: v['yh'] == 1 ? c1 : textColor,
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              v['yh'] = 2;
                              v['new_price'].text = 0.toString();
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                getImg(v['yh'] == 2 ? 'radio_yes' : 'radio_no'),
                                height: 20,
                                color: v['yh'] == 2 ? c1 : textColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('赠送',
                                    style: TextStyle(
                                        color: v['yh'] == 2 ? c1 : textColor,
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                        Offstage(
                          offstage: v['type'] == '产品' ? true : false,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                v['change'] = !v['change'];
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  getImg(
                                      v['change'] ? 'radio_yes' : 'radio_no'),
                                  height: 20,
                                  color: v['change'] ? c1 : textColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('修改次数',
                                      style: TextStyle(
                                          color: v['change'] ? c1 : textColor,
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Offstage(
                      child: inputWidget('折扣', '折', v, 1),
                      offstage: v['yh'] == 1 ? false : true,
                    ),
                    Offstage(
                      child: inputWidget('折后', '元', v, 2),
                      offstage: v['yh'] == 1 ? false : true,
                    ),
                    Offstage(
                      child: inputWidget('次数', '次', v, 3),
                      offstage: v['change'] ? false : true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );

  void showModel(int type) {
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (c, state) => Container(
                  margin: EdgeInsets.only(
                      top: getRange(context, type: 2) / 8,
                      bottom: getRange(context, type: 2) / 8,
                      left: 15,
                      right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Scaffold(
                      appBar: MyAppBar(
                        title: Text(
                            type == 1 ? '选择项目' : type == 2 ? '选择套盒' : '选择产品'),
                        leading: Offstage(),
                        actions: <Widget>[
                          IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                back(context);
                              })
                        ],
                      ),
                      /*bottomNavigationBar: BottomAppBar(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 30, right: 30, top: 5, bottom: 5),
                      height: 50,
                      child: MyButton(
                        onPressed: () {},
                        title: '确定',
                      ),
                    ),
                  ),*/
                      body: ListView.builder(
                        itemBuilder: (_, i) => _item(i, type, state),
                        itemCount: type == 1
                            ? items.length
                            : type == 2 ? box.length : cp.length,
                      ),
                    ),
                  ),
                )));
  }

  Widget _item(int i, int type, StateSetter state) {
    String name = '';
    String time = '';
    String price = '';
    int id = 0;
    int needNum = 0;
    Map data;
    if (type == 1) {
      data = items[i];
      name = data['pro_name'];
      id = data['id'];
      needNum = data['needNum'];
      price = data['price'].toString();
      time = data['frequency'].toString();
    } else if (type == 2) {
      data = box[i];
      id = data['id'];
      name = data['box_name'];
      needNum = data['needNum'];
      price = data['price'].toString();
      time = data['times'].toString();
    } else if (type == 3) {
      data = cp[i];
      id = data['id'];
      name = data['goods_name'];
      needNum = data['needNum'];
      price = data['price'].toString();
      time = data['stock'].toString();
    }
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Container(
              width: getRange(context)-70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text((type == 3 ? '库存：' : '次数：') + time),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        priceWidget(price),
                        Text(
                          '期限：',
                          style: TextStyle(color: Colors.transparent),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          MyButton2(
                            icon: Icons.remove,
                            color: needNum > 0 ? c1 : myColor(204, 205, 206),
                            onPress: () {
                              if (needNum > 0) {
                                rm(type, id);
                                state(() {});
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              '$needNum',
                              style: TextStyle(color: textColor, fontSize: 18),
                            ),
                          ),
                          MyButton2(
                            icon: Icons.add,
                            onPress: () {
                              add(type, name, price, id, time);
                              state(() {});
                            },
                          ),
                          //IconButton(icon: Icon(Icons.add), onPressed: (){}),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ),
      color: bg2,
    );
  }

  void add(int type, String n, String p, int id, String time) {
    String t = '';
    if (type == 1) {
      t = '项目';
      for (var v in items) {
        if (id == v['id']) {
          v['needNum']++;
          break;
        }
      }
    }
    if (type == 2) {
      t = '套盒';
      for (var v in box) {
        if (id == v['id']) {
          v['needNum']++;
          break;
        }
      }
    }
    if (type == 3) {
      t = '产品';
      for (var v in cp) {
        if (id == v['id']) {
          v['needNum']++;
          break;
        }
      }
    }

    car.add({
      'price': p,
      'id': id,
      'name': n,
      'type': t,
      'times': time,
      'yh': 0,
      'new_price': TextEditingController(text: p.toString()),
      'new_times': TextEditingController(text: time.toString()),
      'change': false,
      'dis': TextEditingController(text: ''),
    });
    setState(() {});
  }

  void rm(int type, int id) {
    String t = '';
    if (type == 1) {
      t = '项目';
      for (var v in items) {
        if (id == v['id']) {
          v['needNum']--;
          break;
        }
      }
    }
    if (type == 2) {
      t = '套盒';
      for (var v in box) {
        if (id == v['id']) {
          v['needNum']--;
          break;
        }
      }
    }
    if (type == 3) {
      t = '产品';
      for (var v in cp) {
        if (id == v['id']) {
          v['needNum']--;
          break;
        }
      }
    }
    int i = 0;
    for (var v in car) {
      if (v['id'] == id && t == v['type']) {
        car.removeAt(i);
        setState(() {});
        return;
      }
      i++;
    }
  }

  void save() async {
    if (name.length == 0 || sale.length == 0) {
      return tip(context, '请输入名称和价格');
    }
    if (car.length == 0) {
      return tip(context, '请先添加项目，套盒或产品');
    }
    List l = [];
    for(var v in car) {
      l.add({
        'price': v['new_price'].text.length==0?v['price']:v['new_price'].text,
        'id': v['id'],
        'name': v['name'],
        'type': v['type'],
        'times': v['new_times'].text.length==0?v['times']:v['new_times'].text,
      });
    }
    var rs = await post('add_plan', data: {
      'data': l,
      'name': name,
      'sale': sale,
    });
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  Widget inputWidget(String name, name2, Map data, int type) {
    TextEditingController controller;
    if (type == 1) {
      controller = data['dis'];
    } else if (type == 2) {
      controller = data['new_price'];
    } else if (type == 3) {
      controller = data['new_times'];
    }
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: TextField(
            onChanged: (v) {
              if (type == 1) {
                if (v.length == 0) {
                  data['new_price'].text = data['price'].toString();
                  return;
                }
                data['new_price'].text =
                    (double.parse(data['price'].toString()) *
                        double.parse(v.toString()) /
                        10)
                        .toString();
              } else if (type == 2) {
                data['dis'].text = '';
                //data['new_price'].text = v;
              }
              setState(() {

              });
            },
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              prefixIcon: Container(
                child: Text(name),
                width: 50,
                alignment: Alignment.centerLeft,
              ),
              suffixIcon: Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(name2),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
          ),
          height: 30,
          width: getRange(context),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  //应收
  double ys() {
    double total = 0;
    for(var v in car){
      total += double.parse(v['price'].toString());
    }
    return total;
  }

  //实收
  double ss() {
    double total = 0;
    if(sale.length==0) {
      for(var v in car) {
        if(v['new_price'].text.length>0) {
          total += double.parse(v['new_price'].text);
        }else{
          total += double.parse(v['price'].toString());
        }
      }
    }else{
      total = double.parse(sale);
    }
    return total;
  }
}
