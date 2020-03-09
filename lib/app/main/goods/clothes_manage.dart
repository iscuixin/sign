import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/goods/add_box.dart';
import 'package:myh_shop/app/main/goods/add_clothes.dart';
import 'package:myh_shop/app/main/goods/add_item.dart';
import 'package:myh_shop/app/main/goods/cp_edit.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class ClothesManage extends StatefulWidget {
  @override
  _CpManageState createState() => _CpManageState();
}

class _CpManageState extends State<ClothesManage> {
  List list;
  List category;
  String input = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_underwear');
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('内衣管理'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('创建内衣'),
              onPressed: () async {
                var rs = await jump2(context, AddClothes());
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
                hintText: '输入内衣名称',
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
                              child: Text('编号'),
                              alignment: Alignment.center,
                            ),
                          ),
                          Expanded(
                            child: Container(
                                width: 150,
                                child: Text('名称'),
                                alignment: Alignment.center),
                          ),
                          Expanded(
                            child: Container(
                                width: 100,
                                child: Text('颜色'),
                                alignment: Alignment.center),
                          ),
                          Expanded(
                            child: Container(
                                width: 100,
                                child: Text('尺寸'),
                                alignment: Alignment.center),
                          ),
                          Expanded(
                            child: Container(
                                width: 100,
                                child: Text('价格'),
                                alignment: Alignment.center),
                          ),
                          Expanded(
                              child: Container(
                                  child: Text('库存'),
                                  alignment: Alignment.center)),
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
    if(input.length>0){
      if (list[i]['name']
          .toString()
          .toLowerCase()
          .indexOf(input.toLowerCase()) <
          0) {
        return Offstage();
      }
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
                      child: Text(
                        '${list[i]['sn']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Expanded(
                  child: Center(
                      child: Text(
                        '${list[i]['name']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['color']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['type']==1?list[i]['cup']:list[i]['size']}',
                          style: TextStyle()))),
              Expanded(
                  child: Center(
                      child: Text(
                '¥${list[i]['price']}',
                style: TextStyle(),
              ))),
              Expanded(
                    child: Center(
                        child: Text('${list[i]['sum']}',
                            style: TextStyle()))),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['beforehand_num']}',
                          style: TextStyle()))),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  title: '编辑',
                  onPressed: () async {
                    await jump2(context, AddClothes(id: list[i]['id'],));
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
