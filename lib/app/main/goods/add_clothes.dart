import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoApp, CupertinoPicker, showCupertinoModalPopup;
import 'package:myh_shop/widget/MyRadio.dart';
import 'package:flutter/cupertino.dart';

class AddClothes extends StatefulWidget {
  final int id;

  const AddClothes({Key key, this.id}) : super(key: key);

  @override
  _AddCpState createState() => _AddCpState();
}

class _AddCpState extends State<AddClothes> {
  List classify = [];
  Map now;
  Map data = {
    'sn': '',
    'name': '',
    'cup': '',
    'size': '',
    'color': '',
    'price': '',
    'sum': '',
    'unit': null,
    'type': 1,
  };
  TextEditingController _snCon = TextEditingController(text: '');
  TextEditingController _nameCon = TextEditingController(text: '');
  TextEditingController _cupCon = TextEditingController(text: '');
  TextEditingController _sizeCon = TextEditingController(text: '');
  TextEditingController _colorCon = TextEditingController(text: '');
  TextEditingController _priceCon = TextEditingController(text: '');
  TextEditingController _sumCon = TextEditingController(text: '');
  List list = [
    {'id': 1, 'name': '件'},
    {'id': 2, 'name': '条'},
    {'id': 3, 'name': '双'},
    {'id': 4, 'name': '套'},
  ];
  Map dw;
  Map detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('创建内衣'),
        actions: <Widget>[
          widget.id!=null?CupertinoButton(
              child: Text(
                '删除',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: ()async{
                bool rs = await showAlert(context, '是否删除？');
                if(rs){
                  delData();
                }
              }):Offstage()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
            child: MyButton(
              title: '保存',
              onPressed: () {
                if(widget.id==null){
                  create();
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
          MyItem(
              label: '类$kg型',
              child: MyRadio(
                text: '胸衣',
                text2: '其他',
                value: data['type'],
                onChanged: (v) {
                  data['type'] = v;
                  setState(() {

                  });
                },
              )),
          MyInput2(
            controller: _snCon,
            label: '编$kg号',
            hintText: '请填写编号(非必填)',
            onChanged: (v) {
              data['sn'] = v;
            },
          ),
          MyInput2(
            controller: _nameCon,
            label: '名$kg称',
            hintText: '请填写名称',
            onChanged: (v) {
              data['name'] = v;
            },
          ),
          GestureDetector(
            onTap: () {
              show(context);
              data['unit'] = list[0];
              setState(() {});
            },
            child: MyItem(
                label: '单$kg位',
                child: Text(
                  data['unit'] == null ? '点击选择单位' : data['unit']['name'],
                  style: TextStyle(
                      color: data['unit'] == null ? hintColor : Colors.black,
                      fontSize: 16),
                )),
          ),
          MyInput2(
            controller: data['type'] == 1 ? _cupCon : _sizeCon,
            label: '尺$kg码',
            hintText: '请填写尺码',
            onChanged: (v) {
              data['cup'] = v;
            },
          ),
          MyInput2(
            controller: _colorCon,
            label: '颜$kg色',
            hintText: '请填写颜色',
            onChanged: (v) {
              data['color'] = v;
            },
          ),
          MyInput2(
            controller: _priceCon,
            label: '售$kg价',
            hintText: '请填写售价',
            keyboardType: TextInputType.numberWithOptions(),
            suffixText: '元',
            onChanged: (v) {
              data['price'] = v;
            },
          ),
          MyInput2(
            controller: _sumCon,
            label: '库$kg存',
            keyboardType: TextInputType.numberWithOptions(),
            hintText: '请输入库存',
            suffixText: '件',
            onChanged: (v) {
              data['sum'] = v;
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.id == null) {
    } else {
      getDetail();
    }
  }

  void getDetail() async {
    var rs = await get('get_under_detail', data: {'id': widget.id});
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          detail = rs['res'];
          _snCon.text = detail['sn'].toString();
          _nameCon.text = detail['name'].toString();
          _sizeCon.text = detail['size'].toString();
          _cupCon.text = detail['cup'].toString();
          _colorCon.text = detail['color'].toString();
          _sumCon.text = detail['sum'].toString();
          _priceCon.text = detail['price'].toString();
          data['unit'] = detail['unit'] == 1
              ? list[0]
              : detail['unit'] == 2 ? list[1] : list[3];
          data['type'] = detail['type'];
        });
      }
    }
  }

  void delData() async {
    var rs = await post('underwear_operation', data: {
      'types': 'del',
      'data': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  void getSj() async {
    var rs = await get('get_box_cate', data: {'type': 1});
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          classify = rs['res'];
        });
      }
    }
  }

  void show(BuildContext context) async {
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
                        data['unit'] = list[v];
                      });
                    },
                    children: list
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }

  void create() async {
    if (data['name'].toString().length == 0 ||
        data['price'].toString().length == 0 ||
        data['sum'].toString().length == 0 ||
        data['unit'] == null ||
        data['cup'].toString().length == 0) {
      return tip(context, '请填完以上内容');
    }
    var d = {
      'sn': data['sn'],
      'name': data['name'],
      'cup': data['cup'],
      'size': data['size'],
      'color': data['color'],
      'price': data['price'],
      'sum': data['sum'],
      'unit': data['unit']['id'],
      'type': data['type'],
    };
    var rs =
        await post('underwear_operation', data: {'data': d, 'types': 'add'});
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  void edit() async {
    String sn = _snCon.text;
    String name = _nameCon.text;
    String cup = _cupCon.text;
    String size = _sizeCon.text;
    String color = _colorCon.text;
    String price = _priceCon.text;
    String sum = _sumCon.text;
    if (sn.length == 0 ||
        price.length == 0 ||
        sum.length == 0 ||
        data['unit'] == null) {
      return tip(context, '请填完以上内容');
    }
    if (data['type'] == 1) {
      if (cup.length == 0) {
        return tip(context, '请输入尺码');
      }
    } else {
      if (size.length == 0) {
        return tip(context, '请输入尺码');
      }
    }
    var rs = await post('underwear_operation', data: {
      'data': {
        'sn': sn,
        'color': color,
        'cup': cup,
        'id': widget.id,
        'name': name,
        'price': price,
        'size': size,
        'sum': sum,
        'type': data['type'],
        'unit': data['unit']['id'],
      },
      'types': 'modify'
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }
}
