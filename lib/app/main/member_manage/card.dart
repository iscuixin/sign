import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/member_manage/edit_card.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';

class MyCard extends StatefulWidget {
  final int id;

  MyCard(this.id);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<MyCard> {
  List list;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('memberCardList', data: {
      'mid': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('所持卡项'),
      ),
      body: Container(
        child: list != null
            ? ListView.builder(
                itemBuilder: (c, i) => _item(c, i),
                itemCount: list.length,
              )
            : Center(
                child: loading(),
              ),
        color: bg2,
      ),
    );
  }

  Widget _item(BuildContext c, int i) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      height: 160,
      child: Card(
        color: c1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  /*Icon(
                    Icons.local_parking,
                    color: Colors.white,
                  ),*/
                  Text(
                    '${list[i]['name']}',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text('余额',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                      Text(
                        '¥${list[i]['amount']}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                            '${list[i]['card_type'] == 1 ? '消费卡' : list[i]['card_type'] == 1 ? '折扣消费卡' : '全场折扣卡'}',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: MyButton(
                      title: '编辑',
                      onPressed: () async {
                        await jump2(
                            context, EditCard(widget.id, list[i]['id']));
                        getSj();
                      },
                      width: 80,
                      color: myColor(104, 128, 239),
                      height: 30,
                    ),
                  ),
                  MyButton(
                      title: '删除',
                      onPressed: ()async {
                        if(await showAlert(context, '是否删除？')){
                          delData(list[i]['id']);
                        }
                      },
                      width: 80,
                      height: 30,
                      color: myColor(104, 128, 239)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void delData(int id) async {
    var rs = await post('del_card', data: {
      'id': id,
    });
    if(rs!=null){
      if(rs['code']==1){
        getSj();
      }
    }
  }
}
