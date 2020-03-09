import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/royalty.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyInput3.dart';
import 'package:myh_shop/widget/MyItem.dart';

class Pay extends StatefulWidget {
  final int id;
  final int arrears;

  Pay(this.id, this.arrears);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  bool three = false;
  List cardList = [];
  List couponList = [];
  List g = [];
  List m = [];
  Map memberOne;
  Map orderDetail;
  bool zt = false;
  bool zt2 = false;
  bool zt3 = false;
  bool zt4 = false;
  bool zt5 = false;

  String card = '';
  String cashPay = '';
  String zfbPay = '';
  String wxPay = '';
  String dzdpPay = '';
  String mtPay = '';
  String sqbPay = '';
  String bankPay = '';
  String balancePay = '';
  String sendBalancePay = '';
  String integralPay = '';
  String integral = '';
  String sendIntegral = '';
  String cardPay = '';
  String sendMoney = '';
  String person = '';
  String coupon = '';
  Map nowCard;
  Map nowCoupon;
  double all = 0;
  double dis = 0;

  @override
  void initState() {
    super.initState();
    if (widget.arrears > 0) {
      getSj();
    } else {
      getSj2();
    }
  }

  void getSj() async {
    var rs = await get('get_pay_detail', data: {
      'order': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          cardList = rs['res']['cardList'];
          for (var v in rs['res']['couponList']) {
            v['zt'] = false;
          }
          couponList = rs['res']['couponList'];
          g = rs['res']['g'];
          m = rs['res']['m'];
          memberOne = rs['res']['member_one'];
          orderDetail = rs['res']['orderDetail'];
          nowCard = cardList[0];
          all = double.parse(orderDetail['price'].toString());
        });
      }
    }
  }

  void getSj2() async {
    var rs = await get('supp_detail', data: {
      'id': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          cardList = rs['detail']['card_list'];
          orderDetail = rs['detail'];
          if (cardList.length > 0) {
            nowCard = cardList[0];
          }
          all = double.parse(orderDetail['price'].toString());
        });
      }
    }
  }

  String getType() {
    if (orderDetail['type'] == 1) {
      return '产品';
    }
    if (orderDetail['type'] == 2) {
      return '套盒';
    }
    if (orderDetail['type'] == 3) {
      return '项目';
    }
    if (orderDetail['type'] == 4) {
      return '方案';
    }
    if (orderDetail['type'] == 5) {
      return '卡项';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    //print(cardList);
    return Scaffold(
      appBar: MyAppBar(
        title: Text('订单结算'),
      ),
      body: orderDetail != null
          ? ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '订单信息',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 15, top: 10),
                      ),
                      widget.arrears == 0
                          ? MyItem(
                              label: '品$kg项',
                              child: Text(getType().toString()),
                            )
                          : Offstage(),
                      MyItem(
                        label: '会$kg员',
                        child: Text(
                            '${widget.arrears == 0 ? orderDetail['name'] : memberOne['name']}'),
                      ),
                      MyItem(
                        label: widget.arrears == 0 ? '总金额' : '订单编号',
                        child: Text(
                            '${orderDetail[widget.arrears == 0 ? 'price' : 'sn']}'),
                      ),
                      MyItem(
                        label: widget.arrears == 0 ? '已支付' : '订单时间',
                        child: Text(
                            '${orderDetail[widget.arrears == 0 ? 'pay_money' : 'create_time']}'),
                      ),
                      MyItem(
                        label: widget.arrears == 0 ? '未结清' : '订单金额',
                        child: Text(
                            '¥${orderDetail[widget.arrears == 0 ? 'money' : 'price']}'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '支付方式',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 15, top: 10),
                      ),
                      widget.arrears == 0
                          ? Offstage()
                          : Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              setState(() {
                                zt5 = !zt5;
                              });
                            },
                            leading: Container(
                              width: getRange(context) / 2,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: c1,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '优惠券(${couponList.length})',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: AnimatedCrossFade(
                                firstChild: Icon(Icons.chevron_right),
                                secondChild:
                                Icon(Icons.keyboard_arrow_down),
                                crossFadeState: zt5
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 300)),
                          ),
                          Divider(
                            height: 0,
                          ),
                          AnimatedCrossFade(
                              firstChild: Offstage(),
                              secondChild: Container(
                                color: tableBg,
                                child: Wrap(
                                  children: couponList
                                      .map((v) => SizedBox(
                                    child: GestureDetector(
                                      onTap: () {
                                        for (var x
                                        in couponList) {
                                          if (v['id'] !=
                                              x['id']) {
                                            x['zt'] = false;
                                          }
                                        }
                                        v['zt'] = !v['zt'];
                                        setState(() {});
                                      },
                                      child: Card(
                                        color: v['zt'] ? c1 : bg2,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Text(
                                                      '优惠券',
                                                      style: TextStyle(
                                                          color: v['zt']
                                                              ? bg2
                                                              : Colors.black))),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <
                                                      Widget>[
                                                    Text(
                                                        v['coupon_type']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: v['zt']
                                                                ? bg2
                                                                : Colors.black)),
                                                    Text(
                                                      v['coupon_type'] ==
                                                          '满减'
                                                          ? '满${v['enough']}减${v['dedut']}'
                                                          : '抵扣${v['dedut']}元',
                                                      style: TextStyle(
                                                          color: v['zt']
                                                              ? bg2
                                                              : Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    width: getRange(context) / 2,
                                    height: 80,
                                  ))
                                      .toList(),
                                ),
                              ),
                              crossFadeState: zt5
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: Duration(milliseconds: 300)),
                        ],
                      ),
                      widget.arrears == 0
                          ? Offstage()
                          : Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              setState(() {
                                zt2 = !zt2;
                              });
                            },
                            leading: Container(
                              width: getRange(context) / 2,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: c1,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '积分抵扣',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: AnimatedCrossFade(
                                firstChild: Icon(Icons.chevron_right),
                                secondChild:
                                Icon(Icons.keyboard_arrow_down),
                                crossFadeState: zt2
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 300)),
                          ),
                          Divider(
                            height: 0,
                          ),
                          AnimatedCrossFade(
                              firstChild: Offstage(),
                              secondChild: Container(
                                color: bg2,
                                child: Column(
                                  children: <Widget>[
                                    /*MyInput2(
                                      label: '会员余额',
                                      enabled: false,
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: '${memberOne['balance']}元',
                                    ),*/
                                    MyInput2(
                                      label: '可用积分',
                                      enabled: false,
                                      hintStyle:
                                      TextStyle(color: Colors.black),
                                      hintText:
                                      '${memberOne['integral'] ?? 0}分',
                                    ),
                                    MyInput2(
                                      keyboardType: TextInputType
                                          .numberWithOptions(),
                                      label: '使用积分',
                                      onChanged: (v) {
                                        setState(() {
                                          integral = v;
                                        });
                                      },
                                      hintText: '0.00',
                                      suffixText: '分',
                                    ),
                                    MyInput2(
                                      onChanged: (v) {
                                        setState(() {
                                          integralPay = v;
                                        });
                                      },
                                      keyboardType: TextInputType
                                          .numberWithOptions(),
                                      label: '抵扣金额',
                                      hintText: '0.00',
                                      suffixText: '元',
                                    ),
                                  ],
                                ),
                              ),
                              crossFadeState: zt2
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: Duration(milliseconds: 300)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            leading: Container(
                              width: getRange(context) / 2,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: c1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '现金支付',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: Container(
                              margin: EdgeInsets.only(top: 8),
                              child: MyInput3(
                                keyboardType: TextInputType.numberWithOptions(),
                                onChanged: (v) {
                                  setState(() {
                                    cashPay = v;
                                  });
                                },
                                hintText: '请输入金额',
                              ),
                              width: getRange(context) / 3,
                            ),
                          ),
                          Divider(
                            height: 0,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              setState(() {
                                three = !three;
                              });
                            },
                            leading: Container(
                              width: getRange(context) / 2,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: c1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '第三方支付',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: AnimatedCrossFade(
                                firstChild: Icon(Icons.chevron_right),
                                secondChild: Icon(Icons.keyboard_arrow_down),
                                crossFadeState: three
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 300)),
                          ),
                          Divider(
                            height: 0,
                          ),
                          AnimatedCrossFade(
                              firstChild: Offstage(),
                              secondChild: Container(
                                color: tableBg,
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Container(
                                        width: getRange(context) / 2,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.account_balance_wallet,
                                              color: c1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                '支付宝',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: MyInput3(
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          onChanged: (v) {
                                            setState(() {
                                              zfbPay = v;
                                            });
                                          },
                                          hintText: '请输入金额',
                                          fillColor: tableBg,
                                        ),
                                        width: getRange(context) / 3,
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                    ListTile(
                                      leading: Container(
                                        width: getRange(context) / 2,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.account_balance_wallet,
                                              color: c1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                '微信支付',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: MyInput3(
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          onChanged: (v) {
                                            setState(() {
                                              wxPay = v;
                                            });
                                          },
                                          hintText: '请输入金额',
                                          fillColor: tableBg,
                                        ),
                                        width: getRange(context) / 3,
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                    ListTile(
                                      leading: Container(
                                        width: getRange(context) / 2,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.account_balance_wallet,
                                              color: c1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                'POS机',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: MyInput3(
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          onChanged: (v) {
                                            setState(() {
                                              bankPay = v;
                                            });
                                          },
                                          hintText: '请输入金额',
                                          fillColor: tableBg,
                                        ),
                                        width: getRange(context) / 3,
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                    ListTile(
                                      leading: Container(
                                        width: getRange(context) / 2,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.account_balance_wallet,
                                              color: c1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                '大众点评',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: MyInput3(
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          onChanged: (v) {
                                            setState(() {
                                              dzdpPay = v;
                                            });
                                          },
                                          hintText: '请输入金额',
                                          fillColor: tableBg,
                                        ),
                                        width: getRange(context) / 3,
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                    ListTile(
                                      leading: Container(
                                        width: getRange(context) / 2,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.account_balance_wallet,
                                              color: c1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                '收钱吧',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: MyInput3(
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          onChanged: (v) {
                                            setState(() {
                                              sqbPay = v;
                                            });
                                          },
                                          hintText: '请输入金额',
                                          fillColor: tableBg,
                                        ),
                                        width: getRange(context) / 3,
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                    ListTile(
                                      leading: Container(
                                        width: getRange(context) / 2,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.account_balance_wallet,
                                              color: c1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                '美团',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: Container(
                                        margin: EdgeInsets.only(top: 8),
                                        child: MyInput3(
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          onChanged: (v) {
                                            setState(() {
                                              mtPay = v;
                                            });
                                          },
                                          hintText: '请输入金额',
                                          fillColor: tableBg,
                                        ),
                                        width: getRange(context) / 3,
                                      ),
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                  ],
                                ),
                              ),
                              crossFadeState: three
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: Duration(milliseconds: 300)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              setState(() {
                                zt = !zt;
                              });
                            },
                            leading: Container(
                              width: getRange(context) / 2,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: c1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '余额抵扣',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: AnimatedCrossFade(
                                firstChild: Icon(Icons.chevron_right),
                                secondChild: Icon(Icons.keyboard_arrow_down),
                                crossFadeState: zt
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 300)),
                          ),
                          Divider(
                            height: 0,
                          ),
                          AnimatedCrossFade(
                              firstChild: Offstage(),
                              secondChild: Container(
                                color: bg2,
                                child: Column(
                                  children: <Widget>[
                                    MyInput2(
                                      label: '会员余额',
                                      enabled: false,
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText:
                                          '${widget.arrears == 0 ? orderDetail['balance'] : memberOne['balance'] ?? 0}元',
                                    ),
                                    widget.arrears == 0
                                        ? Offstage()
                                        : MyInput2(
                                            label: '会员赠额',
                                            enabled: false,
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            hintText:
                                                '${memberOne['send_balance'] ?? 0}元',
                                          ),
                                    MyInput2(
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      onChanged: (v) {
                                        setState(() {
                                          balancePay = v;
                                        });
                                      },
                                      label: '使用余额',
                                      hintText: '0.00',
                                      suffixText: '元',
                                    ),
                                    widget.arrears == 0
                                        ? Offstage()
                                        : MyInput2(
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            onChanged: (v) {
                                              setState(() {
                                                sendBalancePay = v;
                                              });
                                            },
                                            label: '使用赠额',
                                            hintText: '0.00',
                                            suffixText: '元',
                                          ),
                                  ],
                                ),
                              ),
                              crossFadeState: zt
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: Duration(milliseconds: 300)),
                        ],
                      ),

                      Column(
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              setState(() {
                                zt3 = !zt3;
                              });
                            },
                            leading: Container(
                              width: getRange(context) / 2,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: c1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '储值卡',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: AnimatedCrossFade(
                                firstChild: Icon(Icons.chevron_right),
                                secondChild: Icon(Icons.keyboard_arrow_down),
                                crossFadeState: zt3
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 300)),
                          ),
                          Divider(
                            height: 0,
                          ),
                          cardList.length > 0
                              ? AnimatedCrossFade(
                                  firstChild: Offstage(),
                                  secondChild: Container(
                                    color: bg2,
                                    child: Column(
                                      children: <Widget>[
                                        MyInput2(
                                          label: '卡类型',
                                          enabled: false,
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          hintText: nowCard['card_type'] == 1
                                              ? '储值卡'
                                              : nowCard['card_type'] == 2
                                                  ? '消费折扣卡'
                                                  : nowCard['card_type'] == 3
                                                      ? '全场折扣卡'
                                                      : '无',
                                        ),
                                        MyInput2(
                                          label: '卡内余额',
                                          enabled: false,
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          hintText:
                                              '${nowCard['amount'] ?? 0}元',
                                        ),
                                        nowCard['card_type'] == 3
                                            ? MyInput2(
                                                label: '卡折扣',
                                                enabled: false,
                                                hintStyle: TextStyle(
                                                    color: Colors.black),
                                                hintText:
                                                    '${double.parse(nowCard['discount'].toString()) * 10}折',
                                              )
                                            : Offstage(),
                                        GestureDetector(
                                          onTap: () {
                                            showMyPicker(context);
                                          },
                                          child: MyItem(
                                            child: Text(
                                              nowCard != null
                                                  ? nowCard['name']
                                                  : '',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            label: '可用卡项',
                                          ),
                                        ),
                                        MyInput2(
                                          onChanged: (v) {
                                            setState(() {
                                              cardPay = v;
                                            });
                                          },
                                          keyboardType:
                                              TextInputType.numberWithOptions(),
                                          label: '划扣金额',
                                          hintText: '0.00',
                                          suffixText: '元',
                                        ),
                                      ],
                                    ),
                                  ),
                                  crossFadeState: zt3
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: Duration(milliseconds: 300))
                              : Offstage(),
                        ],
                      ),
                      widget.arrears == 0
                          ? Offstage()
                          : Column(
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    setState(() {
                                      zt4 = !zt4;
                                    });
                                  },
                                  leading: Container(
                                    width: getRange(context) / 2,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.account_balance_wallet,
                                          color: c1,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            '赠送',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  trailing: AnimatedCrossFade(
                                      firstChild: Icon(Icons.chevron_right),
                                      secondChild:
                                          Icon(Icons.keyboard_arrow_down),
                                      crossFadeState: zt4
                                          ? CrossFadeState.showSecond
                                          : CrossFadeState.showFirst,
                                      duration: Duration(milliseconds: 300)),
                                ),
                                Divider(
                                  height: 0,
                                ),
                                AnimatedCrossFade(
                                    firstChild: Offstage(),
                                    secondChild: Container(
                                      color: bg2,
                                      child: Column(
                                        children: <Widget>[
                                          MyInput2(
                                            onChanged: (v) {
                                              setState(() {
                                                sendIntegral = v;
                                              });
                                            },
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            label: '赠送积分',
                                            hintText: '0.00',
                                            suffixText: '分',
                                          ),
                                          MyInput2(
                                            onChanged: (v) {
                                              setState(() {
                                                sendMoney = v;
                                              });
                                            },
                                            keyboardType: TextInputType
                                                .numberWithOptions(),
                                            label: '赠送余额',
                                            hintText: '0.00',
                                            suffixText: '元',
                                          ),
                                          MyInput2(
                                            label: '经手人',
                                            hintText: '请填写经手人',
                                            onChanged: (v) {
                                              setState(() {
                                                person = v;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    crossFadeState: zt4
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: Duration(milliseconds: 300)),
                              ],
                            ),

                    ],
                  ),
                ),
                widget.arrears == 0
                    ? Offstage()
                    : Container(
                        margin: EdgeInsets.only(top: 10),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Text(
                                    '剩余未支付',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  trailing: Text(
                                    '¥${noPay()}',
                                    style: TextStyle(color: c1, fontSize: 16),
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Text(
                                    '优惠券减免',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  trailing: Text(
                                    '-¥${couponPay()}',
                                    style: TextStyle(color: c1, fontSize: 16),
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Text(
                                    '积分抵扣',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  trailing: Text(
                                    '-¥${jf()}',
                                    style: TextStyle(color: c1, fontSize: 16),
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                )
                              ],
                            ),
                            /*Column(
                        children: <Widget>[
                          ListTile(
                            leading: Text(
                              '赠送金额',
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: Text(
                              '-¥100.00',
                              style: TextStyle(color: c1, fontSize: 16),
                            ),
                          ),
                          Divider(
                            height: 0,
                          )
                        ],
                      ),*/
                          ],
                        ),
                      ),
              ],
            )
          : Center(
              child: loading(),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                  text: TextSpan(
                      text: '合计：',
                      children: [
                        TextSpan(
                            text: '¥',
                            style: TextStyle(color: c1, fontSize: 13)),
                        TextSpan(
                            text: '${total()}',
                            style: TextStyle(color: c1, fontSize: 18)),
                      ],
                      style: TextStyle(
                        color: Colors.black,
                      ))),
              MyButton(
                onPressed: () async {
                  if (widget.arrears == 0) {
                    //jump2(context, Royalty(1));
                    supp();
                  } else {
                    if (double.parse(total()) <= 0) {
                      var ok = await showAlert(context, '未支付金额，将生成欠款订单?');
                      if(ok){
                        sub();
                      }else{

                      }
                    }else{
                      sub();
                    }

                  }

                },
                title: '结算',
                width: getRange(context) / 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sub() async {
    Map c;
    for (var v in couponList) {
      if (v['zt']) {
        c = v;
        break;
      }
    }
    if (integral.length > 0) {
      if (integralPay.length == 0) {
        return tip(context, '请输入抵扣金额');
      }
    }
    if (integralPay.length > 0) {
      if (integral.length == 0) {
        return tip(context, '请输入积分');
      }
    }
    /*print({
      'order': widget.id,
      'arrears': widget.arrears,
      'card': nowCard['id'],
      'cash_pay': cashPay,
      'zfb_pay': zfbPay,
      'wx_pay': wxPay,
      'dzdp_pay': dzdpPay,
      'mt_pay': mtPay,
      'sqb_pay': sqbPay,
      'bank_pay': bankPay,
      'balance_pay': balancePay,
      'send_balance_pay': sendBalancePay,
      'integral_pay': integralPay,
      'integral': integral,
      'send_integral': sendIntegral,
      'card_pay': cardPay,
      'send_money': sendMoney,
      'person': person,
      'coupon': c==null?'':c['id'],
    });return;*/
    var rs = await post('get_pay_detail', data: {
      'data': {
        'order': widget.id,
        'arrears': widget.arrears,
        'card': nowCard['id'],
        'cash_pay': cashPay,
        'zfb_pay': zfbPay,
        'wx_pay': wxPay,
        'dzdp_pay': dzdpPay,
        'mt_pay': mtPay,
        'sqb_pay': sqbPay,
        'bank_pay': bankPay,
        'balance_pay': balancePay,
        'send_balance_pay': sendBalancePay,
        'integral_pay': integralPay,
        'integral': integral,
        'send_integral': sendIntegral,
        'card_pay': nowCard['id'] != 0 ? cardPay : '',
        'send_money': sendMoney,
        'person': person,
        'coupon': c == null ? '' : c['id'],
      }
    });
    print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        //{code: 1, Msg: 支付完成，正在前往员工提成..., cost: 1}
//        jump2(context, Royalty(widget.id));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Royalty(widget.id)));
      }else if(rs['code'] == -2){
        jump(context, 'order');
      }else{
        tip(myContext, rs['error']);
      }
    }
  }

  void supp() async {
    if (double.parse(total()) <= 0.00) {
      return tip(context, '请输入支付金额');
    }
    var rs = await post('supp_detail', data: {
      'data': {
        'id': widget.id,
        'card_id': nowCard == null ? '' : nowCard['id'],
        'cash_pay': cashPay,
        'wx_pay': wxPay,
        'bank_pay': bankPay,
        'zfb_pay': zfbPay,
        'sqb_pay': sqbPay,
        'dzdp_pay': dzdpPay,
        'mt_pay': mtPay,
        'card_pay': cardPay,
        'balance_pay': balancePay,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        //{code: 1, Msg: 支付完成，正在前往员工提成..., cost: 1}
//        jump2(context, Royalty(widget.id));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => Royalty(
                      rs['supp'],
                      type: 'supp',
                      aid: int.parse(rs['re'].toString()),
                    )));
      }
    }
  }

  String noPay() {
    String no = '0';
    double t = all;
    if (nowCard != null && nowCard['id'] != 0) {
      double dis = double.parse(nowCard['discount'].toString());
      if (nowCard['card_type'] == 3) {
        t = all * dis;
      }
    }
    no = (t - double.parse(total())).toStringAsFixed(2);
    return no;
  }

  String couponPay() {
    String no = '0';
    for (var v in couponList) {
      if (v['zt']) {
        return v['dedut'].toString();
      }
    }
    return no;
  }

  String jf() {
    String no = '0';
    if (integralPay.length > 0 && integral.length > 0) {
      no = integralPay;
    }
    return no;
  }

  String total() {
    double cash = cashPay.length == 0 ? 0 : double.parse(cashPay);
    double zfb = zfbPay.length == 0 ? 0 : double.parse(zfbPay);
    double wx = wxPay.length == 0 ? 0 : double.parse(wxPay);
    double dz = dzdpPay.length == 0 ? 0 : double.parse(dzdpPay);
    double mt = mtPay.length == 0 ? 0 : double.parse(mtPay);
    double sqb = sqbPay.length == 0 ? 0 : double.parse(sqbPay);
    double bank = bankPay.length == 0 ? 0 : double.parse(bankPay);
    double balance = balancePay.length == 0 ? 0 : double.parse(balancePay);
    double send = sendBalancePay.length == 0 ? 0 : double.parse(sendBalancePay);
    double card = nowCard == null || nowCard['id'] == 0
        ? 0
        : cardPay.length == 0 ? 0 : double.parse(cardPay);
    String j = jf();
    double jfPay = double.parse(j);
    double cPay = double.parse(couponPay());
    return (cash +
            zfb +
            wx +
            dz +
            mt +
            sqb +
            bank +
            balance +
            send +
            card +
            jfPay +
            cPay)
        .toStringAsFixed(2);
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
                        nowCard = cardList[v];
                      });
                    },
                    children: cardList
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }
}
