import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/classify.dart';
import 'package:myh_shop/app/main/come_shop/consumption_entry.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/model/come_shop.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:scoped_model/scoped_model.dart';

class ComeShop extends StatefulWidget {
  @override
  _ComeShopState createState() => _ComeShopState();
}

class _ComeShopState extends State<ComeShop> {
  List list;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ComeShopModel>(
      model: comeShopModel,
      child: ScopedModelDescendant<ComeShopModel>(builder: (_, __, v) {
        list = v.data;
        return Scaffold(
          appBar: MyAppBar(
            title: Text('到店管理'),
            leading: Offstage(),
            actions: <Widget>[
              CupertinoButton(
                  child: Text('到店添加'),
                  onPressed: () {
                    jump(context, 'manage');
                  })
            ],
          ),
          body: list != null
              ? list.length > 0
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    )
                  : Center(
                      child: Text(
                        '没有到店客户',
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                    )
              : Center(
                  child: loading(),
                ),
        );
      }),
    );
  }

  Widget _item(int i) {
    return Container(
      key: Key(i.toString()),
      margin: EdgeInsets.only(
          left: 8, right: 8, top: 10, bottom: i + 1 == list.length ? 30 : 0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 15),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: circularImg(
                          'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                          60,
                          t: 2),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${list[i]['name']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    getImg('3_06'),
                                    width: 15,
                                    height: 15,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(' ${list[i]['room']}'),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(getImg('3_03'),
                                      width: 15, height: 15, fit: BoxFit.fill),
                                  Text(
                                      ' ${list[i]['operation_time'] ?? '未开始'}'),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      getImg('3_11'),
                                      width: 15,
                                      height: 15,
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                      ' ${list[i]['tel']}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(getImg('3_14'),
                                        width: 15,
                                        height: 15,
                                        fit: BoxFit.fill),
                                    Text(' ${list[i]['arrival_time']}',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MyButton(
                      height: 30,
                      onPressed: () {
                        jump2(context, Classify(list[i]['mid']));
                      },
                      title: '消费录入',
                      titleStyle: TextStyle(fontSize: 14),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MyButton(
                        height: 30,
                        color: myColor(113, 207, 137),
                        onPressed: () {
                          jump2(context,
                              ConsumptionEntry(list[i]['mid'], list[i]['id']));
                        },
                        title: '消耗录入',
                        titleStyle: TextStyle(fontSize: 14)),
                  )),
                  /*Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: MyButton(
                        height: 30,
                        color: myColor(223, 129, 110),
                        onPressed: () {},
                        title: '账单结算',
                        titleStyle: TextStyle(fontSize: 14)),
                  )),*/
                  Expanded(
                      child: MyButton(
                          height: 30,
                          color: myColor(152, 153, 154),
                          onPressed: () async {
                            var rs = await showAlert(context, '是否离店？');
                            if (rs) {
                              leave(list[i]['id'], list[i]['mid']);
                            }
                          },
                          title: '离店',
                          titleStyle: TextStyle(fontSize: 14))),
                ],
              )
            ],
          ),
        ),
      ),
      height: 150,
    );
  }

  void leave(int id, mid) async {
    var rs = await post('leaveShop', data: {
      'arrId': id,
      'mid': mid,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        getComeShop();
      }
    }
  }
}
