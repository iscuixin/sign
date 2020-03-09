import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;

class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> with TickerProviderStateMixin {
  List list;
  Map one;
  Map two;
  Map three;
  List list2;
  Map one2;
  Map two2;
  Map three2;
  List list3;
  Map one3;
  Map two3;
  Map three3;
  List list4;
  Map one4;
  Map two4;
  Map three4;
  List list5;
  Map one5;
  Map two5;
  Map three5;
  String time = 'week';
  String type = 'all';
  TabController _tab;
  int now = 0;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 5, vsync: this);
    _tab.addListener(() {
      now = _tab.index;
      if (_tab.index == 0) {
        type = 'all';
      } else if (_tab.index == 1) {
        type = 'product';
      } else if (_tab.index == 2) {
        type = 'box';
      } else if (_tab.index == 3) {
        type = 'items';
      } else if (_tab.index == 4) {
        type = 'plan';
      }
      getSj();
    });
    getSj();
  }

  void getSj() async {
    var rs = await get('get_ranking', data: {
      'time': time,
      'type': type,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        //print(rs['res']);
        list = [];
        list2 = [];
        list3 = [];
        list4 = [];
        list5 = [];
        setState(() {
          if (type == 'all') {
            if (rs['res']['all_list'] != null) {
              if (rs['res']['all_list'] is Map) {
                Map d = rs['res']['all_list'];
                d.forEach((k, v) {
                  list.add(v);
                });
                if (rs['res']['one'] != '') {
                  one = rs['res']['one'];
                }
                if (rs['res']['two'] != '') {
                  two = rs['res']['two'];
                }
                if (rs['res']['three'] != '') {
                  three = rs['res']['three'];
                }
              }
            }
          }
          if (type == 'product') {
            if (rs['res']['all_list'] != null) {
              if (rs['res']['all_list'] is Map) {
                Map d = rs['res']['all_list'];
                d.forEach((k, v) {
                  list2.add(v);
                });
                if (rs['res']['one'] != '') {
                  one2 = rs['res']['one'];
                }
                if (rs['res']['two'] != '') {
                  two2 = rs['res']['two'];
                }
                if (rs['res']['three'] != '') {
                  three2 = rs['res']['three'];
                }
              } else {
                list2 = rs['res']['all_list'];
                if (rs['res']['one'] != '') {
                  one2 = rs['res']['one'];
                }
                if (rs['res']['two'] != '') {
                  two2 = rs['res']['two'];
                }
                if (rs['res']['three'] != '') {
                  three2 = rs['res']['three'];
                }
              }
            }
          }
          if (type == 'box') {
            if (rs['res']['all_list'] != null) {
              if (rs['res']['all_list'] is Map) {
                Map d = rs['res']['all_list'];
                d.forEach((k, v) {
                  list3.add(v);
                });
                if (rs['res']['one'] != '') {
                  one3 = rs['res']['one'];
                }
                if (rs['res']['two'] != '') {
                  two3 = rs['res']['two'];
                }
                if (rs['res']['three'] != '') {
                  three3 = rs['res']['three'];
                }
              } else {
                list3 = rs['res']['all_list'];
                if (rs['res']['one'] != '') {
                  one3 = rs['res']['one'];
                }
                if (rs['res']['two'] != '') {
                  two3 = rs['res']['two'];
                }
                if (rs['res']['three'] != '') {
                  three3 = rs['res']['three'];
                }
              }
            }
          }
          if (type == 'items') {
            if (rs['res']['all_list'] != null) {
              if (rs['res']['all_list'] is Map) {
                Map d = rs['res']['all_list'];
                d.forEach((k, v) {
                  list4.add(v);
                });
                if (rs['res']['one'] != '') {
                  one4 = rs['res']['one'];
                }
                if (rs['res']['two'] != '') {
                  two4 = rs['res']['two'];
                }
                if (rs['res']['three'] != '') {
                  three4 = rs['res']['three'];
                }
              } else {
                list4 = rs['res']['all_list'];
                if (rs['res']['one'] != '') {
                  one4 = rs['res']['one'];
                }
                if (rs['res']['two'] != '') {
                  two4 = rs['res']['two'];
                }
                if (rs['res']['three'] != '') {
                  three4 = rs['res']['three'];
                }
              }
            }
          }
          if (type == 'plan') {
            if (rs['res']['all_list'] != null) {
              if (rs['res']['all_list'] is Map) {
                Map d = rs['res']['all_list'];
                d.forEach((k, v) {
                  list5.add(v);
                });
                if (rs['res']['one'] != '') {
                  one5 = rs['res']['one'];
                }
                if (rs['res']['two'] != '') {
                  two5 = rs['res']['two'];
                }
                if (rs['res']['three'] != '') {
                  three5 = rs['res']['three'];
                }
              } else {
                list5 = rs['res']['all_list'];
                if (rs['res']['one'] != '') {
                  one5 = rs['res']['one'];
                }
                if (rs['res']['two'] != '') {
                  two5 = rs['res']['two'];
                }
                if (rs['res']['three'] != '') {
                  three5 = rs['res']['three'];
                }
              }
            }
          }
        });
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg,
      child: DefaultTabController(
        child: Material(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text('排行榜', style: TextStyle(color: Colors.white)),
                leading: backButton(context, color: Colors.white),
                pinned: true,
                backgroundColor: c1,
                brightness: Brightness.dark,
                actions: <Widget>[
                  CupertinoButton(
                    child: Text(
                      time=='week'?'月榜':'周榜',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        if(time=='week'){
                          time = 'month';
                        }else{
                          time = 'week';
                        }
                        getSj();
                      });
                    },
                  )
                ],
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Image.asset(
                        getImg('2.10_01'),
                        fit: BoxFit.fill,
                        height: 200 + getRange(context, type: 3),
                        width: getRange(context),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 15,
                        right: 15,
                        child: Container(
                          width: getRange(context),
                          height: 55,
                          decoration: BoxDecoration(
                              color: bg2,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: TabBar(
                            controller: _tab,
                            tabs: [
                              Tab(
                                text: '全部',
                              ),
                              Tab(
                                text: '产品',
                              ),
                              Tab(
                                text: '套盒',
                              ),
                              Tab(
                                text: '卡项',
                              ),
                              Tab(
                                text: '方案',
                              ),
                            ],
                            indicatorSize: TabBarIndicatorSize.label,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                  height: getRange(context, type: 2) -
                      200 -
                      getRange(context, type: 4) -
                      getRange(context, type: 3),
                  child: TabBarView(controller: _tab, children: [
                    one != null
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (_, i) => _item(i, 1),
                            itemCount: list.length,
                          )
                        : Center(
                            child: Text('暂无数据'),
                          ),
                    one2 != null
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (_, i) => _item(i, 2),
                            itemCount: list2.length,
                          )
                        : Center(
                            child: Text('暂无数据'),
                          ),
                    one3 != null
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (_, i) => _item(i, 3),
                            itemCount: list3.length,
                          )
                        : Center(
                            child: Text('暂无数据'),
                          ),
                    one4 != null
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (_, i) => _item(i, 4),
                            itemCount: list4.length,
                          )
                        : Center(
                            child: Text('暂无数据'),
                          ),
                    one5 != null
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (_, i) => _item(i, 5),
                            itemCount: list5.length,
                          )
                        : Center(
                            child: Text('暂无数据'),
                          ),
                  ]),
                )
              ]))
            ],
          ),
        ),
        length: 5,
      ),
    );
  }

  Widget _item(int i, t) {
    Map data;
    Map oneData;
    Map twoData;
    Map threeData;
    if (t == 1) {
      data = list[i];
      oneData = one;
      twoData = two;
      threeData = three;
    } else if (t == 2) {
      data = list2[i];
      oneData = one2;
      twoData = two2;
      threeData = three2;
    } else if (t == 3) {
      data = list3[i];
      oneData = one3;
      twoData = two3;
      threeData = three3;
    } else if (t == 4) {
      data = list4[i];
      oneData = one4;
      twoData = two4;
      threeData = three4;
    } else if (t == 5) {
      data = list5[i];
      oneData = one5;
      twoData = two5;
      threeData = three5;
    }
    if (i == 0) {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            padding: EdgeInsets.only(bottom: 10),
            height: 120,
            color: bg2,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        getImg('2.10_07'),
                        width: 50,
                        fit: BoxFit.fill,
                        height: 50,
                      ),
                      Text('${twoData['name']}'),
                      RichText(
                          text: TextSpan(
                              text: '销量：',
                              style: TextStyle(color: textColor),
                              children: [
                            TextSpan(
                                text: '${twoData['sum']}',
                                style: TextStyle(color: Colors.black))
                          ]))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        getImg('2.10_04'),
                        fit: BoxFit.fill,
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        '${oneData['name']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: c1, fontSize: 17),
                      ),
                      RichText(
                          text: TextSpan(
                              text: '销量：',
                              style: TextStyle(color: c1),
                              children: [
                            TextSpan(
                              text: '${oneData['sum']}',
                            )
                          ]))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        getImg('2.10_10'),
                        width: 50,
                        fit: BoxFit.fill,
                        height: 50,
                      ),
                      Text('${threeData['name']}'),
                      RichText(
                          text: TextSpan(
                              text: '销量：',
                              style: TextStyle(color: textColor),
                              children: [
                            TextSpan(
                                text: '${threeData['sum']}',
                                style: TextStyle(color: Colors.black))
                          ]))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      );
    }
    if (i == 1) {
      return Offstage();
    }
    if (i == 2) {
      return Offstage();
    }
    return Container(
      decoration: BoxDecoration(
          color: bg2,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(i == list.length - 1 ? 10 : 0),
              bottomLeft: Radius.circular(i == list.length - 1 ? 10 : 0))),
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: c1,
              radius: 15,
              child: Text('${i + 1}'),
            ),
            title: Text(
              '${data['name']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: RichText(
                text: TextSpan(
                    text: '销量：',
                    children: [
                      TextSpan(
                          text: '${data['sum']}',
                          style: TextStyle(color: Colors.black))
                    ],
                    style: TextStyle(color: textColor))),
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
