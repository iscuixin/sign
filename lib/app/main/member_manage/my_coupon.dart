import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';

class MyCoupon extends StatefulWidget {
  final int id;

  const MyCoupon(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _MyCouponState createState() => _MyCouponState();
}

class _MyCouponState extends State<MyCoupon> {
  List list;
  List list2 = [];
  int id = 0;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('HaveCoupon', data: {
      'mid': widget.id,
    });
    //print(rs['data']['list']);
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          list = rs['data']['res'];
          list2 = rs['data']['list'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('优惠券'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('赠送'),
              onPressed: () {
                if (list2.length > 0) {
                  showMyPicker(context);
                }
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: bg2,
            child: Row(
              children: <Widget>[
                Expanded(child: Center(child: Text('类型'))),
                Expanded(child: Center(child: Text('属性'))),
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

  void send() async {
    var rs = await post('send_coupon', data: {
      'id': id,
      'mid': widget.id,
    });
    if(rs!=null){
      if(rs['code']==1){
        getSj();
        ok(context, rs['Msg']);
      }
    }
  }

  void showMyPicker(BuildContext context) async {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: getRange(context, type: 2) / 3,
              child: CupertinoApp(
                  home: Column(
                children: <Widget>[
                  Container(
                    color: bg2,
                    height: 60,
                    width: getRange(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CupertinoButton(
                            child: Text('取消'),
                            onPressed: () {
                              back(context);
                            }),
                        CupertinoButton(child: Text('确定'), onPressed: () {
                          send();
                        }),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                        useMagnifier: true,
                        backgroundColor: Colors.white,
                        itemExtent: 30,
                        magnification: 1.2,
                        onSelectedItemChanged: (v) {
                          id = list2[v]['id'];
                        },
                        children: list2
                            .map((v) =>
                                Center(child: Text('${v['coupon_name']}')))
                            .toList()),
                  ),
                ],
              )),
            ));
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
                  '${list[i]['coupon_type']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))),
                Expanded(
                    child: Center(
                        child: Text('${list[i]['dedut']}',
                            maxLines: 1, overflow: TextOverflow.ellipsis))),
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
        ],
      );
}
