import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/pay.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyButton2.dart';
import 'package:myh_shop/widget/MyInput.dart';
import 'package:flutter/cupertino.dart';

class BuyPlan extends StatefulWidget {
  final int id;

  const BuyPlan(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _BuyItemsState createState() => _BuyItemsState();
}

class _BuyItemsState extends State<BuyPlan> {
  List list = [1, 2, 3, 4, 4, 3, 3, 2, 34];
  final double height = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('购买方案'),
        bottom: PreferredSize(
            child: Container(
              child: MyInput(
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
                hintText: '输入项目名称',
              ),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            ),
            preferredSize: Size(getRange(context), 50)),
      ),
      body: Builder(
        builder: (c) => Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                /*padding:
                EdgeInsets.only(left: 10, bottom: getRange(context, type: 4)),*/
                itemBuilder: (_, i) => _item(i, c),
                itemCount: list.length,
              ),
            ),
      ),
    );
  }

  Widget _item(int i, BuildContext c) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 0, right: 10),
            leading: Row(
              children: <Widget>[
                MyButton2(
                  onPress: () {},
                  icon: Icons.chevron_right,
                  color: myColor(105, 105, 106),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    '美容仪器治疗美容仪器治疗',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  width: 120,
                ),
                priceWidget('2500'),
              ],
            ),
            trailing: Container(
              width: getRange(context) / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MyButton2(
                    icon: Icons.remove,
                    color: c1,
                    onPress: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      '0',
                      style: TextStyle(color: textColor, fontSize: 18),
                    ),
                  ),
                  MyButton2(
                    icon: Icons.add,
                    onPress: () {
                      showCar(c);
                    },
                  ),
                  //IconButton(icon: Icon(Icons.add), onPressed: (){}),
                ],
              ),
            ),
          ),
        ),
        Table(
          children: <TableRow>[
            TableRow(children: [
              TableCell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height,
                      alignment: Alignment.center,
                      color: tableBg,
                      child: Text('类别'),
                    ),
                    Divider(
                      height: 0,
                      color: textColor,
                    )
                  ],
                ),
              ),
              TableCell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height,
                      alignment: Alignment.center,
                      color: tableBg,
                      child: Text('名称'),
                    ),
                    Divider(
                      height: 0,
                      color: textColor,
                    )
                  ],
                ),
              ),
              TableCell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height,
                      alignment: Alignment.center,
                      color: tableBg,
                      child: Text('售价'),
                    ),
                    Divider(
                      height: 0,
                      color: textColor,
                    )
                  ],
                ),
              ),
              TableCell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height,
                      alignment: Alignment.center,
                      color: tableBg,
                      child: Text('次数'),
                    ),
                    Divider(
                      height: 0,
                      color: textColor,
                    )
                  ],
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height,
                      alignment: Alignment.center,
                      color: tableBg,
                      child: Text('项目'),
                    ),
                    Divider(
                      height: 0,
                      color: textColor,
                    )
                  ],
                ),
              ),
              TableCell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height,
                      alignment: Alignment.center,
                      color: tableBg,
                      child: Text(
                        '面部护理面部护理',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: textColor,
                    )
                  ],
                ),
              ),
              TableCell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height,
                      alignment: Alignment.center,
                      color: tableBg,
                      child: Text(
                        '650000.00',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Divider(
                      height: 0,
                      color: textColor,
                    )
                  ],
                ),
              ),
              TableCell(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: height,
                      alignment: Alignment.center,
                      color: tableBg,
                      child: Text('10'),
                    ),
                    Divider(
                      height: 0,
                      color: textColor,
                    )
                  ],
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Container(
                  height: height,
                  alignment: Alignment.center,
                  color: tableBg,
                  child: Text('项目'),
                ),
              ),
              TableCell(
                child: Container(
                  height: height,
                  alignment: Alignment.center,
                  color: tableBg,
                  child: Text(
                    '面部护理面部护理',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  height: height,
                  alignment: Alignment.center,
                  color: tableBg,
                  child: Text(
                    '650000.00',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  height: height,
                  alignment: Alignment.center,
                  color: tableBg,
                  child: Text('10'),
                ),
              ),
            ]),
          ],
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }

  void showCar(BuildContext c) async {
    showBottomSheet(
        context: c,
        builder: (_) => PhysicalShape(
              clipper:
                  const ShapeBorderClipper(shape: RoundedRectangleBorder()),
              elevation: 10,
              color: Colors.black,
              child: Container(
                  height: getRange(context, type: 2) / 2,
                  width: getRange(context),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '购物车',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                icon: Icon(Icons.delete), onPressed: () {})
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                      ),
                      Expanded(
                          child: ListView(
                        children: <Widget>[
                          _item2(c),
                          _item2(c),
                        ],
                      )),
                      Column(
                        children: <Widget>[
                          Divider(
                            height: 0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            width: getRange(context),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RichText(
                                    text: TextSpan(
                                        text: '合计：',
                                        children: [
                                          TextSpan(
                                              text: '¥',
                                              style: TextStyle(
                                                  color: c1, fontSize: 13)),
                                          TextSpan(
                                              text: '2500',
                                              style: TextStyle(
                                                  color: c1, fontSize: 18)),
                                        ],
                                        style: TextStyle(
                                          color: Colors.black,
                                        ))),
                                MyButton(
                                  onPressed: () {
                                    jump2(context, Pay(1,1));
                                  },
                                  title: '确认购买',
                                  width: getRange(context) / 3,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ));
    /*showCupertinoModalPopup(
        context: context,
        builder: (_) => MaterialApp(
              home: Container(
                height: getRange(context, type: 2) / 2,
                width: getRange(context),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      child: Row(
                        children: <Widget>[
                          Text('选择规格'),
                          IconButton(icon: Icon(Icons.delete), onPressed: () {})
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));*/
  }

  Column _item2(BuildContext c) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.only(left: 0, right: 10),
          leading: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  '美容仪器治疗美容仪器治疗',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                width: 120,
              ),
              priceWidget('2500'),
            ],
          ),
          trailing: Container(
            width: getRange(context) / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MyButton2(
                  icon: Icons.remove,
                  color: c1,
                  onPress: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    '0',
                    style: TextStyle(color: textColor, fontSize: 18),
                  ),
                ),
                MyButton2(
                  icon: Icons.add,
                  onPress: () {
                    showCar(c);
                  },
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 50,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '优惠方式',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    'img/radio_no.png',
                    height: 20,
                    color: textColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('打折',
                        style: TextStyle(color: textColor, fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }
}
