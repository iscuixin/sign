import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/warehouse/in.dart';
import 'package:myh_shop/app/main/warehouse/out.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class OutIn extends StatefulWidget {
  final int id;

  OutIn(this.id);

  @override
  _OutInState createState() => _OutInState();
}

class _OutInState extends State<OutIn> {
  List list;
  double w = 250;
  String input = '';
  TextEditingController _start = TextEditingController(text: '');
  TextEditingController _end = TextEditingController(text: '');
  String one = '';
  String two = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await post('WareIntoOutDetail', data: {'ware': widget.id});
    if (rs != null) {
      setState(() {
        list = rs['res']['res'];
        _start.text = rs['res']['warning']['start_num'].toString();
        _end.text = rs['res']['warning']['end_num'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: bg,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('出入库操作及设置'),
              leading: backButton(context),
              pinned: true,
              expandedHeight: 260,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: getRange(context, type: 3) + 55),
                child: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 45,
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: MyInput(
                            prefixIcon: Icon(
                              Icons.search,
                              color: textColor,
                            ),
                            hintText: '请输入商品名称',
                            onChanged: (v) {
                              setState(() {
                                input = v;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            '按数量查找',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('大于等于'),
                                MyInput2(
                                  label: '',
                                  onChanged: (v) {
                                    setState(() {
                                      one = v;
                                    });
                                  },
                                  type: 2,
                                  width: 50,
                                  contentPadding: EdgeInsets.all(5),
                                  height: 30,
                                ),
                                Text('个'),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('小于等于'),
                                MyInput2(
                                  label: '',
                                  onChanged: (v) {
                                    setState(() {
                                      two = v;
                                    });
                                  },
                                  type: 2,
                                  width: 50,
                                  contentPadding: EdgeInsets.all(5),
                                  height: 30,
                                ),
                                Text('个'),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Divider(
                            height: 0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            '库存警告',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('库存小于(x)'),
                                MyInput2(
                                  label: '',
                                  type: 2,
                                  width: 50,
                                  contentPadding: EdgeInsets.all(5),
                                  controller: _start,
                                  height: 30,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('库存大于(x)'),
                                MyInput2(
                                  controller: _end,
                                  label: '',
                                  type: 2,
                                  width: 50,
                                  contentPadding: EdgeInsets.all(5),
                                  height: 30,
                                ),
                                GestureDetector(
                                  child: Text(
                                    '保存',
                                    style: TextStyle(color: c1),
                                  ),
                                  onTap: () {
                                    saveData();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //SliverFillRemaining(child: Container(color: c1,),),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                color: bg,
                height: getRange(context, type: 2),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          color: bg2,
                          width: getRange(context) + w,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text('类别'),
                                alignment: Alignment.center,
                              ),
                              Container(
                                  width: 150,
                                  child: Text('名称'),
                                  alignment: Alignment.center),
                              Container(
                                  width: 100,
                                  child: Text('实时库存'),
                                  alignment: Alignment.center),
                              Container(
                                  width: 100,
                                  child: Text('与预售'),
                                  alignment: Alignment.center),
                              Expanded(
                                  child: Container(
                                      child: Text('操作'),
                                      alignment: Alignment.center)),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        list != null
                            ? SizedBox(
                                width: getRange(context) + w,
                                height: getRange(context, type: 2) -
                                    310 -
                                    getRange(context, type: 4) * 2,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  itemBuilder: (_, i) => _item(i),
                                  itemCount: list.length,
                                ),
                              )
                            : Center(
                                child: loading(),
                              ),
                      ],
                    )
                  ],
                ),
              )
            ])),
          ],
        ),
      ),
    );
  }

  String getType(int t) {
    String str = '';
    if (t == 1) {
      str = '产品';
    }
    if (t == 2) {
      str = '套盒';
    }
    if (t == 3) {
      str = '耗材';
    }
    if (t == 4) {
      str = '内衣';
    }
    return str;
  }

  Widget _item(int i) {
    if (input.length > 0 &&
        list[i]['name'].toString().toLowerCase().indexOf(input.toLowerCase()) <
            0) {
      return Offstage();
    }
    if (one.length > 0 || two.length > 0) {
      if (one.length > 0) {
        if (list[i]['stock'] < int.parse(one)) {
          return Offstage();
        }
      }
      if (two.length > 0) {
        if (list[i]['stock'] > int.parse(two)) {
          return Offstage();
        }
      }
    }
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          decoration: BoxDecoration(color: bg2),
          child: Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Chip(
                  label: Text(
                    getType(list[i]['type']),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: c1,
                ),
                alignment: Alignment.center,
              ),
              Container(
                  width: 150,
                  child: Text(
                    '${list[i]['name']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  alignment: Alignment.center),
              Container(
                  width: 100,
                  child: Text(
                    '${list[i]['stock']}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  alignment: Alignment.center),
              Container(
                  width: 100,
                  child: Text('${list[i]['beforehand_num']}',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  alignment: Alignment.center),
              Expanded(
                  child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: MyButton(
                            onPressed: () async {
                              await jump2(context,
                                  In(list[i]['id'], widget.id, list[i]['type'], 'into'));
                              getSj();
                            },
                            title: '入库',
                            height: 30,
                          )),
                          Padding(padding: EdgeInsets.all(5)),
                          Expanded(
                              child: MyButton(
                                  onPressed: () async {
                                    await jump2(context,
                                        Out(list[i]['id'], widget.id, list[i]['type'], 'out'));
                                    getSj();
                                  },
                                  title: '出库',
                                  height: 30)),
                          Padding(padding: EdgeInsets.all(10)),
                        ],
                      ),
                      alignment: Alignment.center)),
            ],
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }

  void saveData() async {
    String s = _start.text;
    String e = _end.text;
    if (s.length == 0 || e.length == 0) {
      return tip(context, '请输入有效库存预警');
    }
    var rs = await post('goods_manager', data: {
      'data': {
        'end_num': e,
        'start_num': s,
        'ware': widget.id,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg'], type: 2);
      }
    }
  }
}
