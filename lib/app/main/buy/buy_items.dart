import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton2.dart';
import 'package:myh_shop/widget/MyInput.dart';
import 'package:flutter/cupertino.dart';

class BuyItems extends StatefulWidget {
  final int id;
  final int type;

  const BuyItems(this.id, {Key key, this.type = 1}) : super(key: key);

  @override
  _BuyItemsState createState() => _BuyItemsState();
}

class _BuyItemsState extends State<BuyItems> {
  List list = [1, 2, 3, 4, 4, 3, 3, 2, 34];
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(title),
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
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          padding:
              EdgeInsets.only(left: 10, bottom: getRange(context, type: 4)),
          itemBuilder: (_, i) => _item(i),
          itemCount: list.length,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    switch (widget.type){
      case 1:
        title='产品购买';
        break;
      case 2:
        title='套盒购买';
        break;
      case 3:
        title='项目购买';
        break;
      case 4:
        title='卡项购买';
        break;
      case 5:
        title='方案购买';
        break;
    }
  }

  Column _item(int i) {
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: <Widget>[
                        Container(
                            height: 20,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: c3,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '面部',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            )),
                        Container(
                          width: 120,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            '水晶baby果冻村水晶baby果冻村',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          '不可赠送',
                          style: TextStyle(color: textColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
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
                            onPress: () {},
                          ),
                          //IconButton(icon: Icon(Icons.add), onPressed: (){}),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    priceWidget('2500'),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        '库存：60',
                        style: TextStyle(fontSize: 14, color: textColor),
                      ),
                    ),
                    Text('已预售：0',
                        style: TextStyle(fontSize: 14, color: textColor)),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }
}
