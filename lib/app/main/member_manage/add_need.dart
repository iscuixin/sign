import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class AddNeed extends StatefulWidget {
  final int id;

  const AddNeed(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _AddNeedState createState() => _AddNeedState();
}

class _AddNeedState extends State<AddNeed> {
  List list = [];
  String str = '';
  TextEditingController _strCon = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('需求添加'),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: 15,
          right: 15,
        ),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: MyInput2(
                  label: '客户需求',
                  controller: _strCon,
                  hintText: '输入需求后点击添加',
                ),
              ),
              MyButton(
                title: '添加',
                onPressed: () {
                  add();
                },
                width: 70,
                height: 30,
              ),
            ],
          ),
          Wrap(
            children: need(),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: MyButton(
              title: '保存',
              onPressed: () {
                sub();
              },
            ),
          ),
        ],
      ),
    );
  }

  void add() {
    String str = _strCon.text;
    if (str.length > 0) {
      list.add(str);
      _strCon.text = '';
      setState(() {});
    }
  }

  List<Widget> need() {
    List<Widget> rs = [];
    int i = 0;
    for (var v in list) {
      rs.add(GestureDetector(
        onTap: () {
          rm(v);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Chip(label: Text('$v')),
        ),
      ));
      i++;
    }
    return rs;
  }

  void rm(String v) {
    int i = 0;
    for (var x in list) {
      if (x == v) {
        list.removeAt(i);
        setState(() {});
        return;
      }
      i++;
    }
    /*list.removeAt(i);
    setState(() {});*/
  }

  void sub() async {
    if (list.length == 0) {
      return tip(context, '请添加需求');
    }
    var rs = await post('addNeed',
        data: {'id': widget.id, 'data': jsonEncode(list)});
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 0) {
        ok(context, '添加成功');
      }
    }
  }
}
