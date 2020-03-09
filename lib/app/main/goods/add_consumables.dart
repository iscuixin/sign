import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';

class AddConsumables extends StatefulWidget {
  final Map data;

  const AddConsumables({Key key, this.data}) : super(key: key);

  @override
  _AddConsumablesState createState() => _AddConsumablesState();
}

class _AddConsumablesState extends State<AddConsumables> {
  int type = 2;
  List classify = [];
  TextEditingController _snCon = TextEditingController(text: '');
  TextEditingController _nameCon = TextEditingController(text: '');
  TextEditingController _kcCon = TextEditingController(text: '');
  TextEditingController _oneCon = TextEditingController(text: '');
  TextEditingController _oneXhCon = TextEditingController(text: '');
  Map now;

  void delData() async {
    var rs = await post('con_operation', data: {
      'id': widget.data['id'],
      'type': 'del',
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text(widget.data==null?'添加耗材':'编辑耗材'),
        actions: <Widget>[
          CupertinoButton(child: Text('删除', style: TextStyle(color: Colors.red),), onPressed: () async {
            var rs = await showAlert(context, '是否删除？');
            if(rs){
              delData();
            }
          })
        ],
      ),
      body: ListView(
        children: <Widget>[
          MyItem(
            child: MyRadio(
              enable: widget.data==null?true:false,
              value: type,
              text2: '非固定',
              text: '固定',
              onChanged: (v) {
                setState(() {
                  type = v;
                });
              },
            ),
            label: '耗材类型',
          ),
          MyInput2(
            controller: _snCon,
            label: '耗材编号',
            hintText: '请填写耗材编号(非必填)',
          ),
          MyInput2(
            controller: _nameCon,
            label: '耗材名称',
            hintText: '请填写耗材名称',
          ),
          MyInput2(
            onChanged: (v) {
              setState(() {});
            },
            controller: _kcCon,
            label: '库$kg存',
            enabled: widget.data==null?true:false,
            hintText: '请填写库存',
          ),
          Offstage(
            offstage: type == 1 ? true : false,
            child: Column(
              children: <Widget>[
                MyInput2(
                  onChanged: (v) {
                    setState(() {});
                  },
                  controller: _oneCon,
                  label: '单个容量',
                  hintText: '请填写耗材容量',
                ),
                GestureDetector(
                  onTap: () {
                    if (classify.length > 0) {
                      showMyPicker(context);
                      if (now == null) {
                        setState(() {
                          now = classify[0];
                        });
                      }
                    }
                  },
                  child: MyItem(
                    child: Text(
                      now == null ? '点击选择' : '${now['spec']}(${now['name']})',
                      style: TextStyle(
                          color: now == null ? hintColor : Colors.black,
                          fontSize: 16),
                    ),
                    label: '规格类型',
                  ),
                ),
                MyInput2(
                  onChanged: (v) {
                    setState(() {});
                  },
                  controller: _oneXhCon,
                  label: '单次消耗',
                  hintText: '请填写单次消耗容量',
                ),
                MyItem(
                  child: Text(
                    '${getNum()}次(仅供参考)',
                  ),
                  label: '实用项目数',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
            child: Text('库存请在仓库修改', style: TextStyle(color: textColor),),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: MyButton(
              title: widget.data==null?'创建':'保存',
              onPressed: () {
                save();
              },
            ),
          )
        ],
      ),
    );
  }

  int getNum() {
    String kc = _kcCon.text;
    String one = _oneCon.text;
    String oneXh = _oneXhCon.text;
    if (kc.length > 0 && oneXh.length > 0 && one.length > 0) {
      return (double.parse(kc) * double.parse(one) / double.parse(oneXh))
          .truncate();
    }
    return 0;
  }

  void save() async {
    String name = _nameCon.text;
    String sn = _snCon.text;
    String kc = _kcCon.text;
    String one = _oneCon.text;
    String oneXh = _oneXhCon.text;
    if (type == 1) {
      if (name.length == 0 || kc.length == 0) {
        return tip(context, '请填完以上内容');
      }
    } else {
      if (name.length == 0 ||
          kc.length == 0 ||
          one.length == 0 ||
          oneXh.length == 0) {
        return tip(context, '请填完以上内容');
      }
    }
    Map d = {
      'number': sn,
      'name': name,
      'cost': '',
      'stock': kc,
      'spec': one,
      'spec_type': now == null ? '' : now['id'],
      'consumables_type': type,
      'one_consume': oneXh,
      'one_syxms': getNum(),
    };
    String t = 'add';
    if(widget.data!=null){
      t = 'modify';
      d['id'] = widget.data['id'];
    }
    var rs = await post('con_operation', data: {
      'data': d,
      'type': t
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.data!=null){
      type = widget.data['consumables_type'];
      _snCon.text = widget.data['number'].toString();
      _nameCon.text = widget.data['name'].toString();
      _kcCon.text = widget.data['stock'].toString();
      if(type==2){
        _oneCon.text = widget.data['spec'].toString();
        _oneXhCon.text = widget.data['one_consume'].toString();
      }
      setState(() {

      });
    }
    getSj();
  }

  void getSj() async {
    var rs = await get('get_spec');
    if (rs != null) {
      if(widget.data!=null){
        for(var v in rs['res']){
          if(v['id']==widget.data['spec_type']){
            now = v;
          }
        }
      }
      setState(() {
        classify = rs['res'];
      });
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
                        now = classify[v];
                      });
                    },
                    children: classify
                        .map((v) =>
                            Center(child: Text('${v['spec']}(${v['name']})')))
                        .toList()),
              ),
            ));
  }
}
