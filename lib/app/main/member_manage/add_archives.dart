import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/member_manage/add_archives2.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:flutter/cupertino.dart';

class AddArchives extends StatefulWidget {
  final int id;

  const AddArchives(this.id, {
    Key key,
  }) : super(key: key);

  @override
  _AddArchivesState createState() => _AddArchivesState();
}

class _AddArchivesState extends State<AddArchives> {
  List skin;
  List body;
  List list;
  StateSetter state;
  Map check = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('健康筛选'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
            child: MyButton(
              title: '提交',
              onPressed: () {
                sub();
              },
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: bg2,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('皮肤问题'),
                ),
                Wrap(
                  children: skin != null
                      ? pf()
                      : [
                    Center(
                      child: loading(),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            color: bg2,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('身体问题'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Wrap(
                    children: body != null
                        ? st()
                        : [
                      Center(
                        child: loading(),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> pf() {
    List<Widget> pf = [];
    for (var v in skin) {
      pf.add(GestureDetector(
        onTap: () {
          getDetail(v['id']);
          show(v);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Chip(
            label: Text(
              v['body'],
              style: TextStyle(
                  color: isCheck2(v['id']) ? Colors.white : Colors.black),
            ),
            backgroundColor: isCheck2(v['id']) ? c1 : hintColor,
          ),
        ),
      ));
    }
    return pf;
  }

  List<Widget> st() {
    List<Widget> st = [];
    for (var v in body) {
      st.add(GestureDetector(
        onTap: () {
          getDetail(v['id']);
          show(v);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Chip(
            label: Text(
              v['body'],
              style: TextStyle(
                  color: isCheck2(v['id']) ? Colors.white : Colors.black),
            ),
            backgroundColor: isCheck2(v['id']) ? c1 : hintColor,
          ),
        ),
      ));
    }
    return st;
  }

  bool isCheck2(int id) {
    bool zt = false;
    check.forEach((k, v) {
      if (k == id) {
        if (v.length > 0) {
          zt = true;
          return;
        }
      }
    });
    return zt;
  }

  @override
  void initState() {
    super.initState();
    if(widget.id==-1){
      getSj2();
    }else{
      getSj();
    }
  }

  void getSj() async {
    var rs = await get('HealthyAdd', data: {
      'type': 'list',
      'id': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          skin = rs['data']['skin'];
          body = rs['data']['body'];
        });
      }
    }
  }

  void getSj2() async {
    var rs = await get('HealthSearch', data: {
      'type': 'list',
    });
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          skin = rs['data']['skin'];
          body = rs['data']['body'];
        });
      }
    }
  }

  void getDetail(id) async {
    var rs = await get('HealthSearch', data: {
      'type': 'check',
      'pid': id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        list = rs['res'];
        state(() {});
      }
    }
  }

  List<Widget> listWidget(Map d) {
    List<Widget> rs = [];
    for (var v in list) {
      rs.add(one(v, d['id']));
    }
    return rs;
  }

  void show(Map data) async {
    showCupertinoDialog(
        context: context,
        builder: (_) =>
            StatefulBuilder(builder: (_, s) {
              this.state = s;
              return CupertinoAlertDialog(
                title: Text('${data['body']}'),
                content: SizedBox(
                  height: 200,
                  child: ListView(
                    children: <Widget>[
                      Wrap(
                        children: list != null && list.length > 0
                            ? listWidget(data)
                            : [
                          Center(
                              child:
                              list == null ? loading() : Text('暂无数据'))
                        ],
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('确定'),
                    onPressed: () {
                      back(context);
                    },
                  ),
                ],
              );
            }));
  }

  Widget one(Map v, int id) {
    bool yes = isCheck(id, v['id']);
    return GestureDetector(
      onTap: () {
        bool zt = false;
        check.forEach((k, y) {
          if (k == id) {
            List y2 = y;
            int i = y2.indexOf(v['id']);
            zt = true;
            if (i >= 0) {
              y2.removeAt(i);
            } else {
              y2.add(v['id']);
            }
            /*if(y2.length==0){
              check.remove(k);
            }*/
            return;
          }
        });
        if (!zt) {
          check[id] = [v['id']];
        }
        state(() {});
        setState(() {});
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            getImg(yes ? 'radio_yes' : 'radio_no'),
            height: 20,
            color: yes ? c1 : textColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${v['body']}',
                style: TextStyle(color: yes ? c1 : textColor, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  bool isCheck(int id, id2) {
    bool zt = false;
    check.forEach((k, v) {
      if (id == k) {
        if (v.indexOf(id2) >= 0) {
          zt = true;
          return;
        }
      }
    });
    return zt;
  }

  void sub() async {
    List data = [];
    check.forEach((k, v) {
      if (v.length > 0) {
        List l = [];
        for (var x in v) {
          l.add(x);
        }
        l.add(k);
        data.add(l);
      }
    });
    if (data.length == 0) {
      return tip(context, '请选择问题');
    }
    var rs = await post(widget.id==-1?'HealthSearch':'HealthyAdd', data: {'data': data, 'mid': widget.id});
    if (rs != null) {
      if (rs['code'] == 1) {
        if(widget.id==-1){
          Navigator.pop(context, rs['res'].toString());
          return;
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>
            AddArchives2(int.parse(rs['arc'].toString()), widget.id)));
        /*jump2(
            context, AddArchives2(int.parse(rs['arc'].toString()), widget.id));*/
      }
    }
  }
}
