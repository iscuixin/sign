import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: bg2,
            child: ListTile(
              onTap: (){
                jump(context, 'edit_psw');
              },
              leading: Icon(
                Icons.lock,
                color: c1,
              ),
              title: Text('修改密码'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          GestureDetector(
            onTap: () async {
              var ok = await showAlert(context, '是否退出登录?');
              if(ok){
                logout(context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 50,
              color: bg2,
              alignment: Alignment.center,
              child: Text('退出登录', style: TextStyle(color: c1, fontSize: 16),),
            ),
          )
        ],
      ),
    );
  }
}
