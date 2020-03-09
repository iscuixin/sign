import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/goods/cp_edit.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class CpManage extends StatefulWidget {
  @override
  _CpManageState createState() => _CpManageState();
}

class _CpManageState extends State<CpManage> {
  List list;
  String input = '';
  ScrollController scrollController;
  int count;
  int nowPage = 1;
  int prePage = 1; //上一页
  TextEditingController _textEditingController =
      TextEditingController(text: '');

  void search() async {
    if (_textEditingController.text.length > 0) {
      var rs = await get('goods_search',
          data: {'name': _textEditingController.text});
      if (rs != null) {
        if (rs['code'] == 0) {
          setState(() {
            list = rs['data'];
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('产品管理'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('创建产品'),
              onPressed: () async {
                var rs = await jump(context, 'add_cp');
                nowPage = 1;
                prePage = 1;
                getSj();
              })
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: MyInput(
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: textColor,
                    ),
                    onPressed: () {
                      search();
                    }),
                hintText: '输入产品名称',
                controller: _textEditingController,
                onChanged: (v) {
                  if (v.length == 0) {
                    nowPage = 1;
                    prePage = 1;
                    getSj();
                  }
                },
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
                                child: Text('产品名称'),
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
                          controller: scrollController,
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
    if (list[i]['num'] == 'over') {
      return end(context);
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
                '${list[i]['goods_name']}',
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
                      child: Text('${list[i]['stock']}',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
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
                    var rs = await jump2(context, CpEdit(list[i]['id']));
                    nowPage = 1;
                    prePage = 1;
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

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      double now = scrollController.offset;
      double max = scrollController.position.maxScrollExtent;
      if (nowPage < count && max - now <= loadPosition && prePage == nowPage) {
        //print('load');
        nowPage++;
        getSj();
      }
    });
    getSj();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void getSj() async {
    var rs = await get('get_goods_list', data: {'page': nowPage});
    if (rs != null) {
      if (rs['code'] == 1) {
        if (nowPage == 1) {
          list = rs['res']['list'];
          count = rs['res']['page_count'];
        } else {
          for (var v in rs['res']['list']) {
            list.add(v);
          }
        }
        if (nowPage == count) {
          list.add({'num': 'over'});
        }
        setState(() {
          prePage = nowPage;
        });
      }
    }
  }
}
