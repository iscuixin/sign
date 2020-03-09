import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/member_manage/edit_member.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/widget/MyItem.dart';

class Info extends StatefulWidget {
  final int id;

  const Info(this.id, {Key key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  Map user;

  @override
  Widget build(BuildContext context) {
    //print(user);
    return Scaffold(
      appBar: MyAppBar(
        title: Text('基本信息'),
        actions: <Widget>[
          CupertinoButton(
              child: Text(
                '编辑',
                style: TextStyle(color: c1),
              ),
              onPressed: () async {
                var rs = await Navigator.push(context, MaterialPageRoute(builder: (_)=>EditMember(user)));
                getSj();
              })
        ],
      ),
      body: Container(
        color: Colors.white,
        child: user == null
            ? Center(
                child: loading(),
              )
            : ListView(
                children: <Widget>[
                  MyItem(
                    child: Text('${user['shop_num']??''}'),
                    label: '会员编号',
                  ),
                  MyItem(
                    child: Text('${user['name']}'),
                    label: '姓$kg名',
                  ),
                  MyItem(
                    child: Text(user['sex']==1?'女':'男'),
                    label: '性$kg别',
                  ),
                  MyItem(
                    child: Text('${user['tel']}'),
                    label: '手机号码',
                  ),
                  MyItem(
                    child: Text('${user['nl']}'),
                    label: '农历生日',
                  ),
                  MyItem(
                    child: Text('${user['yl']}'),
                    label: '阳历生日',
                  ),
                  MyItem(
                    child: Text(user['tel']==1?'已婚':'未婚'),
                    label: '婚$kg姻',
                  ),
                  MyItem(
                    child: Text('${user['address']}'),
                    label: '地$kg址',
                  ),
                  MyItem(
                    child: Text('${user['create_time']}'),
                    label: '加入时间',
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('basicinformation', data: {'id': widget.id});
    if (rs != null) {
      setState(() {
        user = rs['data'];
      });
    }
    //print(rs);
  }
}
