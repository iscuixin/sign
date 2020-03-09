import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class WagesEdit extends StatefulWidget {
  final int id;

  const WagesEdit(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _WagesEditState createState() => _WagesEditState();
}

class _WagesEditState extends State<WagesEdit> {
  TextEditingController _dxCon = TextEditingController(text: '');
  TextEditingController _jjCon = TextEditingController(text: '');
  TextEditingController _tcCon = TextEditingController(text: '');
  TextEditingController _sgCon = TextEditingController(text: '');
  TextEditingController _jbCon = TextEditingController(text: '');
  TextEditingController _kfCon = TextEditingController(text: '');
  Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('工资调整'),
      ),
      body: ListView(
        children: <Widget>[
          MyInput2(
            label: '工资计算',
            enabled: false,
            hintText: '¥${getTotal()}',
            hintStyle: TextStyle(color: Colors.black),
          ),
          MyInput2(
            controller: _dxCon,
            onChanged: (v) {
              data['salary'] = v;
              setState(() {

              });
            },
            label: '底$kg薪',
            hintText: '¥0.00',
          ),
          MyInput2(
            controller: _jjCon,
            onChanged: (v) {
              data['bonus'] = v;
              setState(() {

              });
            },
            label: '奖$kg金',
            hintText: '¥0.00',
          ),
          MyInput2(
            controller: _tcCon,
            onChanged: (v) {
              data['commission'] = v;
              setState(() {

              });
            },
            label: '提$kg成',
            hintText: '¥0.00',
          ),
          MyInput2(
            controller: _sgCon,
            onChanged: (v) {
              data['manual'] = v;
              setState(() {

              });
            },
            label: '手$kg工',
            hintText: '¥0.00',
          ),
          MyInput2(
            controller: _jbCon,
            onChanged: (v) {
              data['work_money'] = v;
              setState(() {

              });
            },
            label: '加$kg班',
            hintText: '¥0.00',
          ),
          MyInput2(
            controller: _kfCon,
            onChanged: (v) {
              data['amerce'] = v;
              setState(() {

              });
            },
            label: '扣$kg罚',
            hintText: '¥0.00',
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: MyButton(
              title: '确认调整',
              onPressed: () {
                edit();
              },
              height: 45,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('getWagesInfo', data: {
      'id': widget.id,
    });
    if (rs != null) {
      setState(() {
        data = rs['res'];
        _dxCon.text = data['salary'].toString();
        _jjCon.text = data['bonus'].toString();
        _tcCon.text = data['commission'].toString();
        _sgCon.text = data['manual'].toString();
        _jbCon.text = data['work_money'].toString();
        _kfCon.text = data['amerce'].toString();
      });
    }
  }

  void edit() async {
    var rs = await post('staffWages', data: {
      'data': data,
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
  }

  double getTotal() {
    if (data == null) {
      return 0;
    }
    return double.parse(data['salary'].toString().length==0?'0':data['salary'].toString()) +
        double.parse(data['bonus'].toString().length==0?'0':data['bonus'].toString()) +
        double.parse(data['commission'].toString().length==0?'0':data['commission'].toString()) +
        double.parse(data['manual'].toString().length==0?'0':data['manual'].toString()) +
        double.parse(data['work_money'].toString().length==0?'0':data['work_money'].toString()) +
        double.parse(data['amerce'].toString().length==0?'0':data['amerce'].toString());
  }
}
