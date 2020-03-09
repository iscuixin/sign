import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/classify.dart';
import 'package:myh_shop/app/main/member_manage/add_member.dart';
import 'package:myh_shop/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class NewManage extends StatefulWidget {
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<NewManage> {
  List list;
  String input = '';
  String room = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            onPressed: () => back(context)),
        title: Text('新客管理'),
        bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20.0, bottom: 10.0),
              child: MyInput(
                hintText: '输入姓名/电话',
                onChanged: (v) {
                  setState(() {
                    input = v;
                  });
                },
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
              ),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 50)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: list == null
            ? Center(
                child: loading(),
              )
            : Column(
                children: <Widget>[
                  Container(
                    child: ListTile(
                        contentPadding: EdgeInsets.only(left: 10),
                        title: Text(
                          '新客人数(${list.length})',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                    color: Colors.white,
                  ),
                  Expanded(
                      child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                    itemBuilder: (_, i) => _item(i),
                    itemCount: list.length,
                  ))
                ],
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyButton(
                onPressed: () => back(context),
                title: '进入会员',
                width: 120,
                color: myColor(113, 204, 137),
                margin: EdgeInsets.only(left: 40.0),
              ),
              MyButton(
                onPressed: () async {
                  var rs = await Navigator.pushNamed(context, 'add_new');
                  getData();
                },
                title: '添加新客',
                width: 120,
                margin: EdgeInsets.only(right: 40.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showModel(id) async {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('请输入房间号'),
              content: CupertinoTextField(
                placeholder: '请输入房间号',
                keyboardType: TextInputType.numberWithOptions(),
                autofocus: true,
                onChanged: (v) {
                  room = v;
                },
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('取消'),
                  onPressed: () {
                    back(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text('确定'),
                  onPressed: () async {
                    if (room.length == 0) {
                      return tip(context, '请输入房间号');
                    }
                    var rs = await addArrive(id, room);
                    if (rs['code'] == 1) {
                      room = '';
                      ok(context, rs['Msg']);
                    } else {
                      tip(context, rs['errorMsg']);
                    }
                    //print(rs);
                  },
                ),
              ],
            ));
  }

  Widget _item(int i) {
    if (input.length > 0) {
      if (list[i]['name']
                  .toString()
                  .toLowerCase()
                  .indexOf(input.toLowerCase()) <
              0 &&
          list[i]['tel'].toString().toLowerCase().indexOf(input.toLowerCase()) <
              0) {
        return Offstage();
      }
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 15.0),
          color: Colors.white,
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 10),
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                list[i]['sex'] == 1 ?'https://myh.myhkj.cn/images/backend/woman.png':'https://myh.myhkj.cn/images/backend/man.png'
              ),
            ),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                  child: Text(
                    '${list[i]['name']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Image.asset(
                    getImg(list[i]['sex'] == 1 ? 'woman' : 'man'),
                    height: 15.0,
                    color: textColor,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              '${list[i]['tel']}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: textColor, fontSize: 12),
            ),
            trailing: Container(
              width: getRange(context) / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyButton(
                    title: '升级',
                    color: c2,
                    onPressed: () async {
                      await jump2(
                          context,
                          AddMember(
                            data: list[i],
                          ));
                      getData();
                    },
                    width: 60,
                    height: 30,
                    titleStyle: TextStyle(fontSize: 14),
                  ),
                  MyButton(
                    title: '购买',
                    color: c3,
                    onPressed: () {
                      jump2(context, Classify(1));
                    },
                    width: 60,
                    height: 30,
                    titleStyle: TextStyle(fontSize: 14),
                  ),
                  MyButton(
                    title: '到店',
                    onPressed: () {
                      showModel(list[i]['id']);
                    },
                    width: 60,
                    height: 30,
                    titleStyle: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }

  void open(BuildContext c) async {
    Scaffold.of(c).openEndDrawer();
  }

  void getData() async {
    var rs = await get('guest');
    if (rs != null) {
      setState(() {
        list = rs['data']['guests'];
      });
    }
    //print(rs);
  }
}
