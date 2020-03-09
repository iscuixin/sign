import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/pay.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';

class MyArrears extends StatefulWidget {
  final int id;

  const MyArrears(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _ArrearsState createState() => _ArrearsState();
}

class _ArrearsState extends State<MyArrears> {
  List list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('欠款详情'),
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
                ),
                Expanded(child: Center(child: Text('名称'))),
                Expanded(child: Center(child: Text('欠款'))),
                Expanded(
                  child: Center(child: Text('时间')),
                  flex: 2,
                ),
                Expanded(child: Center(child: Text('操作'))),
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

  Widget _item(int i) => Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 60,
            color: bg2,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Center(
                        child: Text(
                  '${getType(i)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))),
                Expanded(
                    child: Center(
                        child: Text(
                  '${list[i]['buy_name']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))),
                Expanded(
                    child: Center(
                        child: Text('${list[i]['money']}',
                            maxLines: 1, overflow: TextOverflow.ellipsis))),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Text('${list[i]['time']}',
                            style: TextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis))),
                MyButton(
                  title: '补款',
                  onPressed: ()async {
                    await jump2(context, Pay(list[i]['id'], 0));
                    getSj();
                  },
                  width: 60,
                  height: 30,
                  titleStyle: TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      );

  String getType(int i) {
    String px = '';
    if (list[i]['type'] == 1) {
      px = '产品';
    }
    if (list[i]['type'] == 2) {
      px = '套盒';
    }
    if (list[i]['type'] == 3) {
      px = '项目';
    }
    if (list[i]['type'] == 4) {
      px = '方案';
    }
    if (list[i]['type'] == 5) {
      px = '卡项';
    }
    if (list[i]['type'] == 6) {
      px = '内衣';
    }
    return px;
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('AloneArrears', data: {
      'mid': widget.id,
    });
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['list'];
        });
      }
    }
  }
}
