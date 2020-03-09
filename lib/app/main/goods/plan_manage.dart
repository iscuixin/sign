import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/goods/add_plan.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';

class PlanManage extends StatefulWidget {
  @override
  _PlanManageState createState() => _PlanManageState();
}

class _PlanManageState extends State<PlanManage> with TickerProviderStateMixin {
  List list;
  bool zt = false;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('plan_list');
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        for (var v in rs['res']) {
          v['zt'] = false;
        }
        setState(() {
          list = rs['res'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('方案管理'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('新增方案'),
              onPressed: () async {
                var rs = await jump2(context, AddPlan());
                getSj();
              })
        ],
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (_, i) => _item(i),
              itemCount: list.length,
            )
          : Center(
              child: loading(),
            ),
    );
  }

  Widget _item(int i) => Column(
        children: <Widget>[
          ListTile(
            leading: Container(
              width: getRange(context)*3 / 4,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        list[i]['zt'] = !list[i]['zt'];
                      });
                    },
                    child: CircleAvatar(
                      radius: 15,
                      child: Icon(
                        list[i]['zt']
                            ? Icons.keyboard_arrow_down
                            : Icons.chevron_right,
                        color: Colors.white,
                      ),
                      backgroundColor: list[i]['zt']
                          ? myColor(96, 97, 98)
                          : myColor(204, 205, 206),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      '${list[i]['name']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    width: getRange(context) / 4,
                  ),
                  priceWidget('${list[i]['sale']}')
                ],
              ),
            ),
            trailing: MyButton(
              onPressed: () async {
                var rs = await showAlert(context, '是否删除 ${list[i]['name']}?');
                if (rs) {
                  del(list[i]['id']);
                }
              },
              title: '删除',
              color: Colors.red,
              width: getRange(context) / 5,
              height: 30,
              titleStyle: TextStyle(fontSize: 15),
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 200),
            vsync: this,
            child: Container(
              height: list[i]['zt']
                  ? double.parse((list[i]['detail'].length * 50).toString())
                  : 0,
              padding: EdgeInsets.only(left: 15),
              color: tableBg,
              child: listWidget(list[i]['detail']),
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      );

  Widget listWidget(dynamic data) {
    List rs = [];
    if (data is Map) {
      data.forEach((k, v) {
        rs.add(v);
      });
    } else {
      rs = data;
    }
    return Column(
      children: rs.map((v) => _item2(v)).toList(),
    );
  }

  Widget _item2(Map v) => Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: c1, borderRadius: BorderRadius.circular(10)),
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                  child: Text(
                    '${v['type']}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                    child: Text(
                  '${v['name']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                Expanded(child: Text('售价：${v['price']}')),
                Expanded(
                    child: Text(
                  '次数：${v['times']}',
                  style: TextStyle(
                      color: v['type'] == '产品'
                          ? Colors.transparent
                          : Colors.black),
                )),
              ],
            ),
          ),
          Divider(
            height: 0,
          )
        ],
      );

  void del(int id) async {
    var rs = await post('del_plan', data: {'id': id, 'type': 'del'});
    if (rs != null) {
      if (rs['code'] == 1) {
        getSj();
      }
    }
  }
}
