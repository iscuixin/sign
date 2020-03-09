import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class EditPsw extends StatefulWidget {
  @override
  _EditPswState createState() => _EditPswState();
}

class _EditPswState extends State<EditPsw> {
  String old = '';
  String newPwd = '';
  String newPwd2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('修改密码'),
      ),
      body: ListView(
        children: <Widget>[
          MyInput2(
            label: '原  密  码',
            hintText: '请输入原密码',
            onChanged: (v) {
              old = v;
            },
          ),
          MyInput2(
            label: '新  密  码',
            hintText: '请输入新密码',
            onChanged: (v) {
              newPwd = v;
            },
          ),
          MyInput2(
            label: '确认密码',
            hintText: '请确认新密码',
            onChanged: (v) {
              newPwd2 = v;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: MyButton(
              title: '确认设置',
              onPressed: () {
                edit();
              },
            ),
          ),
        ],
      ),
    );
  }

  void edit() async {
    if(old.length==0||newPwd.length==0||newPwd2.length==0){
      return tip(context, '请填完以上内容');
    }
    if(newPwd2 != newPwd){
      return tip(context, '2次密码不一致');
    }
    var rs = await post('ModifyPassword', data: {
      'orig': old,
      'password': newPwd,
      'confirm': newPwd2,
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
  }
}
