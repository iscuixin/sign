import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/buy_items.dart';
import 'package:myh_shop/app/main/member_manage/edit_items.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/widget/MyButton.dart';

class Items extends StatefulWidget {
  final int id;
  final String type;

  const Items(
    this.id,
    this.type, {
    Key key,
  }) : super(key: key);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List list;
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text(title),
        actions: <Widget>[
          CupertinoButton(
              child: Text(
                '购买${widget.type=='items'?'项目':widget.type=='box'?'套盒':''}',
                style: TextStyle(color: c1),
              ),
              onPressed: () {
                jump2(context, BuyItems(2));
              })
        ],
        /*bottom: PreferredSize(
            child: Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Text(
                        '剩余次数',
                        style: TextStyle(color: textColor, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '123',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Text(
                        '总欠款',
                        style: TextStyle(color: textColor, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '¥235.00',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            preferredSize: Size(getRange(context), 70)),*/
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                width: getRange(context) * 2,
                color: bg2,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Center(child: Text('类别'))),
                    Expanded(child: Center(child: Text('名称'))),
                    Expanded(child: Center(child: Text('价格'))),
                    Expanded(child: Center(child: Text('余数'))),
                    Expanded(child: Center(child: Text('购买日期'))),
                    Expanded(child: Center(child: Text('美容师'))),
                    widget.type=='plan'?Offstage():Expanded(
                      child: Center(child: Text('操作')),
                      flex: 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: getRange(context) * 2,
                child: list == null
                    ? Center(
                        child: loading(),
                      )
                    : ListView.builder(
                        itemBuilder: (_, i) => _item(i),
                        itemCount: list.length,
                      ),
              ))
            ],
          )
        ],
      ),
    );
  }

  Column _item(int i) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Chip(
                  padding: EdgeInsets.all(0),
                  label: Text(
                    '${list[i]['category']}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: c1,
                ),
              ),
              Expanded(
                  child: Text(
                '${list[i]['name']}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
              Expanded(
                  child: Text('¥${list[i]['price']}',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis)),
              Expanded(
                  child: Text(
                '${list[i]['current_num']??''}',
                textAlign: TextAlign.center,
              )),
              Expanded(
                child: Text('${list[i]['time']}', textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text('-', textAlign: TextAlign.center),
              ),
              widget.type=='plan'?Offstage():Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyButton(
                      title: '编辑',
                      onPressed: () async {
                        await jump2(
                            context, EditItems(list[i]['id'], widget.type));
                        getSj();
                      },
                      width: 60,
                      height: 30,
                    ),
                    Padding(padding: EdgeInsets.all(2)),
                    MyButton(
                      title: '删除',
                      color: Colors.red,
                      onPressed: () async {
                        if (await showAlert(context, '是否删除？')) {
                          delData(list[i]['id']);
                        }
                      },
                      width: 60,
                      height: 30,
                    ),
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

  void delData(int id) async {
    var rs = await post('MemberBoxItemsDel', data: {
      'id': id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        getSj();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.type=='items'){
      title = '会员项目';
    }else if(widget.type=='box'){
      title = '会员套盒';
    }else if(widget.type=='plan'){
      title = '会员方案';
    }
    setState(() {

    });
    getSj();
  }

  void getSj() async {
    var rs = await get('memberBoxItemsList', data: {
      'mid': widget.id,
      'type': widget.type,
    });
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res']['list'];
        });
      }
    }
  }
}
