import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class RecycleBin extends StatefulWidget {
  @override
  _RecycleBinState createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> with TickerProviderStateMixin {
  List item;
  List box;
  List plan;
  List cp;
  List card;
  int now = 0;
  TabController _tabController;
  bool hyState = false;
  bool emptyState = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      now = _tabController.index;
      //print(now);
      getSj(now + 1);
    });
    getSj(1);
  }

  void getSj(int t) async {
    var rs = await post('trashData', data: {'type': t});
    if (rs != null) {
      for (var v in rs['data']) {
        v['zt'] = false;
      }
      if (t == 1) {
        item = rs['data'];
      } else if (t == 2) {
        box = rs['data'];
      } else if (t == 3) {
        plan = rs['data'];
      } else if (t == 4) {
        cp = rs['data'];
      } else if (t == 5) {
        card = rs['data'];
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('回收站'),
          bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  TabBar(
                      tabs: [
                        Tab(
                          text: '项目',
                        ),
                        Tab(
                          text: '套盒',
                        ),
                        Tab(
                          text: '方案',
                        ),
                        Tab(
                          text: '产品',
                        ),
                        Tab(
                          text: '卡项',
                        ),
                      ],
                      indicatorSize: TabBarIndicatorSize.label,
                      controller: _tabController),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: MyInput(
                      prefixIcon: Icon(
                        Icons.search,
                        color: textColor,
                      ),
                      hintText: '输入项目名称',
                    ),
                  ),
                ],
              ),
              preferredSize: Size(getRange(context), 120)),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.all(15),
            width: getRange(context),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      all();
                    },
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          isAll() ? getImg('radio_yes') : getImg('radio_no'),
                          height: 20,
                          color: c1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('全选',
                              style: TextStyle(color: c1, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: MyButton(
                            load: hyState,
                            title: '还原',
                            onPressed: () {
                              if(!hyState){
                                hy();
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: MyButton(
                            load: emptyState,
                            title: '清空',
                            onPressed: () async {
                              var rs = await showAlert(context, '是否删除？');
                              if(rs){
                                hy(t: 2);
                              }
                            },
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          color: bg2,
          margin: EdgeInsets.only(top: 10),
          child: TabBarView(controller: _tabController, children: [
            item != null
                ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 1),
                    itemCount: item.length,
                  )
                : Center(
                    child: loading(),
                  ),
            box != null
                ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 2),
                    itemCount: box.length,
                  )
                : Center(
                    child: loading(),
                  ),
            plan != null
                ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 3),
                    itemCount: plan.length,
                  )
                : Center(
                    child: loading(),
                  ),
            cp != null
                ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 4),
                    itemCount: cp.length,
                  )
                : Center(
                    child: loading(),
                  ),
            card != null
                ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 5),
                    itemCount: card.length,
                  )
                : Center(
                    child: loading(),
                  ),
          ]),
        ),
      ),
      length: 5,
    );
  }

  void all() {
    bool zt = isAll();
    if (now == 0) {
      for (var v in item) {
        v['zt'] = !zt;
      }
    }
    if (now == 1) {
      for (var v in box) {
        v['zt'] = !zt;
      }
    }
    if (now == 2) {
      for (var v in plan) {
        v['zt'] = !zt;
      }
    }
    if (now == 3) {
      for (var v in cp) {
        v['zt'] = !zt;
      }
    }
    if (now == 4) {
      for (var v in card) {
        v['zt'] = !zt;
      }
    }
    setState(() {});
  }

  Widget _item(int i, t) {
    String name = '';
    String money = '';
    Map data;
    bool zt = false;
    if (t == 1) {
      data = item[i];
      name = item[i]['pro_name'];
      money = item[i]['price'];
      zt = item[i]['zt'];
    } else if (t == 2) {
      data = box[i];
      name = box[i]['box_name'];
      money = box[i]['price'];
      zt = box[i]['zt'];
    } else if (t == 3) {
      data = plan[i];
      name = plan[i]['name'];
      money = plan[i]['sale'];
      zt = plan[i]['zt'];
    } else if (t == 4) {
      data = cp[i];
      name = cp[i]['goods_name'];
      money = cp[i]['price'];
      zt = cp[i]['zt'];
    } else if (t == 5) {
      data = card[i];
      name = card[i]['card_name'];
      money = card[i]['price'];
      zt = card[i]['zt'];
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          data['zt'] = !data['zt'];
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, top: 10),
            height: 60,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    getImg(zt ? 'radio_yes' : 'radio_no'),
                    height: 20,
                    color: c1,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    )),
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: '金额：',
                              children: [
                                TextSpan(
                                    text: '¥$money',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black))
                              ],
                              style: TextStyle(color: textColor))),
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  bool isAll() {
    if(item==null){
      return false;
    }
    if (now == 0) {
      for (var v in item) {
        if (!v['zt']) {
          return false;
        }
      }
    }
    if (now == 1) {
      for (var v in box) {
        if (!v['zt']) {
          return false;
        }
      }
    }
    if (now == 2) {
      for (var v in plan) {
        if (!v['zt']) {
          return false;
        }
      }
    }
    if (now == 3) {
      for (var v in cp) {
        if (!v['zt']) {
          return false;
        }
      }
    }
    if (now == 4) {
      for (var v in card) {
        if (!v['zt']) {
          return false;
        }
      }
    }
    return true;
  }

  void hy({int t = 1}) async {
    List id = [];
    if (now == 0) {
      for (var v in item) {
        if (v['zt']) {
          id.add(v['id']);
        }
      }
    } else if (now == 1) {
      for (var v in box) {
        if (v['zt']) {
          id.add(v['id']);
        }
      }
    } else if (now == 2) {
      for (var v in plan) {
        if (v['zt']) {
          id.add(v['id']);
        }
      }
    } else if (now == 3) {
      for (var v in cp) {
        if (v['zt']) {
          id.add(v['id']);
        }
      }
    } else if (now == 4) {
      for (var v in card) {
        if (v['zt']) {
          id.add(v['id']);
        }
      }
    }
    if (id.length < 0) {
      return tip(context, '请选择商品');
    }
    if(t==1){
      hyState = true;
    }else{
      emptyState = true;
    }
    setState(() {

    });
    var rs = await post(t==1?'backData':'delData', data: {'type': now+1, 'id': jsonEncode(id)});
    if(t==1){
      hyState = false;
    }else{
      emptyState = false;
    }
    setState(() {

    });
    if (rs != null) {
      if (rs['code'] == 0) {
        getSj(now+1);
      }
    }
  }
}
