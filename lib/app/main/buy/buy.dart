import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/pay.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyButton2.dart';
import 'package:myh_shop/widget/MyInput.dart';
import 'package:myh_shop/widget/MyInput3.dart';
import 'package:myh_shop/widget/card.dart';
import 'package:myh_shop/widget/item.dart';
import 'package:myh_shop/widget/plan.dart';
import 'package:flutter/cupertino.dart';

class Buy extends StatefulWidget {
  final int id;
  final int type;

  const Buy(this.id, {Key key, this.type = 1}) : super(key: key);

  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  List list;
  String title = '';
  bool zt = true;
  List car = [];
  StateSetter state;
  TextEditingController _disCon = TextEditingController(text: '');
  TextEditingController _priceCon = TextEditingController(text: '');
  bool loadState = false;
  String input = '';

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case 1:
        title = '产品购买';
        break;
      case 2:
        title = '套盒购买';
        break;
      case 3:
        title = '项目购买';
        break;
      case 4:
        title = '内衣购买';
        break;
      case 5:
        title = '卡项购买';
        break;
      case 6:
        title = '方案购买';
        break;
    }
    getGoods();
  }

  void getGoods() async {
    String m = '';
    if (widget.type == 1) {
      m = 'buygoods';
    } else if (widget.type == 2) {
      m = 'buyth';
    } else if (widget.type == 3) {
      m = 'buyitems';
    } else if (widget.type == 4) {
      m = 'wear_purchase';
    } else if (widget.type == 5) {
      m = 'buycard';
    } else if (widget.type == 6) {
      m = 'buyplan';
    }
    var rs = await get(m, data: {'id': widget.id});
    if (rs != null) {
      if (rs['code'] == 0) {
        for (var v in rs['data']) {
          if (widget.type == 4) {
            v['stock'] = v['sum'];
          } else if (widget.type == 5) {
            String s = '';
            if (v['card_type'] == 1) {
              s = '储值卡';
            } else if (v['card_type'] == 2) {
              s = '消费折扣卡';
            } else if (v['card_type'] == 3) {
              s = '全场折扣卡';
            }
            v['s'] = s;
          } else if (widget.type == 6) {
            dynamic d = v['detail'];
            List l = [];
            if (d != null) {
              if (d is Map) {
                d.forEach((k, v) {
                  l.add(v);
                });
                v['detail'] = l;
              }
            }
            v['price'] = v['sale'];
          }
          v['sum'] = 0;
        }
        list = rs['data'];
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(title),
        actions: <Widget>[
          /*IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: c1,
              ),
              onPressed: () {

              })*/
        ],
        bottom: PreferredSize(
            child: Container(
              child: MyInput(
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
                hintText: '输入名称搜索',
                onChanged: (v) {
                  setState(() {
                    input = v;
                  });
                },
              ),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            ),
            preferredSize: Size(getRange(context), 50)),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Builder(
                    builder: (BuildContext c) => GestureDetector(
                          onTap: () {
                            showModel(c);
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                '合计：',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '¥${getTotal().toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: c1,
                                    fontSize: 16),
                              ),
                              Icon(Icons.keyboard_arrow_up)
                            ],
                          ),
                        )),
              ),
              Container(
                width: 100,
                child: MyButton(
                  onPressed: () {
                    if (!loadState) {
                      //jump2(context, Pay(1));
                      buy();
                    }
                  },
                  load: loadState,
                  title: '确认购买',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        //margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: list != null
                  ? ListView.builder(
                      padding:
                          EdgeInsets.only(bottom: getRange(context, type: 4)),
                      itemBuilder: (c, i) => _item(c, i),
                      itemCount: list.length,
                    )
                  : Center(
                      child: loading(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void showModel(BuildContext c) {
    showBottomSheet(
        context: c,
        builder: (_) => StatefulBuilder(builder: (_, state) {
              this.state = state;
              return Container(
                child: Scaffold(
                  backgroundColor: bg2,
                  appBar: MyAppBar(
                    title: Text('购物车'),
                    leading: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          back(context);
                        }),
                    elevation: 0.3,
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () async {
                            var ok = await showAlert(context, '是否清空购物车？');
                            if (ok) {
                              car = [];
                              for (var v in list) {
                                v['sum'] = 0;
                              }
                              setState(() {});
                              state(() {});
                            }
                          })
                    ],
                  ),
                  body: car.length == 0
                      ? Center(
                          child: Text('请选择商品'),
                        )
                      : ListView.builder(
                          itemBuilder: (c, i) => _item2(c, i, state),
                          itemCount: car.length,
                        ),
                ),
                height: 300,
              );
            }));
    /*showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Container(
              margin: EdgeInsets.only(
                  top: getRange(context, type: 2) / 2, bottom: 0),
              child: Scaffold(
                backgroundColor: bg2,
                appBar: MyAppBar(
                  title: Text('购物车'),
                  leading: Offstage(),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          back(context);
                        })
                  ],
                ),
                body: Container(),
              ),
            ));*/
  }

  Column _item2(BuildContext c, int i, StateSetter state) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.only(left: 0, right: 10),
          leading: Container(
            width: getRange(context) * 3 / 4,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    '${car[i]['name']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  width: 120,
                ),
                priceWidget(
                    '${car[i]['t'] == 2 ? 0 : double.parse(car[i]['price'].toString()).toStringAsFixed(2)}'),
              ],
            ),
          ),
          trailing: Container(
            width: getRange(context) / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MyButton2(
                  icon: Icons.remove,
                  color: c1,
                  onPress: () {
                    for (var v in list) {
                      if (v['id'] == car[i]['id']) {
                        v['sum']--;
                        break;
                      }
                    }
                    if (car[i]['sum'] == 1) {
                      car.removeAt(i);
                    } else {
                      car[i]['sum']--;
                    }
                    state(() {});
                    setState(() {});
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    '${car[i]['sum']}',
                    style: TextStyle(color: textColor, fontSize: 18),
                  ),
                ),
                MyButton2(
                  icon: Icons.add,
                  onPress: () {
                    for (var v in list) {
                      if (v['id'] == car[i]['id']) {
                        v['sum']++;
                        break;
                      }
                    }
                    car[i]['sum']++;
                    state(() {});
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 50,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '优惠方式',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showDis(i);
                      car[i]['t'] = 1;
                      state(() {});
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          getImg(car[i]['t'] == 1 ? 'radio_yes' : 'radio_no'),
                          height: 20,
                          color: car[i]['t'] == 1 ? c1 : textColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('打折',
                              style: TextStyle(
                                  color: car[i]['t'] == 1 ? c1 : textColor,
                                  fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                  /*car[i]['free'] == 1
                      ? */
                  GestureDetector(
                          onTap: () {
                            car[i]['t'] = 2;
                            state(() {});
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                getImg(car[i]['t'] == 2
                                    ? 'radio_yes'
                                    : 'radio_no'),
                                height: 20,
                                color: car[i]['t'] == 2 ? c1 : textColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('赠送',
                                    style: TextStyle(
                                        color:
                                            car[i]['t'] == 2 ? c1 : textColor,
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
//                      : Offstage(),
                  car[i]['times'] != null
                      ? Row(
                          children: <Widget>[
                            Text(
                              '次数',
                              style: TextStyle(fontSize: 16),
                            ),
                            Container(
                              child: MyInput3(
                                controller: car[i]['times'],
                                showBottomLine: true,
                                keyboardType: TextInputType.numberWithOptions(),
                              ),
                              width: 70,
                            ),
                          ],
                        )
                      : Offstage(),
                ],
              ))
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  void showDis(int i) async {
    Map d = car[i];
    _priceCon.text =
        (double.parse(d['price'].toString()) * int.parse(d['sum'].toString()))
            .toStringAsFixed(2);
    _disCon.text = d['dis'].toString();
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('打折'),
              content: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      controller: _disCon,
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (v) {
                        String dis = _disCon.text;
                        String price = _priceCon.text;
                        if (price.length == 0) {
                          _priceCon.text = d['price'].toString();
                        }
                        if (dis.length > 0) {
                          double rs = double.parse(dis) /
                              10 *
                              double.parse(d['price'].toString());

                          _priceCon.text = rs.toStringAsFixed(2);
                        } else {
                          _priceCon.text = double.parse(d['price'].toString())
                              .toStringAsFixed(2);
                        }
                      },
                      prefix: Text('打折'),
                      suffix: Text('折'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CupertinoTextField(
                      controller: _priceCon,
                      onChanged: (v) {
                        _disCon.text = 10.toString();
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      prefix: Text('折后'),
                      suffix: Text('元'),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('取消'),
                  onPressed: () {
                    back(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('确定'),
                  onPressed: () {
                    if (_disCon.text.length == 0 ||
                        _priceCon.text.length == 0) {
                      return tip(context, '请输入折扣和价格');
                    }
                    double dis = double.parse(_disCon.text);
                    double price = double.parse(_priceCon.text) /
                        double.parse(car[i]['sum'].toString());
                    car[i]['dis'] = dis;
                    car[i]['price'] = price.toStringAsFixed(2);
                    state(() {});
                    back(context);
                  },
                )
              ],
            ));
  }

  void change(Map v) {
    if (car.length > 0) {
      for (var x in car) {
        if (x['id'] == v['id']) {
          if (v['sum'] == 0) {
            int y = 0;
            for (var z in car) {
              if (z['id'] == v['id']) {
                car.removeAt(y);
                break;
              }
              y++;
            }
          }
          x['sum'] = v['sum'];
          if (state != null) {
            try {
              state(() {});
            } catch (e) {}
          }
          return;
        }
      }
    }
    Map d = {
      'name': getName(widget.type, v),
      'price': v['price'],
      'dis': 10,
      'sum': v['sum'],
      't': 0,
      'id': v['id'],
      'free': v['free'],
    };
    if (widget.type == 2 || widget.type == 3) {
      d['times'] = TextEditingController(
          text: widget.type == 2
              ? v['times'].toString()
              : v['frequency'].toString());
    }
    car.add(d);
    if (state != null) {
      try {
        state(() {});
      } catch (e) {}
    }
  }

  Widget _item(BuildContext context, int i) {
    if (widget.type == 1) {
      if (input.length > 0) {
        if (list[i]['goods_name']
                .toString()
                .toLowerCase()
                .indexOf(input.toLowerCase()) <
            0) {
          return Offstage();
        }
      }
      return Item(
        list[i],
        widget.type,
        onChanged: (v) {
          change(v);
          setState(() {

          });
        },
      );
    }
    if (widget.type == 2) {
      if (input.length > 0) {
        if (list[i]['box_name']
                .toString()
                .toLowerCase()
                .indexOf(input.toLowerCase()) <
            0) {
          return Offstage();
        }
      }
      return Item(
        list[i],
        widget.type,
        onChanged: (v) {
          change(v);
          setState(() {

          });
        },
      );
    }
    if (widget.type == 3) {
      if (input.length > 0) {
        if (list[i]['pro_name']
                .toString()
                .toLowerCase()
                .indexOf(input.toLowerCase()) <
            0) {
          return Offstage();
        }
      }
      return Item(
        list[i],
        widget.type,
        onChanged: (v) {
          change(v);
          setState(() {

          });
        },
      );
    }
    if (widget.type == 4) {
      if (input.length > 0) {
        if (list[i]['name']
                .toString()
                .toLowerCase()
                .indexOf(input.toLowerCase()) <
            0) {
          return Offstage();
        }
      }
      return Item(
        list[i],
        widget.type,
        onChanged: (v) {
          change(v);
          setState(() {

          });
        },
      );
    }
    if (widget.type == 5) {
      if (input.length > 0) {
        if (list[i]['card_name']
                .toString()
                .toLowerCase()
                .indexOf(input.toLowerCase()) <
            0) {
          return Offstage();
        }
      }
      return CardItem(
        list[i],
        onChanged: (v) {
          change(v);
          setState(() {

          });
        },
      );
    }
    if (widget.type == 6) {
      if (input.length > 0) {
        if (list[i]['name']
                .toString()
                .toLowerCase()
                .indexOf(input.toLowerCase()) <
            0) {
          return Offstage();
        }
      }
      return PlanItem(
        list[i],
        onChanged: (v) {
          change(v);
          setState(() {

          });
        },
      );
    }
    return Offstage();
  }

  double getTotal() {
    double rs = 0;
    for (var v in car) {
      if (v['t'] != 2) {
        rs += v['sum'] * double.parse(v['price'].toString());
      }
    }
    return rs;
  }

  void buy() async {
    if (car.length == 0) {
      return tip(context, '请选择商品');
    }
    List data = [];
    for (var v in car) {
      Map d = {
        'price': v['t'] == 2
            ? 0
            : double.parse(v['price'].toString()) *
                int.parse(v['sum'].toString()),
        'id': v['id'],
        'name': v['name'],
        'sum': v['sum'],
        'p_dis_t' + v['id'].toString(): v['dis'],
      };
      if (widget.type == 2 || widget.type == 3) {
        d['times'] = v['times'].text;
      }
      data.add(d);
    }
    setState(() {
      loadState = true;
    });
    String m = 'buygoods';
    if (widget.type == 2) {
      m = 'buyth';
    } else if (widget.type == 3) {
      m = 'buyitems';
    } else if (widget.type == 4) {
      m = 'buyWear';
    } else if (widget.type == 5) {
      m = 'buycard';
    } else if (widget.type == 6) {
      m = 'buyplan';
    }
    var rs = await post(m, data: {'type': 1, 'data': data, 'id': widget.id});
    setState(() {
      loadState = false;
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        /*jump2(
            context,
            Pay(int.parse(rs['res']['orderId'].toString()),
                int.parse(rs['res']['arrearsRes'].toString())));*/
        getWare();
        getManage();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => Pay(int.parse(rs['res']['orderId'].toString()),
                    int.parse(rs['res']['arrearsRes'].toString()))));
      }
    }
  }
}
