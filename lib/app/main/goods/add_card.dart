import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyInput3.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';

class AddCard extends StatefulWidget {
  final Map data;

  const AddCard({Key key, this.data}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  List classify = [
    {'id': 1, 'name': '储值卡'},
    {'id': 2, 'name': '折扣储值卡'},
    {'id': 3, 'name': '全场折扣卡'}
  ];
  Map now;
  int send = 1;
  TextEditingController _nameCon = TextEditingController(text: '');
  TextEditingController _priceCon = TextEditingController(text: '');
  TextEditingController _amountCon = TextEditingController(text: '');
  TextEditingController _disCon = TextEditingController(text: '');
  TextEditingController _boxCon = TextEditingController(text: '');
  TextEditingController _proCon = TextEditingController(text: '');
  TextEditingController _giftCon = TextEditingController(text: '');
  TextEditingController _itemsCon = TextEditingController(text: '');

  void delData() async {
    var rs = await post('removerCard', data: {'cardid': widget.data['id']});
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _nameCon.text = widget.data['card_name'];
      _priceCon.text = widget.data['price'].toString();
      _amountCon.text = widget.data['amount'].toString();
      now = classify[0];
      if (widget.data['card_type'] == 2) {
        _boxCon.text =
            (double.parse(widget.data['suitbox'].toString()) * 100).toString();
        _proCon.text =
            (double.parse(widget.data['product'].toString()) * 100).toString();
        _giftCon.text =
            (double.parse(widget.data['gift'].toString()) * 100).toString();
        _itemsCon.text =
            (double.parse(widget.data['items'].toString()) * 100).toString();
        now = classify[1];
      }
      if (widget.data['card_type'] == 3) {
        _disCon.text =
            (double.parse(widget.data['discount'].toString()) * 100).toString();
        now = classify[2];
      }
      //print(widget.data);
      send = widget.data['send'];
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text(widget.data == null ? '添加卡项' : '编辑卡项'),
        actions: <Widget>[
          CupertinoButton(
              child: Text(
                '删除',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                var rs = await showAlert(context, '是否删除?');
                if (rs) {
                  delData();
                }
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showMyPicker(context);
              if (now == null) {
                now = classify[0];
                setState(() {});
              }
            },
            child: MyItem(
              label: '卡$kg类',
              child: Text(
                now == null ? '点击选择卡类' : now['name'],
                style: TextStyle(
                    fontSize: 16,
                    color: now == null ? hintColor : Colors.black),
              ),
            ),
          ),
          MyInput2(
            controller: _nameCon,
            label: '卡$kg名',
            hintText: '请输入卡名',
          ),
          MyInput2(
            controller: _priceCon,
            label: '售$kg价',
            hintText: '请输入售价',
            suffixText: '元',
          ),
          MyInput2(
            label: '额$kg度',
            hintText: '请输入额度',
            controller: _amountCon,
          ),
          Offstage(
            offstage: now != null && now['id'] == 3 ? false : true,
            child: MyInput2(
              label: '折$kg扣',
              hintText: '请输入折扣',
              controller: _disCon,
            ),
          ),
          MyItem(
            label: '是否允许赠送',
            child: MyRadio(
              value: send,
              onChanged: (v) {
                send = v;
              },
              text2: '不允许',
              text: '允许',
            ),
          ),
          Offstage(
            offstage: now != null && now['id'] == 2 ? false : true,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '套盒折扣',
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            child: MyInput3(
                              controller: _boxCon,
                              showBottomLine: true,
                            ),
                            width: 80,
                          ),
                          Text(
                            '%',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '产品折扣',
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            child: MyInput3(
                              controller: _proCon,
                              showBottomLine: true,
                            ),
                            width: 80,
                          ),
                          Text('%', style: TextStyle(fontSize: 16))
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '礼包折扣',
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            child: MyInput3(
                              controller: _giftCon,
                              showBottomLine: true,
                            ),
                            width: 80,
                          ),
                          Text(
                            '%',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '项目折扣',
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            child: MyInput3(
                              controller: _itemsCon,
                              showBottomLine: true,
                            ),
                            width: 80,
                          ),
                          Text('%', style: TextStyle(fontSize: 16))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: MyButton(
              onPressed: () {
                if(widget.data==null){
                  save();
                }else{
                  update();
                }
              },
              title: '保存',
            ),
          ),
        ],
      ),
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
                        now = classify[v];
                      });
                    },
                    children: classify
                        .map(
                          (v) => Center(child: Text(v['name'])),
                        )
                        .toList()),
              ),
            ));
  }

  void update() async {
    if (now == null ||
        _nameCon.text.length == 0 ||
        _priceCon.text.length == 0 ||
        _amountCon.text.length == 0) {
      return tip(context, '请填完以上内容');
    }
    if (now['id'] == 2) {
      if (_itemsCon.text.length == 0 ||
          _boxCon.text.length == 0 ||
          _proCon.text.length == 0 ||
          _giftCon.text.length == 0) {
        return tip(context, '请填完以上折扣');
      }
    }
    if (now['id'] == 3 && _disCon.text.length == 0) {
      return tip(context, '请输入折扣');
    }
    var rs = await post('updateCard', data: {
      'update': {
        'card_type': now['id'],
        'card_name': _nameCon.text,
        'price': _priceCon.text,
        'amount': _amountCon.text,
        'send': send,
        'discount': _disCon.text,
        'product': _proCon.text,
        'suitbox': _boxCon.text,
        'items': _itemsCon.text,
        'gift': _giftCon.text,
        'id': widget.data['id'],
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  void save() async {
    if (now == null ||
        _nameCon.text.length == 0 ||
        _priceCon.text.length == 0 ||
        _amountCon.text.length == 0) {
      return tip(context, '请填完以上内容');
    }
    if (now['id'] == 2) {
      if (_itemsCon.text.length == 0 ||
          _boxCon.text.length == 0 ||
          _proCon.text.length == 0 ||
          _giftCon.text.length == 0) {
        return tip(context, '请填完以上折扣');
      }
    }
    if (now['id'] == 3 && _disCon.text.length == 0) {
      return tip(context, '请输入折扣');
    }
    var rs = await post('addCard', data: {
      'data': {
        'type': now['id'],
        'name': _nameCon.text,
        'amount': _amountCon.text,
        'discount': _disCon.text,
        'suitbox': _boxCon.text,
        'pro': _proCon.text,
        'gift': _giftCon.text,
        'items': _itemsCon.text,
        'send': send,
        'price': _priceCon.text,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }
}
