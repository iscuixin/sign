import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class EditData extends StatefulWidget {
  final int type;
  final int id;

  const EditData(
    this.type,
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  Map detail;
  String need = '';
  String title = '';
  String all = '';
  String my = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text(title),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.only(top: 8, bottom: 8, right: 30, left: 30),
          child: MyButton(
            title: '确定修改',
            onPressed: () {
              edit();
            },
          ),
        ),
      ),
      body: detail != null
          ? ListView(
              children: <Widget>[
                MyInput2(
                  label: getName(),
                  hintText: all,
                  hintStyle: TextStyle(color: Colors.black),
                  enabled: false,
                ),
                MyInput2(
                  label: getName2(),
                  hintText: my,
                  hintStyle: TextStyle(color: Colors.black),
                  enabled: false,
                ),
                MyInput2(
                  onChanged: (v) {
                    need = v;
                  },
                  label: getName3(),
                  hintText: '请输入新的金额',
                  keyboardType: TextInputType.numberWithOptions(),
                ),
              ],
            )
          : Center(
              child: loading(),
            ),
    );
  }

  String getName() {
    String str = '';
    if(widget.type==1||widget.type==2||widget.type==4){
      str = '总业绩';
      all = detail['total_money'];
      my = detail['money'];
    }
    if(widget.type==3){
      str = '总手工';
      all = detail['total_fee'];
      my = detail['fee'];
    }
    return str;
  }

  String getName2() {
    String str = '';
    if(widget.type==1||widget.type==2||widget.type==4){
      str = '获得业绩';
    }
    if(widget.type==3){
      str = '获得手工';
    }
    return str;
  }

  String getName3() {
    String str = '';
    if(widget.type==1||widget.type==2||widget.type==4){
      str = '修改业绩';
    }
    if(widget.type==3){
      str = '修改手工';
    }
    return str;
  }

  void edit() async {
    if (need.length == 0) {
      return tip(context, '请输入新业绩');
    }
    if (double.parse(need) > double.parse(all)) {
      return tip(context, '不能超过总金额');
    }
    String fee = '';
    String money = '';
    if(widget.type==1||widget.type==2||widget.type==4){
      money = need;
    }
    if(widget.type==3){
      fee = need;
    }
    var rs = await post('raise_detail_operation', data: {
      'id': widget.id,
      'type': widget.type,
      'data': {
        'new_raise_fee': fee,
        'money': money,
      },
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
    if(widget.type==1){
      title = '消费业绩核对';
    }else if(widget.type==2){
      title = '消耗业绩核对';
    }else if(widget.type==3){
      title = '手工业绩核对';
    }else if(widget.type==4){
      title = '卡扣业绩核对';
    }
    getSj();
  }

  void getSj() async {
    var rs = await get('raise_detail_operation', data: {
      'id': widget.id,
      'type': widget.type,
    });
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          detail = rs['detail'];
        });
      }
    }
  }
}
