import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class CountLogs extends StatefulWidget {
  final String type;
  final int state;

  const CountLogs(this.type, {Key key, this.state}) : super(key: key);

  @override
  _CountLogsState createState() => _CountLogsState();
}

class _CountLogsState extends State<CountLogs> {
  List list;
  String input = '';
  String title = '';

  @override
  void initState() {
    super.initState();
    if (widget.type == 'pro') {
      title = '产品';
    }
    if (widget.type == 'box') {
      title = '套盒';
    }
    if (widget.type == 'items') {
      title = '项目';
    }
    if (widget.type == 'card') {
      title = '卡项';
    }
    if (widget.type == 'plan') {
      title = '方案';
    }
    getSj();
  }

  void getSj() async {
    var rs = await get('buy_detail_list', data: {
      'start': '',
      'end': '',
      'type': widget.type,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        //print(rs['res']);
        list = rs['res'];
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(title+'记录'),
        /*actions: <Widget>[
          CupertinoButton(
              child: Text(
                '选择日期查询',
              ),
              onPressed: () {})
        ],*/
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
              child: MyInput(
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
                hintText: '输入姓名',
                onChanged: (v) {
                  setState(() {
                    input = v;
                  });
                },
              ),
            ),
            preferredSize: Size(getRange(context), 55)),
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

  Widget _item(i) {
    if (input.length > 0) {
      if (list[i]['v_name']
              .toString()
              .toLowerCase()
              .indexOf(input.toLowerCase()) <
          0) {
        return Offstage();
      }
    }
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        decoration:
            BoxDecoration(color: bg2, borderRadius: BorderRadius.circular(10)),
        width: getRange(context),
        height: 120,
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${list[i]['v_name']}'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '总金额',
                      style: TextStyle(color: textColor),
                    ),
                    Text('${list[i]['total_price']}')
                  ],
                )
              ],
            )),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: '名称：',
                              children: [
                                TextSpan(
                                    text: '${list[i]['name']}',
                                    style: TextStyle(color: Colors.black)),
                              ],
                              style: TextStyle(color: textColor))),
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              '实际支付',
                              style: TextStyle(color: textColor),
                            ),
                            Text('${list[i]['money']}')
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Icon(Icons.chevron_right),
                        )
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
      onTap: () {
        showModel(list[i]);
      },
    );
  }

  void showModel(Map v) {
    showDialog(
        context: context,
        builder: (_) => Container(
              margin: EdgeInsets.only(
                  top: getRange(context, type: 2) / 3 - 50,
                  bottom: getRange(context, type: 2) / 3 - 50,
                  left: 15,
                  right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Scaffold(
                  backgroundColor: bg2,
                  appBar: MyAppBar(
                    title: Text('支付详情'),
                    leading: Offstage(),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            back(context);
                          })
                    ],
                  ),
                  body: Container(
                    padding: EdgeInsets.all(15),
                    color: bg2,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _item2('余额', '${v['account_pay'] ?? 0}'),
                            _item2('卡扣', '${v['card_pay'] ?? 0}'),
                            _item2('现金', '${v['cash_pay'] ?? 0}'),
                            _item2('微信', '${v['wx_pay'] ?? 0}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _item2('支付宝', '${v['zfb_pay'] ?? 0}'),
                            _item2('银行卡', '${v['bank'] ?? 0}'),
                            _item2('美团', '${v['mt'] ?? 0}'),
                            _item2('大众点评', '${v['dz'] ?? 0}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _item2('收钱吧', '${v['account_pay'] ?? 0}'),
                            _item2('优惠券', '${v['card_pay'] ?? 0}'),
                            _item2('亚索', '1'),
                            _item2('亚索', '1'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget _item2(String name, p) => Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                  color: name == '亚索' ? Colors.transparent : textColor),
            ),
            Text(
              p,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: name == '亚索' ? Colors.transparent : Colors.black),
            ),
          ],
        ),
      );
}
