import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/member_manage/add_need.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';

class MemberNeed extends StatefulWidget {
  final int id;

  const MemberNeed(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _MemberNeedState createState() => _MemberNeedState();
}

class _MemberNeedState extends State<MemberNeed> {
  List list;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await post('MemberGetNeed', data: {
      'id': widget.id,
    });
    if (rs != null) {
      setState(() {
        list = rs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('客户需求'),
        actions: <Widget>[
          CupertinoButton(
              child: Text(
                '添加',
                style: TextStyle(color: c1),
              ),
              onPressed: () async{
                await jump2(context, AddNeed(widget.id));
                getSj();
              })
        ],
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

  Widget _item(int i) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      color: bg2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${list[i]['createtime']}',
            style: TextStyle(fontSize: 16),
          ),
          Wrap(
            children: listWidget(list[i]['need']),
          ),
          Align(
            child: GestureDetector(
              onTap: ()async {
                if(await showAlert(context, '是否删除？')){
                  delData(list[i]['id']);
                }
              },
              child: Text(
                '删除',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            alignment: Alignment.centerRight,
          )
        ],
      ),
    );
  }

  List<Widget> listWidget(List data) {
    List<Widget> rs = [];
    for(var v in data) {
      rs.add(Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Chip(label: Text('$v')),
      ),);
    }
    return rs;
  }

  void delData(int id) async {
    var rs = await post('delNeed', data: {
      'id': id,
    });
    if (rs != null) {
      if(rs['code']==0){
        getSj();
      }
    }
  }
}
