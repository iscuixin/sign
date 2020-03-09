import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoApp, CupertinoPicker, showCupertinoModalPopup;
import 'package:myh_shop/widget/MyRadio.dart';

class AddCp extends StatefulWidget {
  @override
  _AddCpState createState() => _AddCpState();
}

class _AddCpState extends State<AddCp> {
  List classify = [];
  Map now;
  Map data = {
    'sn': '',
    'goods_name': '',
    'price': '',
    'stock': '',
    'category': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('创建产品'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
            child: MyButton(
              title: '创建',
              onPressed: () {
                create();
              },
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          MyInput2(
            label: '产品编号',
            hintText: '请填写产品编号(非必填)',
            onChanged: (v) {
              data['sn'] = v;
            },
          ),
          MyInput2(
            label: '产品名称',
            hintText: '请填写产品名称',
            onChanged: (v) {
              data['goods_name'] = v;
            },
          ),
          MyInput2(
            label: '销  售  价',
            hintText: '请填写销售价',
            suffixText: '元',
            onChanged: (v) {
              data['price'] = v;
            },
          ),
          MyInput2(
            label: '库$kg存',
            hintText: '请输入库存',
            suffixText: '件',
            onChanged: (v) {
              data['stock'] = v;
            },
          ),
          InkWell(
            onTap: () {
              if (classify.length > 0) {
                showMyPicker(context);
                if (now == null) {
                  setState(() {
                    now = classify[0];
                    data['category'] = classify[0]['id'];
                  });
                }
              }
            },
            child: MyItem(
              child: Text(
                title(),
                style: TextStyle(
                    fontSize: 16,
                    color: now == null ? textColor : Colors.black),
              ),
              label: '类$kg别',
            ),
          ),
        ],
      ),
    );
  }

  String title() {
    if (classify.length == 0) {
      return '暂无类别';
    }
    if (now == null) {
      return '点击选择';
    }
    return now['name'];
  }

  @override
  void initState() {
    super.initState();
    getSj();
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
                        data['category'] = classify[v]['id'];
                      });
                    },
                    children: classify
                        .map(
                          (v) => Center(child: Text('${v['name']}')),
                        )
                        .toList()),
              ),
            ));
  }

  void create() async {
    if (data['goods_name'].toString().length == 0 ||
        data['price'].toString().length == 0 ||
        data['stock'].toString().length == 0 ||
        data['category'].toString().length == 0) {
      return tip(context, '请填完以上内容');
    }
    var rs = await post('addGoods', data: {'data': data});
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
    //print(rs);
  }
}
