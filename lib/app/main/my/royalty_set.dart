import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput3.dart';
import 'package:flutter/cupertino.dart';

class RoyaltySet extends StatefulWidget {
  final int id;
  final dynamic type;

  const RoyaltySet(
    this.id,
    this.type, {
    Key key,
  }) : super(key: key);

  @override
  _RoyaltySetState createState() => _RoyaltySetState();
}

class _RoyaltySetState extends State<RoyaltySet> {
  Map data;
  Map cp = {
    'method': 1,
    'isAdd': false,
    'conf': [],
    'rate': TextEditingController(text: ''),
  };
  Map box = {
    'method': 1,
    'isAdd': false,
    'conf': [],
    'rate': TextEditingController(text: ''),
  };
  Map xhBox = {
    'method': 1,
    'isAdd': false,
    'conf': [],
    'rate': TextEditingController(text: ''),
  };
  Map items = {
    'method': 1,
    'isAdd': false,
    'conf': [],
    'rate': TextEditingController(text: ''),
  };
  Map xhItems = {
    'method': 1,
    'isAdd': false,
    'conf': [],
    'rate': TextEditingController(text: ''),
  };
  Map plan = {
    'method': 1,
    'isAdd': false,
    'conf': [],
    'rate': TextEditingController(text: ''),
  };
  Map card = {
    'method': 1,
    'isAdd': false,
    'conf': [],
    'rate': TextEditingController(text: ''),
  };
  Map kk = {
    'method': 1,
    'isAdd': false,
    'isAddXh': false,
    'conf': [],
    'rate': TextEditingController(text: ''),
  };
  String oneData = '';
  String twoData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('提成方案设置'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 30),
          child: MyButton(
            onPressed: () {
              saveData();
            },
            title: '确认设置',
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _item('产品提成', 1),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _item2('套盒提成', 2),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _item2('疗程项目', 4),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _item('方案提成', 6),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _item('售卡提成', 7),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _item3('卡扣提成'),
          ),
        ],
      ),
    );
  }

  Widget _item(String title, int t) {
    Map data;
    if (t == 1) {
      data = cp;
    } else if (t == 6) {
      data = plan;
    } else if (t == 7) {
      data = card;
    }
    return Container(
      color: bg2,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(
              '消费提成',
              style: TextStyle(fontSize: 15),
            ),
            alignment: Alignment.centerLeft,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          data['method'] = 1;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            getImg(
                                data['method'] == 1 ? 'radio_yes' : 'radio_no'),
                            height: 20,
                            color: data['method'] == 1 ? c1 : textColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Row(
                                children: <Widget>[
                                  Text('按提成数',
                                      style: TextStyle(
                                          color: data['method'] == 1
                                              ? c1
                                              : textColor,
                                          fontSize: 16)),
                                  Container(
                                    child: MyInput3(
                                      onPressed: () {
                                        setState(() {
                                          data['method'] = 1;
                                        });
                                      },
                                      controller: data['rate'],
                                      showBottomLine: true,
                                    ),
                                    width: 50,
                                  ),
                                  Text('%',
                                      style: TextStyle(
                                          color: data['method'] == 1
                                              ? c1
                                              : textColor,
                                          fontSize: 16))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            data['isAdd'] = !data['isAdd'];
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              getImg(data['isAdd'] ? 'radio_yes' : 'radio_no'),
                              height: 20,
                              color: data['isAdd'] ? c1 : textColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('业绩叠加',
                                  style: TextStyle(
                                      color: data['isAdd'] ? c1 : textColor,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          data['method'] = 2;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            getImg(
                                data['method'] == 2 ? 'radio_yes' : 'radio_no'),
                            height: 20,
                            color: data['method'] == 2 ? c1 : textColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('业绩提成',
                                style: TextStyle(
                                    color: data['method'] == 2 ? c1 : textColor,
                                    fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //cp['conf'].add({''});
                        setState(() {
                          data['method'] = 2;
                        });
                        show(t);
                      },
                      child: Text(
                        '添加',
                        style: TextStyle(fontSize: 16, color: c1),
                      ),
                    )
                  ],
                ),
                listWidget(t),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column listWidget(int t) {
    List<Widget> list = [];
    int i = 0;
    if (t == 1) {
      if (cp['conf'].length > 0) {
        for (var v in cp['conf']) {
          list.add(two(v['money'], v['raise'], t, i));
          i++;
        }
      }
    } else if (t == 2) {
      if (box['conf'].length > 0) {
        for (var v in box['conf']) {
          list.add(two(v['money'], v['raise'], t, i));
          i++;
        }
      }
    } else if (t == 3) {
      if (xhBox['conf'].length > 0) {
        for (var v in xhBox['conf']) {
          list.add(two(v['money'], v['raise'], t, i));
          i++;
        }
      }
    } else if (t == 4) {
      if (items['conf'].length > 0) {
        for (var v in items['conf']) {
          list.add(two(v['money'], v['raise'], t, i));
          i++;
        }
      }
    } else if (t == 5) {
      if (xhItems['conf'].length > 0) {
        for (var v in xhItems['conf']) {
          list.add(two(v['money'], v['raise'], t, i));
          i++;
        }
      }
    } else if (t == 6) {
      if (plan['conf'].length > 0) {
        for (var v in plan['conf']) {
          list.add(two(v['money'], v['raise'], t, i));
          i++;
        }
      }
    } else if (t == 7) {
      if (card['conf'].length > 0) {
        for (var v in card['conf']) {
          list.add(two(v['money'], v['raise'], t, i));
          i++;
        }
      }
    } else if (t == 8) {
      if (kk['conf'].length > 0) {
        for (var v in kk['conf']) {
          list.add(two(v['money'], v['raise'], t, i));
          i++;
        }
      }
    }
    return Column(
      children: list,
    );
  }

  Widget _item3(String title) => Container(
        color: bg2,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            kk['method'] = 1;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              getImg(
                                  kk['method'] == 1 ? 'radio_yes' : 'radio_no'),
                              height: 20,
                              color: kk['method'] == 1 ? c1 : textColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text('按提成数',
                                      style: TextStyle(
                                          color: kk['method'] == 1
                                              ? c1
                                              : textColor,
                                          fontSize: 16)),
                                  Container(
                                    child: MyInput3(
                                      controller: kk['rate'],
                                      onPressed: () {
                                        setState(() {
                                          kk['method'] = 1;
                                        });
                                      },
                                      showBottomLine: true,
                                    ),
                                    width: 50,
                                  ),
                                  Text('%',
                                      style: TextStyle(
                                          color: kk['method'] == 1
                                              ? c1
                                              : textColor,
                                          fontSize: 16))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  kk['isAdd'] = !kk['isAdd'];
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    getImg(
                                        kk['isAdd'] ? 'radio_yes' : 'radio_no'),
                                    height: 20,
                                    color: kk['isAdd'] ? c1 : textColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('消费业绩叠加',
                                        style: TextStyle(
                                            color: kk['isAdd'] ? c1 : textColor,
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  kk['isAddXh'] = !kk['isAddXh'];
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    getImg(kk['isAddXh']
                                        ? 'radio_yes'
                                        : 'radio_no'),
                                    height: 20,
                                    color: kk['isAddXh'] ? c1 : textColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('消耗业绩叠加',
                                        style: TextStyle(
                                            color:
                                                kk['isAddXh'] ? c1 : textColor,
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            kk['method'] = 2;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              getImg(
                                  kk['method'] == 2 ? 'radio_yes' : 'radio_no'),
                              height: 20,
                              color: kk['method'] == 2 ? c1 : textColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('业绩提成',
                                  style: TextStyle(
                                      color: kk['method'] == 2 ? c1 : textColor,
                                      fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          kk['method'] = 2;
                          setState(() {});
                          show(8);
                        },
                        child: Text(
                          '添加',
                          style: TextStyle(fontSize: 16, color: c1),
                        ),
                      ),
                    ],
                  ),
                  listWidget(8),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _item2(String title, int t) {
    Map data;
    Map data2;
    if (t == 2) {
      data = box;
      data2 = xhBox;
    } else if (t == 4) {
      data = items;
      data2 = xhItems;
    }
    return Container(
      color: bg2,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Divider(),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  '消费提成',
                  style: TextStyle(fontSize: 15),
                ),
                alignment: Alignment.centerLeft,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              data['method'] = 1;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                getImg(data['method'] == 1
                                    ? 'radio_yes'
                                    : 'radio_no'),
                                height: 20,
                                color: c1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text('按提成数',
                                        style: TextStyle(
                                            color: data['method'] == 1
                                                ? c1
                                                : textColor,
                                            fontSize: 16)),
                                    Container(
                                      child: MyInput3(
                                        onPressed: () {
                                          setState(() {
                                            data['method'] = 1;
                                          });
                                        },
                                        controller: data['rate'],
                                        showBottomLine: true,
                                      ),
                                      width: 50,
                                    ),
                                    Text('%',
                                        style: TextStyle(
                                            color: data['method'] == 1
                                                ? c1
                                                : textColor,
                                            fontSize: 16))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                data['isAdd'] = !data['isAdd'];
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  getImg(
                                      data['isAdd'] ? 'radio_yes' : 'radio_no'),
                                  height: 20,
                                  color: data['isAdd'] ? c1 : textColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('业绩叠加',
                                      style: TextStyle(
                                          color: data['isAdd'] ? c1 : textColor,
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              data['method'] = 2;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                getImg(data['method'] == 2
                                    ? 'radio_yes'
                                    : 'radio_no'),
                                height: 20,
                                color: data['method'] == 2 ? c1 : textColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('业绩提成',
                                    style: TextStyle(
                                        color: data['method'] == 2
                                            ? c1
                                            : textColor,
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              data['method'] = 2;
                            });
                            show(t);
                          },
                          child: Text(
                            '添加',
                            style: TextStyle(fontSize: 16, color: c1),
                          ),
                        ),
                      ],
                    ),
                    listWidget(t),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  '消耗提成',
                  style: TextStyle(fontSize: 15),
                ),
                alignment: Alignment.centerLeft,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              data2['method'] = 1;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                getImg(data2['method'] == 1
                                    ? 'radio_yes'
                                    : 'radio_no'),
                                height: 20,
                                color: c1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text('按提成数',
                                        style:
                                            TextStyle(color: c1, fontSize: 16)),
                                    Container(
                                      child: MyInput3(
                                        controller: data2['rate'],
                                        onPressed: () {
                                          setState(() {
                                            data2['method'] = 1;
                                          });
                                        },
                                        showBottomLine: true,
                                      ),
                                      width: 50,
                                    ),
                                    Text('%',
                                        style: TextStyle(
                                            color: data2['method'] == 1
                                                ? c1
                                                : textColor,
                                            fontSize: 16))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                data2['isAdd'] = !data2['isAdd'];
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  getImg(data2['isAdd']
                                      ? 'radio_yes'
                                      : 'radio_no'),
                                  height: 20,
                                  color: textColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('业绩叠加',
                                      style: TextStyle(
                                          color:
                                              data2['isAdd'] ? c1 : textColor,
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              data2['method'] = 2;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                getImg(data2['method'] == 2
                                    ? 'radio_yes'
                                    : 'radio_no'),
                                height: 20,
                                color: data2['method'] == 2 ? c1 : textColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('业绩提成',
                                    style: TextStyle(
                                        color: data2['method'] == 2
                                            ? c1
                                            : textColor,
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //cp['conf'].add({''});
                            setState(() {
                              data2['method'] = 2;
                            });
                            show(t + 1);
                          },
                          child: Text(
                            '添加',
                            style: TextStyle(fontSize: 16, color: c1),
                          ),
                        )
                      ],
                    ),
                    listWidget(t + 1),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget two(one, two, int t, int i) => Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
                text: TextSpan(
                    text: '达标',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                  TextSpan(text: ' $one ', style: TextStyle(color: c1)),
                  TextSpan(text: '元，', style: TextStyle()),
                  TextSpan(text: '提成 ', style: TextStyle()),
                  TextSpan(text: ' $two% ', style: TextStyle(color: c1)),
                ])),
            GestureDetector(
              onTap: () {
                if (t == 1) {
                  List rs = cp['conf'];
                  rs.removeAt(i);
                } else if (t == 2) {
                  List rs = box['conf'];
                  rs.removeAt(i);
                } else if (t == 3) {
                  List rs = xhBox['conf'];
                  rs.removeAt(i);
                } else if (t == 4) {
                  List rs = items['conf'];
                  rs.removeAt(i);
                } else if (t == 5) {
                  List rs = xhItems['conf'];
                  rs.removeAt(i);
                } else if (t == 6) {
                  List rs = plan['conf'];
                  rs.removeAt(i);
                } else if (t == 7) {
                  List rs = card['conf'];
                  rs.removeAt(i);
                } else if (t == 8) {
                  List rs = kk['conf'];
                  rs.removeAt(i);
                }
                setState(() {});
              },
              child: Icon(
                Icons.close,
                size: 20,
              ),
            )
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    if (widget.type != 2) {
      getSj();
    }
  }

  void getSj() async {
    var rs = await post('raise_edit_details', data: {
      'staff': widget.id,
    });
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          data = rs['res'];
          cp['method'] = data['product_enough'] == '' ? 1 : 2;
          cp['rate'].text = data['product_raise'].toString();
          cp['conf'] =
              data['product_enough'] == '' ? [] : data['product_enough'];
          cp['isAdd'] = data['cp_xf_state'] == 0 ? false : true;

          box['method'] = data['box_xf_enough'] == '' ? 1 : 2;
          box['rate'].text = data['box_xf_raise'].toString();
          box['conf'] =
              data['box_xf_enough'] == '' ? [] : data['box_xf_enough'];
          box['isAdd'] = data['box_xf_state'] == 0 ? false : true;

          xhBox['method'] = data['box_xh_enough'] == '' ? 1 : 2;
          xhBox['rate'].text = data['box_xh_raise'].toString();
          xhBox['conf'] =
              data['box_xh_enough'] == '' ? [] : data['box_xh_enough'];
          xhBox['isAdd'] = data['box_xh_state'] == 0 ? false : true;

          items['method'] = data['project_xf_enough'] == '' ? 1 : 2;
          items['rate'].text = data['project_xf_raise'].toString();
          items['conf'] =
              data['project_xf_enough'] == '' ? [] : data['project_xf_enough'];
          items['isAdd'] = data['items_xf_state'] == 0 ? false : true;

          xhItems['method'] = data['project_xh_enough'] == '' ? 1 : 2;
          xhItems['rate'].text = data['project_xh_raise'].toString();
          xhItems['conf'] =
              data['project_xh_enough'] == '' ? [] : data['project_xh_enough'];
          xhItems['isAdd'] = data['items_xh_state'] == 0 ? false : true;

          plan['method'] = data['plan_xf_enough'] == '' ? 1 : 2;
          plan['rate'].text = data['plan_xf_raise'].toString();
          plan['conf'] =
              data['plan_xf_enough'] == '' ? [] : data['plan_xf_enough'];
          plan['isAdd'] = data['plan_xf_state'] == 0 ? false : true;

          card['method'] = data['sell_card_enough'] == '' ? 1 : 2;
          card['rate'].text = data['sell_card_raise'].toString();
          card['conf'] =
              data['sell_card_enough'] == '' ? [] : data['sell_card_enough'];
          card['isAdd'] = data['card_xf_state'] == 0 ? false : true;

          kk['method'] = data['use_card_xh_enough'] == '' ? 1 : 2;
          kk['rate'].text = data['use_card_xh_raise'].toString();
          kk['conf'] = data['use_card_xh_enough'] == ''
              ? []
              : data['use_card_xh_enough'];
          kk['isAdd'] = data['kk_xf_state'] == 0 ? false : true;
          kk['isAddXh'] = data['kk_xh_state'] == 0 ? false : true;
        });
      }
    }
  }

  void show(int t) async {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('添加业绩提成'),
              content: Material(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('达标', style: TextStyle(color: c1, fontSize: 16)),
                        Container(
                          child: MyInput3(
                            onChanged: (v) {
                              oneData = v;
                            },
                            keyboardType: TextInputType.numberWithOptions(),
                            showBottomLine: true,
                          ),
                          width: 50,
                        ),
                        Text('元', style: TextStyle(color: c1, fontSize: 16))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('提成', style: TextStyle(color: c1, fontSize: 16)),
                        Container(
                          child: MyInput3(
                            onChanged: (v) {
                              twoData = v;
                            },
                            keyboardType: TextInputType.numberWithOptions(),
                            showBottomLine: true,
                          ),
                          width: 50,
                        ),
                        Text('%', style: TextStyle(color: c1, fontSize: 16))
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('取消'),
                  onPressed: () {
                    oneData = '';
                    twoData = '';
                    back(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('确定'),
                  onPressed: () {
                    if (oneData.length > 0 && twoData.length > 0) {
                      if (t == 1) {
                        //产品
                        cp['conf'].add({'money': oneData, 'raise': twoData});
                      } else if (t == 2) {
                        box['conf'].add({'money': oneData, 'raise': twoData});
                      } else if (t == 3) {
                        xhBox['conf'].add({'money': oneData, 'raise': twoData});
                      } else if (t == 4) {
                        items['conf'].add({'money': oneData, 'raise': twoData});
                      } else if (t == 5) {
                        xhItems['conf']
                            .add({'money': oneData, 'raise': twoData});
                      } else if (t == 6) {
                        plan['conf'].add({'money': oneData, 'raise': twoData});
                      } else if (t == 7) {
                        card['conf'].add({'money': oneData, 'raise': twoData});
                      } else if (t == 8) {
                        kk['conf'].add({'money': oneData, 'raise': twoData});
                      }
                      oneData = '';
                      twoData = '';
                      setState(() {});
                      back(context);
                    }
                  },
                )
              ],
            ));
  }

  void saveData() async {
    var rs = await post('StaffRaise', data: {
      'data': {
        'product_type': cp['method'],
        'product_raise': cp['rate'].text,
        'product_enough': cp['conf'],
        'box_xf_type': box['method'],
        'box_xf_raise': box['rate'].text,
        'box_xf_enough': box['conf'],
        'box_xh_type': xhBox['method'],
        'box_xh_raise': xhBox['rate'].text,
        'box_xh_enough': xhBox['conf'],
        'project_xf_type': items['method'],
        'project_xf_raise': items['rate'].text,
        'project_xf_enough': items['conf'],
        'project_xh_type': items['method'],
        'project_xh_raise': items['rate'].text,
        'project_xh_enough': items['conf'],
        'card_type': card['method'],
        'card_raise': card['rate'].text,
        'card_enough': card['conf'],
        'card_use_xh_type': kk['method'],
        'card_use_xh_raise': kk['rate'].text,
        'card_use_xh_enough': kk['conf'],
        'plan_xf_type': plan['method'],
        'plan_xf_raise': plan['rate'].text,
        'plan_xf_enough': plan['conf'],
      },
      'staff': widget.id,
      'state': {
        'box_xf_state': box['isAdd'] ? 1 : 0,
        'box_xh_state': xhBox['isAdd'] ? 1 : 0,
        'items_xf_state': items['isAdd'] ? 1 : 0,
        'items_xh_state': xhItems['isAdd'] ? 1 : 0,
        'plan_xf_state': plan['isAdd'] ? 1 : 0,
        'card_xf_state': card['isAdd'] ? 1 : 0,
        'kk_xf_state': kk['isAdd'] ? 1 : 0,
        'kk_xh_state': kk['isAddXh'] ? 1 : 0,
        'cp_xf_state': cp['isAdd'] ? 1 : 0,
      },
    });
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }
}
