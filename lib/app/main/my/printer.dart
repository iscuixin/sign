import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class Printer extends StatefulWidget {
  @override
  _PrinterState createState() => _PrinterState();
}

class _PrinterState extends State<Printer> {
  Map data;
  TextEditingController _controller = TextEditingController(text: '');
  TextEditingController _controller2 = TextEditingController(text: '');
  TextEditingController _controller3 = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('打印机设置'),
      ),
      body: ListView(
        children: <Widget>[
          MyInput2(label: '打印标题', controller: _controller,),
          MyInput2(label: '打印机编号', controller: _controller2,),
          MyInput2(label: '打印机密钥', controller: _controller3,),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('注：编号及密钥请在打印机背后查看，没有则不填', style: TextStyle(color: textColor),),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: MyButton(onPressed: () {
              save();
            }, title: '保存设置', height: 45,),
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
    var rs = await get('print_set');
    if(rs!=null){
      if(rs['code']==1){
        _controller.text = rs['res']['print_title'].toString();
        _controller2.text = rs['res']['sn'].toString();
        _controller3.text = rs['res']['key'].toString();
      }
    }
  }

  void save() async {
    /*if(_controller.text.length==0 || _controller2.text.length==0 || _controller3.text.length==0){
      return tip(context, '请填完以上内容');
    }*/
    var rs = await post('print_set', data: {
      'data': {
        'key': _controller3.text,
        'print_title': _controller.text,
        'sn': _controller2.text,
      }
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }else{
        tip(context, rs['error']);
      }
    }
  }
}
