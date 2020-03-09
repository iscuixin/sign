import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoApp, CupertinoPicker, showCupertinoModalPopup;
import 'package:myh_shop/widget/MyInput3.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';
import 'package:myh_shop/widget/MyRadio2.dart';
import 'package:flutter/cupertino.dart';

class AddItem extends StatefulWidget {
  final int type;
  final int id;

  const AddItem({Key key, this.type = 1, this.id}) : super(key: key);

  @override
  _AddBoxState createState() => _AddBoxState();
}

class _AddBoxState extends State<AddItem> {
  List category = [];
  List list = [];
  Map now;
  int bind = 2;
  Map bindHc;
  TextEditingController _snCon = TextEditingController(text: '');
  TextEditingController _nameCon = TextEditingController(text: '');
  TextEditingController _priceCon = TextEditingController(text: '');
  TextEditingController _timeCon = TextEditingController(text: '');
  TextEditingController _feeCon = TextEditingController(text: '');
  TextEditingController _jsCon = TextEditingController(text: '');
  TextEditingController _dayCon = TextEditingController(text: '');
  int cycle = 1;
  int duration = 1;
  String end = '';

  void del() async {
    var rs = await post('delItems', data: {'id': widget.id});
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(widget.type == 1 ? '创建项目' : '项目编辑'),
        actions: <Widget>[
          Offstage(
            offstage: widget.type==1?true:false,
            child: CupertinoButton(
                child: Text(
                  '删除',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  var rs = await showAlert(context, '是否删除？');
                  if(rs){
                    del();
                  }
                }),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
            child: MyButton(
              title: widget.type == 1 ? '创建' : '确定修改',
              onPressed: () {
                if (widget.type == 1) {
                  add();
                } else {
                  update();
                }
              },
            ),
          ),
        ),
      ),
      body: ListView(
        //padding: EdgeInsets.all(10),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            color: bg2,
            child: Column(
              children: <Widget>[
                /*Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 60,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: hintColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.camera_alt,
                        color: hintColor,
                      ),
                    ),
                    Text(
                      '项目图片：建议尺寸 32*240',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.w500),
                    )
                  ],
                ),*/
                InkWell(
                  onTap: () {
                    if (category.length > 0) {
                      showMyPicker(context);
                      if (now == null) {
                        setState(() {
                          now = category[0];
                        });
                      }
                    }
                  },
                  child: MyItem(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      now == null ? '点击选择' : now['name'],
                      style: TextStyle(
                          fontSize: 16,
                          color: now == null ? textColor : Colors.black),
                    ),
                    label: '类$kg别',
                  ),
                ),
                Offstage(
                  offstage: widget.type == 1 ? false : true,
                  child: MyItem(
                      label: '绑定商品',
                      alignment: Alignment.centerLeft,
                      child: MyRadio(
                        value: bind,
                        onChanged: (v) {
                          setState(() {
                            bind = v;
                          });
                        },
                        text2: '否',
                        text: '是',
                      )),
                ),
                Offstage(
                  offstage: bind == 1 && widget.type == 1 ? false : true,
                  child: MyItem(
                    height: null,
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: list.map((v) => _item(v)).toList(),
                    ),
                    label: '耗$kg材',
                  ),
                ),
                MyInput2(
                  controller: _snCon,
                  label: '项目编号',
                  hintText: '请填写产品编号(非必填)',
                  alignment: Alignment.centerLeft,
                ),
                MyInput2(
                  controller: _nameCon,
                  label: '项目名称',
                  hintText: '请填写产品名称(必填)',
                  alignment: Alignment.centerLeft,
                ),
                MyInput2(
                  controller: _priceCon,
                  label: '价$kg格',
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: '请填写销售价(必填)',
                  suffixText: '元',
                  alignment: Alignment.centerLeft,
                ),
                /*MyInput2(
                  label: '库$kg存',
                  hintText: '请填写库存(必填)',
                  suffixText: '件',
                  alignment: Alignment.centerLeft,
                ),*/
                MyInput2(
                  controller: _timeCon,
                  label: '次$kg数',
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: '请填写次数(必填)',
                  suffixText: '次',
                  alignment: Alignment.centerLeft,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            color: bg2,
            child: Column(
              children: <Widget>[
                MyInput2(
                  controller: _feeCon,
                  label: '手  工  费',
                  keyboardType: TextInputType.numberWithOptions(),
                  hintText: '请填写项目手工费',
                  suffixText: '元',
                  alignment: Alignment.centerLeft,
                ),
                MyItem(
                    label: '护理周期',
                    alignment: Alignment.centerLeft,
                    child: MyRadio2(
                      value: cycle,
                      onChanged: (v) {
                        cycle = v;
                      },
                      widget: Text('每周一次'),
                      widget2: Row(
                        children: <Widget>[
                          Text('每'),
                          Container(
                            child: TextField(
                              controller: _dayCon,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5)),
                              textAlign: TextAlign.center,
                            ),
                            width: 30,
                            alignment: Alignment.center,
                          ),
                          Text('天1次')
                        ],
                      ),
                    )),
                MyItem(
                    label: '是否过期',
                    alignment: Alignment.centerLeft,
                    child: MyRadio(
                      value: duration,
                      onChanged: (v) {
                        setState(() {
                          duration = v;
                        });
                      },
                      text2: '是',
                      text: '否',
                    )),
                Offstage(
                  offstage: duration == 1 ? true : false,
                  child: InkWell(
                    onTap: () {
                      if (category.length > 0) {
                        showMyDate(context);
                      }
                    },
                    child: MyItem(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        end == '' ? '点击选择过期时间' : end,
                        style: TextStyle(
                            fontSize: 16,
                            color: end == '' ? textColor : Colors.black),
                      ),
                      label: '过期时间',
                    ),
                  ),
                ),
                MyItem(
                  label: '项目介绍',
                  alignment: Alignment.centerLeft,
                  child: Offstage(),
                  showLine: false,
                ),
                TextField(
                  maxLines: null,
                  controller: _jsCon,
                  decoration: InputDecoration(
                      hintText: '请填写项目介绍',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hintColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hintColor))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void add() async {
    String sn = _snCon.text;
    String name = _nameCon.text;
    String price = _priceCon.text;
    String time = _timeCon.text;
    String fee = _feeCon.text;
    String day = _dayCon.text;
    if (price.length == 0 ||
        name.length == 0 ||
        time.length == 0 ||
        fee.length == 0 ||
        now == null) {
      return tip(context, '请填完以上内容');
    }
    List hc = [];
    for (var v in list) {
      if (v['zt']) {
        hc.add(v['id']);
      }
    }
    if (bind == 1) {
      if (hc.length == 0) {
        return tip(context, '请选择耗材');
      }
    }
    if (cycle == 2) {
      if (day.length == 0) {
        return tip(context, '请输入护理周期');
      }
    }
    if (duration == 2) {
      if (end.length == 0) {
        return tip(context, '请选择过期时间');
      }
    }
    var rs = await post('NewItem', data: {
      'data': {
        'cateId': now['id'],
        'cycle': cycle,
        'days': day,
        'duration': duration,
        'fee': fee,
        'frequency': time,
        'is_bind': bind,
        'name': name,
        'price': price,
        'sn': sn,
        'spec_id': bind == 1 ? hc : [],
        'end': duration == 1 ? end : '',
        'introduce': _jsCon.text,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  void update() async {
    String sn = _snCon.text;
    String name = _nameCon.text;
    String price = _priceCon.text;
    String time = _timeCon.text;
    String fee = _feeCon.text;
    String day = _dayCon.text;
    if (price.length == 0 ||
        name.length == 0 ||
        time.length == 0 ||
        fee.length == 0 ||
        now == null) {
      return tip(context, '请填完以上内容');
    }
    if (cycle == 2) {
      if (day.length == 0) {
        return tip(context, '请输入护理周期');
      }
    }
    if (duration == 2) {
      if (end.length == 0) {
        return tip(context, '请选择过期时间');
      }
    }
    var rs = await post('update_items', data: {
      'data': {
        'category_id': now['id'],
        'cycle': cycle,
        'days': cycle == 1 ? 7 : day,
        'duration': duration,
        'fee': fee,
        'frequency': time,
        'is_bind': bind,
        'pro_name': name,
        'price': price,
        'sn': sn,
        'end_time': duration == 2 ? end : '',
        'img': '',
        'introduce': _jsCon.text,
        'id': widget.id,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
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
                        now = category[v];
                      });
                    },
                    children: category
                        .map((v) => Center(child: Text(v['name'])))
                        .toList()),
              ),
            ));
  }

  void showMyPicker2(BuildContext context) async {
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
                        now = list[v];
                      });
                    },
                    children: list
                        .map((v) => Center(child: Text(v['name'])))
                        .toList()),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == 1) {
      getSj();
    } else {
      getDetail();
    }
  }

  void getDetail() async {
    var rs = await get('update_items', data: {'item': widget.id});
    if (rs != null) {
      //print(rs);
      category = rs['res']['category'];
      Map d = rs['res']['updateArr'];
      for (var v in category) {
        if (v['id'] == d['category_id']) {
          now = v;
          break;
        }
      }
      _snCon.text = d['sn'] == null ? '' : d['sn'].toString();
      _nameCon.text = d['pro_name'].toString();
      _priceCon.text = d['price'].toString();
      _timeCon.text = d['frequency'].toString();
      _feeCon.text = d['fee'].toString();
      _jsCon.text = d['introduce'] == null ? '' : d['introduce'].toString();
      if (d['duration'] == 1) {
        end = d['end_time'];
        print(end);
        duration = 2;
      }
      if (d['cycle'] == 2 && d['days'] != 7) {
        _dayCon.text = d['days'].toString();
        cycle = 2;
      }
      setState(() {});
    }
  }

  void getSj() async {
    var rs = await get(
      'getCategory',
    );
    if (rs != null) {
      List l = rs['res']['list'];
      for (var v in l) {
        v['zt'] = false;
      }
      setState(() {
        list = l;
        category = rs['res']['category'];
      });
    }
  }

  Widget _item(Map v) {
    return GestureDetector(
      onTap: () {
        setState(() {
          v['zt'] = !v['zt'];
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            getImg(v['zt'] ? 'radio_yes' : 'radio_no'),
            height: 20,
            color: c1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(v['name'],
                style: TextStyle(color: textColor, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void showMyDate(BuildContext context,
      {bool showTitleActions = false,
      DateTime minTime,
      DateTime maxTime}) async {
    DatePicker.showDatePicker(context,
        showTitleActions: showTitleActions,
        maxTime: maxTime,
        minTime: DateTime(min),
        currentTime: DateTime.now(),
        locale: LocaleType.zh, onChanged: (DateTime d) {
      setState(() {
        end = '${d.year}-${d.month}-${d.day}';
      });
    });
  }
}
