import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class EditItems extends StatefulWidget {
  final int id;
  final String type;

  const EditItems(
    this.id,
    this.type, {
    Key key,
  }) : super(key: key);

  @override
  _EditItemsState createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  Map detail;
  TextEditingController _priceCon = TextEditingController(text: '');
  TextEditingController _numCon = TextEditingController(text: '');
  TextEditingController _num2Con = TextEditingController(text: '');
  TextEditingController _feeCon = TextEditingController(text: '');
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text(title),
      ),
      body: detail != null
          ? ListView(
              children: <Widget>[
                MyInput2(
                  label: '名$kg称',
                  hintText: '10.0',
                  hintStyle: TextStyle(color: Colors.black),
                  enabled: false,
                ),
                MyInput2(
                  controller: _priceCon,
                  label: '购$kg价',
                  hintStyle: TextStyle(color: Colors.black),
                  suffixText: '元',
                ),
                MyInput2(
                  controller: _numCon,
                  label: '原本次数',
                  hintStyle: TextStyle(color: Colors.black),
                  suffixText: '次',
                ),
                MyInput2(
                  controller: _num2Con,
                  label: '剩余次数',
                  hintStyle: TextStyle(color: Colors.black),
                  suffixText: '次',
                ),
                MyInput2(
                  controller: _feeCon,
                  label: '手$kg工',
                  hintStyle: TextStyle(color: Colors.black),
                  suffixText: '元',
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: MyButton(
                    title: '保存',
                    onPressed: () {
                      sub();
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: loading(),
            ),
    );
  }

  void sub() async {
    String price = _priceCon.text;
    String num = _numCon.text;
    String num2 = _num2Con.text;
    String fee = _feeCon.text;
    var rs = await post('MemberBoxItemsM', data: {
      'id': widget.id,
      'type': widget.type,
      'data': {
        'current_num': num2,
        'fee': fee,
        'originally_num': num,
        'price': price,
      },
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  void getSj() async {
    var rs = await get('MemberBoxItemsM', data: {
      'id': widget.id,
      'type': widget.type,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          detail = rs['detail'];
          _priceCon.text = detail['price'].toString();
          _numCon.text = detail['originally_num'].toString();
          _num2Con.text = detail['current_num'].toString();
          _feeCon.text = detail['fee'].toString();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.type=='items'){
      title = '会员项目编辑';
    }else if(widget.type=='box'){
      title = '会员套盒编辑';
    }
    setState(() {

    });
    getSj();
  }
}
