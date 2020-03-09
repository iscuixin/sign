import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';

class AddArchives2 extends StatefulWidget {
  final int id;
  final int mid;
  final String type;

  const AddArchives2(
    this.id,
    this.mid, {
    Key key, this.type,
  }) : super(key: key);

  @override
  _AddArchives2State createState() => _AddArchives2State();
}

class _AddArchives2State extends State<AddArchives2> {
  List body = [];
  List face = [];
  List staff = [];
  List goods = [];
  List cate = [
    {'id': 1, 'name': '产品'},
    {'id': 2, 'name': '套盒'},
    {'id': 3, 'name': '项目'},
    {'id': 4, 'name': '方案'}
  ];
  Map nowCate;
  Map nowGoods;
  List cp = [];
  List items = [];
  List box = [];
  List plan = [];
  List check = [];
  String time;
  Map nowStaff;
  TextEditingController allergyCon = TextEditingController(text: '');
  TextEditingController skinOk = TextEditingController(text: '');
  TextEditingController bodyOk = TextEditingController(text: '');
  TextEditingController oneOpera = TextEditingController(text: '');
  TextEditingController remarks = TextEditingController(text: '');
  Map detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('处方添加'),
        actions: <Widget>[
          CupertinoButton(child: Text('删除', style: TextStyle(color: Colors.red),), onPressed: ()async{
            if(await showAlert(context, '是否确定删除？')){
              delData();
            }
          })
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 2, bottom: 2),
            child: MyButton(
              title: '保存',
              onPressed: (){
                if(widget.type==null){
                  sub();
                }else{
                  edit();
                }
              },
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('需要解决的皮肤问题'),
            subtitle: Wrap(
              children: face
                  .map((v) => Text('${v['title']}:${v['content']}'))
                  .toList(),
            ),
          ),
          ListTile(
            title: Text('需要解决的身体问题'),
            subtitle: Wrap(
              children: body
                  .map((v) => Text('${v['title']}:${v['content']}'))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: MyInput2(
              controller: allergyCon,
              alignment: Alignment.centerLeft,
              label: '过敏史',
              hintText: '请输入过敏史',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: MyInput2(
              controller: skinOk,
              label: '面部解决方案',
              hintText: '请输入面部解决方案',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: MyInput2(
              controller: bodyOk,
              label: '身体解决方案',
              hintText: '请输入身体解决方案',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: MyInput2(
              controller: oneOpera,
              label: '单次操作项目及手法',
              hintText: '请输入单次操作项目及手法',
            ),
          ),
          widget.type==null?Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        showMyPicker(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Text('${nowCate == null ? '' : nowCate['name']}'),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showGoods(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            nowGoods == null ? '点击选择' : nowGoods['name'].toString(),
                            style: TextStyle(
                                color: nowGoods == null ? hintColor : Colors.black,
                                fontSize: 16),
                          ),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    MyButton(
                      title: '选择',
                      onPressed: () {
                        if (nowCate != null && nowGoods != null) {
                          bool zt = false;
                          for (var v in check) {
                            if (v['id'] == nowGoods['id']) {
                              zt = true;
                              break;
                            }
                          }
                          if (!zt) {
                            check.add(nowGoods);
                            nowGoods = null;
                            setState(() {});
                          }
                        }
                      },
                      width: 70,
                      height: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Wrap(
                  children: check.map((v) => _item(v)).toList(),
                ),
              ),
              Divider(
                height: 0,
              ),
            ],
          ):Offstage(),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: MyItem(
              child: GestureDetector(
                child: Text(time == null ? '选择时间' : time,
                    style: TextStyle(
                        fontSize: 16,
                        color: time == null ? hintColor : Colors.black)),
                onTap: () {
                  showMyDate(context);
                },
              ),
              label: '下次预约时间',
            ),
          ),
          widget.type==null?GestureDetector(
            onTap: () {
              showStaff(context);
            },
            child: MyItem(
              child: Text(
                nowStaff == null ? '选择顾问' : nowStaff['name'],
                style: TextStyle(
                    fontSize: 16,
                    color: nowStaff == null ? hintColor : Colors.black),
              ),
              label: '顾$kg问',
            ),
          ):Offstage(),
          MyInput2(
            controller: remarks,
            label: '备$kg注',
            hintText: '请输入备注',
          ),
        ],
      ),
    );
  }

  void delData() async {
    var rs = await post('HealthyDel', data: {
      'aid': detail['id'],
      'mid': detail['mid'],
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
  }

  void edit() async {
    var rs = await post('HealthyModify', data: {
      'data': {
        'allergy': allergyCon.text,
        'id': detail['id'],
        'body': bodyOk.text,
        'face': skinOk.text,
        'mid': detail['mid'],
        'next_time': time,
        'one_opera': oneOpera.text,
        'remarks': remarks.text,
      }
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
  }

  void sub() async {
    List arr = [];
    if (time.length == 0) {
      return tip(context, '请选择下次预约时间');
    }
    for(var v in check) {
      arr.add({'cate': v['category'], 'design_id': v['id'], 'name': v['name']});
    }
    var rs = await post('prescrip_detail', data: {
      'data': {
        'allergy': allergyCon.text,
        'skin_ok': skinOk.text,
        'body_ok': bodyOk.text,
        'one_opera': oneOpera.text,
        'remarks': remarks.text,
        'gw': nowStaff==null?'':nowStaff['id'],
        'next_time': time,
      },
      'arc': widget.id,
      'mid': widget.mid,
      'design': arr,
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
    //print(rs);
  }

  Widget _item(Map v) {
    return GestureDetector(
      onTap: () {
        int i = 0;
        for (var x in check) {
          if (v['id'] == x['id']) {
            check.removeAt(i);
            setState(() {});
            break;
          }
          i++;
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Chip(label: Text(v['name'].toString())),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    nowCate = cate[0];
    if(widget.type==null){
      getSj();
    }else{
      getSj2();
    }
  }

  void getSj() async {
    var rs = await get('prescrip_detail', data: {
      'cate': nowCate['id'],
      'id': widget.id,
      'mid': widget.mid,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          staff = rs['res']['returnStaffArr'];
          if (nowCate['id'] == 1) {
            cp = rs['res']['all_goods'];
          } else if (nowCate['id'] == 2) {
            box = rs['res']['all_goods'];
          } else if (nowCate['id'] == 3) {
            items = rs['res']['all_goods'];
          } else if (nowCate['id'] == 4) {
            plan = rs['res']['all_goods'];
          }
          body = rs['res']['body_detail'];
          face = rs['res']['face_detail'];
        });
      }
    }
    //print(rs);
  }

  void getSj2() async {
    var rs = await post('prescription_detail', data: {
      'id': widget.id,
      'mid': widget.mid,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          body = rs['res']['body_detail'];
          face = rs['res']['face_detail'];
          allergyCon.text = rs['res']['res']['allergy'].toString();
          skinOk.text = rs['res']['res']['face'].toString();
          bodyOk.text = rs['res']['res']['body'].toString();
          oneOpera.text = rs['res']['res']['one_opera'].toString();
          remarks.text = rs['res']['res']['remarks'].toString();
          time = rs['res']['res']['next_time'];
          detail = rs['res']['res'];
        });
      }
    }
    //print(rs);
  }

  void showMyPicker(BuildContext context) async {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: getRange(context, type: 2) / 3,
              child: CupertinoApp(
                home: CupertinoPicker(
                    useMagnifier: true,
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1.2,
                    onSelectedItemChanged: (v) {
                      setState(() {
                        nowCate = cate[v];
                      });
                      getSj();
                    },
                    children: cate
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }

  void showGoods(BuildContext context) async {
    List data = [];
    String name = '';
    if (nowCate != null) {
      if (nowCate['id'] == 1) {
        data = cp;
      }
      if (nowCate['id'] == 2) {
        data = box;
      }
      if (nowCate['id'] == 3) {
        data = items;
      }
      if (nowCate['id'] == 4) {
        data = plan;
      }
    }
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: getRange(context, type: 2) / 3,
              child: CupertinoApp(
                home: CupertinoPicker(
                    useMagnifier: true,
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1.2,
                    onSelectedItemChanged: (v) {
                      if (nowCate['id'] == 1) {
                        data[v]['name'] = data[v]['goods_name'];
                        nowGoods = data[v];
                      }
                      if (nowCate['id'] == 2) {
                        data[v]['name'] = data[v]['box_name'];
                        nowGoods = data[v]['box_name'];
                      }
                      if (nowCate['id'] == 3) {
                        data[v]['name'] = data[v]['pro_name'];
                        nowGoods = data[v];
                      }
                      if (nowCate['id'] == 4) {
                        nowGoods = data[v];
                      }
                      setState(() {});
                    },
                    children: data.map((v) {
                      if (nowCate['id'] == 1) {
                        name = v['goods_name'];
                      }
                      if (nowCate['id'] == 2) {
                        name = v['box_name'];
                      }
                      if (nowCate['id'] == 3) {
                        name = v['pro_name'];
                      }
                      if (nowCate['id'] == 4) {
                        name = v['name'];
                      }
                      return Center(child: Text('$name'));
                    }).toList()),
              ),
            ));
  }

  void showStaff(BuildContext context) async {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: getRange(context, type: 2) / 3,
              child: CupertinoApp(
                home: CupertinoPicker(
                    useMagnifier: true,
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1.2,
                    onSelectedItemChanged: (v) {
                      setState(() {
                        nowStaff = staff[v];
                      });
                      getSj();
                    },
                    children: staff
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }

  void showMyDate(BuildContext context,
      {bool showTitleActions = true,
      DateTime minTime,
      DateTime maxTime}) async {
    DatePicker.showDatePicker(context,
        showTitleActions: showTitleActions,
        maxTime: maxTime,
        minTime: minTime,
        locale: LocaleType.zh, onConfirm: (DateTime d) {
      setState(() {
        time = '${d.year}-${d.month}-${d.day}';
        setState(() {});
      });
    });
  }
}
