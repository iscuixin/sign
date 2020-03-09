import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';

class RechargeLogs extends StatefulWidget {
  final int id;

  const RechargeLogs(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _EarlyWarningState createState() => _EarlyWarningState();
}

class _EarlyWarningState extends State<RechargeLogs> {
  List list;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await post('RechargeRecord', data: {
      'mid': widget.id,
      'type': "balance",
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['record'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('余额充值记录'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: bg2,
            child: Row(
              children: <Widget>[
                Expanded(child: Center(child: Text('#'))),
                Expanded(child: Center(child: Text('类型'))),
                Expanded(child: Center(child: Text('金额'))),
                Expanded(child: Center(child: Text('赠送'))),
                Expanded(child: Center(child: Text('时间')), flex: 2,),
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
                      '${i+1}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ))),
                Expanded(
                    child: Center(
                        child: Text('${list[i]['type']==1?'余额':'卡项'}',
                            maxLines: 1, overflow: TextOverflow.ellipsis))),
                Expanded(
                    child: Center(
                        child: Text('${list[i]['money']}',
                            style: TextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis))),
                Expanded(
                    child: Center(
                        child: Text('${list[i]['send_money']}',
                            style: TextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis))),
                Expanded(
                  flex: 2,
                    child: Center(
                        child: Text('${list[i]['time']}',
                            style: TextStyle(),
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
