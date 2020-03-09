import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/warehouse/change.dart';
import 'package:myh_shop/app/main/warehouse/inventory.dart';
import 'package:myh_shop/app/main/warehouse/out_in.dart';
import 'package:myh_shop/app/main/warehouse/out_in_logs.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class WareManage extends StatelessWidget {
  final int id;

  WareManage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('仓库管理'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('出入库管理/其他设置'),
            leading: Icon(Icons.home, color: c1),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(context, OutIn(id));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            title: Text('出入库流水记录'),
            leading: Icon(Icons.home, color: c1),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(context, OutInLogs(id));
            },
          ),
          Divider(
            height: 0,
          ),
          /*ListTile(
              title: Text('进销存汇总表'),
              leading: Icon(Icons.home, color: c1),
              trailing: Icon(Icons.chevron_right)),
          Divider(
            height: 0,
          ),*/
          ListTile(
            title: Text('商品调仓'),
            leading: Icon(Icons.home, color: c1),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(context, Change(id));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            title: Text('库存盘点'),
            leading: Icon(Icons.home, color: c1),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(context, Inventory(id));
            },
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
