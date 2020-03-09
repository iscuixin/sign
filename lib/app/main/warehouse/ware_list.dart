import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/warehouse/manage.dart';
import 'package:myh_shop/app/main/warehouse/ware_setting.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';

class WareList extends StatefulWidget {
  @override
  _WareListState createState() => _WareListState();
}

class _WareListState extends State<WareList> {
  List list;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('WareList');
    if (rs != null) {
      setState(() {
        list = rs['res'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('仓库列表'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('仓库设置'),
              onPressed: () {
                jump2(context, WareSetting(1));
              })
        ],
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (_, i) => _item(i),
              itemCount: list.length,
            )
          : Center(
              child: loading(),
            ),
    );
  }

  Widget _item(i) => Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.home,
              color: c1,
            ),
            title: Text('${list[i]['name']}(${list[i]['ware_type']==1?'总仓':'分仓'})'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(context, WareManage(list[i]['id']));
            },
          ),
          Divider(
            height: 0,
          )
        ],
      );
}
