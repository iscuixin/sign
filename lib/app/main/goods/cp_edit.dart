import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart'
    show
        CupertinoApp,
        CupertinoButton,
        CupertinoPicker,
        showCupertinoModalPopup;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';

class CpEdit extends StatefulWidget {
  final int id;

  const CpEdit(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _CpEditState createState() => _CpEditState();
}

class _CpEditState extends State<CpEdit> {
  List classify = [];
  Map detail;
  TextEditingController _snCon;
  TextEditingController _nameCon;
  TextEditingController _priceCon;
  TextEditingController _stockCon;
  Map now;

  void del() async {
    var rs = await post('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('产品信息编辑'),
        actions: <Widget>[
          CupertinoButton(
              child: Text(
                '删除',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                var rs = await showAlert(context, '是否删除?');
                if (rs) {
                  save(status: 2);
                }
              })
        ],
      ),
      body: detail != null
          ? ListView(
              children: <Widget>[
                MyInput2(
                  controller: _snCon,
                  label: '产品编号',
                  hintText: '请填写产品编号(非必填)',
                ),
                MyInput2(
                  controller: _nameCon,
                  label: '产品名称',
                  hintText: '请填写产品名称(必填)',
                ),
                MyInput2(
                  controller: _priceCon,
                  label: '销  售  价',
                  hintText: '请填写销售价',
                  suffixText: '元',
                ),
                /*MyInput2(
                  controller: _stockCon,
                  label: '库$kg存',
                  hintText: '请输入库存',
                  suffixText: '件',
                ),*/
                InkWell(
                  onTap: () {
                    if (classify.length > 0) {
                      showMyPicker(context);
                    }
                  },
                  child: MyItem(
                    child: Text(
                      now == null ? '点击选择' : now['name'],
                      style: TextStyle(
                          fontSize: 16,
                          color: now == null ? textColor : Colors.black),
                    ),
                    label: '类$kg别',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: MyButton(
                    title: '保存并修改',
                    onPressed: () {
                      save();
                    },
                    height: 45,
                  ),
                )
              ],
            )
          : Center(
              child: loading(),
            ),
    );
  }

  Widget _item(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          'img/radio_yes.png',
          height: 20,
          color: c1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(color: textColor, fontSize: 16)),
        ),
      ],
    );
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
                        .map((v) => Center(
                              child: Text(v['name']),
                            ))
                        .toList()),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    _snCon = TextEditingController(text: '');
    _nameCon = TextEditingController(text: '');
    _priceCon = TextEditingController(text: '');
    _stockCon = TextEditingController(text: '');
    getSj();
  }

  void getSj() async {
    var rs =
        await post('goodsModify', data: {'goods': widget.id, 'type': 'detail'});
    if (rs != null) {
      if (rs['code'] == 1) {
        classify = rs['res']['cate'];
        detail = rs['res']['detail'];
        for (var v in classify) {
          if (v['id'] == detail['category']) {
            now = v;
            break;
          }
        }
        setState(() {
          _snCon.text = detail['sn'].toString();
          _nameCon.text = detail['goods_name'].toString();
          _priceCon.text = detail['price'].toString();
          _stockCon.text = detail['stock'].toString();
        });
      }
    }
  }

  void save({status = 1}) async {
    if (_nameCon.text.length == 0 ||
        _priceCon.text.length == 0 ||
        _stockCon.text.length == 0 ||
        now == null) {
      return tip(context, '请填完以上内容');
    }
    var rs = await post('goodsModify', data: {
      'goods': widget.id,
      'status': status,
      'type': 'edit',
      'data': {
        'sn': _snCon.text,
        'goods_name': _nameCon.text,
        'category': now['id'],
        'stock': _stockCon.text,
      },
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }
}
