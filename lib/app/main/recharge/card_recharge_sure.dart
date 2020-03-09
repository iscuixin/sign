import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:flutter/cupertino.dart';

class CardRechargeSure extends StatefulWidget {
  final int id;

  const CardRechargeSure(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _CardRechargeSureState createState() => _CardRechargeSureState();
}

class _CardRechargeSureState extends State<CardRechargeSure> {
  String money = '';
  String balance = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('卡充值'),
        /*actions: <Widget>[
          CupertinoButton(child: Text('充值记录'), onPressed: (){}),
        ],*/
      ),
      body: ListView(
        children: <Widget>[
          MyInput2(
            label: '卡余额',
            enabled: false,
            hintText: '$balance',
            hintStyle: TextStyle(color: Colors.black),
          ),
          MyInput2(
            label: '充值余额',
            keyboardType: TextInputType.numberWithOptions(),
            onChanged: (v){
              money = v;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: MyButton(
              title: '确认充值',
              onPressed: () {
                sub();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void sub() async {
    if(money.length==0){
      return tip(context, '请输入充值金额');
    }
    var rs = await post('saveCard',
        data: {
          'money': money,
        },
        t: widget.id);
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['info']);
      }
    }
  }

  void getSj()async {
    var rs = await get('saveCard', data: {
      'id': widget.id
    });//print(rs);
    if(rs!=null){
      if(rs['code']==0){
        setState(() {
          balance = rs['data'];
        });
      }
    }
  }
}
