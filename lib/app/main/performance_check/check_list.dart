import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class CheckList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('业绩核对'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: (){
              jump(context, 'check_detail');
            },
            leading: Icon(
              Icons.date_range,
              color: c1,
            ),
            title: Text('每日业绩核对'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 0,),
          ListTile(
            onTap: (){
              jump(context, 'month');
            },
            leading: Icon(
              Icons.date_range,
              color: c1,
            ),
            title: Text('每月业绩核对'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 0,),
          ListTile(
            onTap: (){
              jump(context, 'no_commission');
            },
            leading: Icon(
              Icons.date_range,
              color: c1,
            ),
            title: Text('消费未提成业绩'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 0,),
        ],
      ),
    );
  }
}
