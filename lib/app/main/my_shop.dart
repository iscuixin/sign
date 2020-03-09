import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';

class MyShop extends StatefulWidget {
  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> {
  List list;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_branch');
    if (rs != null) {
      if (rs['code'] == 1) {
//        print(rs);
        setState(() {
          list = rs['res']['child'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('我的分店'),
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

  Widget _item(int i) => Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '${list[i]['name']} (${list[i]['store_type'] == 1 ? '主' : '分'})',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '负责人：${list[i]['manager_name']}',
                        style: TextStyle(fontSize: 15, color: textColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text('负责人手机：${list[i]['mobile']}',
                            style: TextStyle(fontSize: 15, color: textColor)),
                      ),
                    ],
                  )),
                  MyButton(
                    title: userModel.loginData['sid']==list[i]['sid'] ? '当前店铺' : '进入店铺',
                    onPressed: userModel.loginData['sid']==list[i]['sid']? null
                        : () {
                            change(list[i]['sid']);
                          },
                    width: 80,
                    height: 30,
                    titleStyle: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Divider(
              height: 0,
            ),
          ],
        ),
        height: 80,
        color: bg2,
      );

  void change(int id) async {
    var rs = await post('switch_store', data: {'id': id});
    if (rs != null) {
      if (rs['code'] == 1) {
        getSj();
        userModel.loginData = rs['res'];
        ok(context, rs['Msg']);
      }
    }
  }
}
