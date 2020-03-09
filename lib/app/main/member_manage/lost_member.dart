import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/member_manage/member_info.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';

class LostMember extends StatefulWidget {
  @override
  _LostMemberState createState() => _LostMemberState();
}

class _LostMemberState extends State<LostMember> {
  List one;
  List two;
  List three;
  List six;
  List six2;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get(
      'LostDetail',
    );
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          one = rs['res']['one_member'];
          two = rs['res']['two_member'];
          three = rs['res']['three_member'];
          six = rs['res']['six_member'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('流失会员'),
          bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TabBar(
                  tabs: [
                    Tab(
                      text: '1个月',
                    ),
                    Tab(
                      text: '2个月',
                    ),
                    Tab(
                      text: '3个月',
                    ),
                    Tab(
                      text: '6个月',
                    ),
                  ],
                  indicatorSize: TabBarIndicatorSize.label,
                ),
              ),
              preferredSize: Size(getRange(context), 60)),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 50,
              color: bg2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Center(child: Text('姓名')),
                  ),
                  Expanded(child: Center(child: Text('性别'))),
                  Expanded(child: Center(child: Text('电话')), flex: 2,),
                  Expanded(child: Center(child: Text('最后到店')), flex: 2,),
                  Expanded(child: Center(child: Text('操作'))),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(children: [
              one != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i, 1),
                      itemCount: one.length,
                    )
                  : Center(
                      child: loading(),
                    ),
              two != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i, 2),
                      itemCount: two.length,
                    )
                  : Center(
                      child: loading(),
                    ),
              three != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i, 3),
                      itemCount: three.length,
                    )
                  : Center(
                      child: loading(),
                    ),
              six != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i, 4),
                      itemCount: six.length,
                    )
                  : Center(
                      child: loading(),
                    ),
            ]))
          ],
        ),
      ),
      length: 4,
    );
  }

  Widget _item(int i, t) {
    Map data;
    if (t == 1) {
      data = one[i];
    } else if (t == 2) {
      data = two[i];
    } else if (t == 3) {
      data = three[i];
    } else if (t == 4) {
      data = six[i];
    }
    return Column(
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
                '${data['name']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text('${data['sex'] == 1 ? '女' : '男'}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                flex: 2,
                  child: Center(
                      child: Text('${data['tel']}',
                          style: TextStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis))),
              Expanded(
                flex: 2,
                  child: Center(
                      child: Text('${data['last_time']}',
                          style: TextStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis))),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('查看', style: TextStyle(color: c1, fontSize: 16),),
                ),
                onTap: () {
                  jump2(context, MemberInfo(data['id']));
                },
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
