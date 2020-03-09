import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:flutter/cupertino.dart' show CupertinoApp, CupertinoPicker, showCupertinoModalPopup;
import 'package:myh_shop/widget/MyRadio.dart';

class AddCp2 extends StatefulWidget {
  @override
  _AddCpState createState() => _AddCpState();
}

class _AddCpState extends State<AddCp2> {
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
              onPressed: () {},
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              showMyPicker(context);
            },
            child: MyItem(
              child: Text(
                '点击选择',
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              label: '类$kg 别',
            ),
          ),
          MyInput2(
            label: '产品编号',
            hintText: '请填写产品编号(非必填)',
          ),
          MyInput2(
            label: '产品名称',
            hintText: '请填写产品名称(必填)',
          ),
          MyItem(label: '单$kg 位', child: MyRadio(text: '件', text2: '套',)),
          MyInput2(
            label: '颜$kg色',
            hintText: '请填写产品颜色(红色)',
          ),
          InkWell(
            onTap: () {
              showMyPicker(context);
            },
            child: MyItem(
              child: Text(
                '点击选择',
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              label: '型$kg 号',
            ),
          ),
          InkWell(
            onTap: () {
              showMyPicker(context);
            },
            child: MyItem(
              child: Text(
                '点击选择',
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              label: '尺$kg 码',
            ),
          ),
          MyInput2(
            label: '销  售  价',
            hintText: '请填写销售价',
            suffixText: '元',
          ),
          MyInput2(
            label: '库$kg存',
            hintText: '请输入库存',
            suffixText: '件',
          ),
        ],
      ),
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
                  //print(v);
                },
                children: [
                  Center(child: Text('test')),
                  Center(child: Text('test')),
                  Center(child: Text('test')),
                  Center(child: Text('test')),
                ]),
          ),
        ));
  }
}
