import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';

class EarlyWarning extends StatefulWidget {
  @override
  _EarlyWarningState createState() => _EarlyWarningState();
}

class _EarlyWarningState extends State<EarlyWarning> {
  List list;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('warning_detail');
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res']['ware_details'];
        });
      }
    }
    //print(rs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('仓库预警'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('前往仓库'),
              onPressed: () {
                jump(context, 'ware_list');
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: bg2,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(child: Text('品项')),
                  flex: 2,
                ),
                Expanded(child: Center(child: Text('商品名称')), flex: 2),
                Expanded(child: Center(child: Text('库存余量'))),
              ],
            ),
          ),
          Expanded(
              child: list != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    )
                  : Center(
                      child: loading(),
                    ))
        ],
      ),
    );
  }

  String getName(int c) {
    String str = '';
    if (c == 1) {
      str = '产品';
    } else if (c == 2) {
      str = '套盒';
    } else if (c == 3) {
      str = '耗材';
    } else if (c == 4) {
      str = '内衣';
    }
    return str;
  }

  Widget _item(int i) => Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 60,
            color: bg2,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Text(
                      '${getName(list[i]['cate'])}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ))),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Text('${list[i]['name']}',
                            maxLines: 1, overflow: TextOverflow.ellipsis))),
                Expanded(
                    child: Center(
                        child: Text('${list[i]['stock']}',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis))),
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      );
}
