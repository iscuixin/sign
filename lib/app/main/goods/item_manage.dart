import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/goods/add_box.dart';
import 'package:myh_shop/app/main/goods/add_item.dart';
import 'package:myh_shop/app/main/goods/cp_edit.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class ItemManage extends StatefulWidget {
  @override
  _CpManageState createState() => _CpManageState();
}

class _CpManageState extends State<ItemManage> {
  List list;
  List category;
  String input = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('itemsList');//print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res']['list'];
          category = rs['res']['category'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('项目管理'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('创建项目'),
              onPressed: () async {
                var rs = await jump2(context, AddItem());
                getSj();
              })
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: MyInput(
                onChanged: (v) {
                  setState(() {
                    input = v;
                  });
                },
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
                hintText: '输入项目名称',
              ),
            ),
            preferredSize: Size(getRange(context), 50)),
      ),
      body: list != null
          ? ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      color: bg2,
                      width: getRange(context) * 2,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: 100,
                              child: Text('类别'),
                              alignment: Alignment.center,
                            ),
                          ),
                          Expanded(
                            child: Container(
                                width: 150,
                                child: Text('项目名称'),
                                alignment: Alignment.center),
                          ),
                          Expanded(
                            child: Container(
                                width: 100,
                                child: Text('编号'),
                                alignment: Alignment.center),
                          ),
                          Expanded(
                            child: Container(
                                width: 100,
                                child: Text('售价'),
                                alignment: Alignment.center),
                          ),
                          Expanded(
                            child: Container(
                                width: 100,
                                child: Text('次数'),
                                alignment: Alignment.center),
                          ),
                          /*Expanded(
                              child: Container(
                                  child: Text('库存'),
                                  alignment: Alignment.center)),*/
                          Expanded(
                              child: Container(
                                  child: Text('预售'),
                                  alignment: Alignment.center)),
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
                    Expanded(
                      child: Container(
                        color: bg2,
                        width: getRange(context) * 2,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemBuilder: (_, i) => _item(i),
                          itemCount: list.length,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          : Center(
              child: loading(),
            ),
    );
  }

  Widget _item(int i) {
    if (list[i]['pro_name']
            .toString()
            .toLowerCase()
            .indexOf(input.toLowerCase()) <
        0) {
      return Offstage();
    }
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          color: bg2,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Center(
                      child: Chip(
                label: Text(
                  '${list[i]['category_name']}',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: c1,
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['pro_name']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['sn'] ?? '无'}',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Center(
                      child: Text(
                '¥${list[i]['price']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['frequency']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
              /*Expanded(
                    child: Center(
                        child: Text('${list[i]['frequency']}',
                            style: TextStyle(fontWeight: FontWeight.bold)))),*/
              Expanded(
                  child: Center(
                      child: Text('${list[i]['beforehand_num']}',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  title: '编辑',
                  onPressed: () async {
                    var rs = await jump2(
                        context,
                        AddItem(
                          type: 2,
                          id: list[i]['id'],
                        ));
                    getSj();
                  },
                  height: 30,
                ),
              )),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
