import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/my/royalty_set.dart';
import 'package:myh_shop/app/main/my/staff_add.dart';
import 'package:myh_shop/app/main/my/staff_detail.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyChip.dart';
import 'package:myh_shop/widget/MyInput.dart';

class StaffManage extends StatefulWidget {
  @override
  _StaffManageState createState() => _StaffManageState();
}

class _StaffManageState extends State<StaffManage> {
  List list;
  String input = '';
  dynamic type;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_staff');
    if (rs != null) {
      setState(() {
        list = rs['list'];
      });
    }
  }

  void getDetail(int id) async {
    var rs = await get('staffDetail', data: {
      'staff': id,
    });
    if (rs != null) {

      jump2(context, RoyaltySet(id, rs['type']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: Text('员工管理'),
          actions: <Widget>[
            CupertinoButton(
                child: Text(
                  '新增员工',
                  style: TextStyle(color: c1),
                ),
                onPressed: () async {
                  var rs = await jump2(context, StaffAdd());
                  getSj();
                })
          ],
          bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: MyInput(
                  onChanged: (v) {
                    setState(() {
                      input = v;
                    });
                  },
                  prefixIcon: Icon(
                    Icons.search,
                    color: textColor,
                  ),
                  hintText: '输入姓名/电话/员工编号',
                ),
              ),
              preferredSize: Size(getRange(context), 60)),
        ),
        body: list != null
            ? ListView.builder(
                itemBuilder: (_, i) => _item(i),
                itemCount: list.length,
              )
            : Center(
                child: loading(),
              ));
  }

  Widget _item(int i) {
    if (input.length > 0) {
      if (list[i]['name']
                  .toString()
                  .toLowerCase()
                  .indexOf(input.toLowerCase()) <
              0 &&
          list[i]['mobile'].toString().toLowerCase().indexOf(input.toLowerCase()) <
              0 &&
          list[i]['number']
                  .toString()
                  .toLowerCase()
                  .indexOf(input.toLowerCase()) <
              0) {
        return Offstage();
      }
    }
    return Container(
      color: bg2,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () async {
              var rs = jump2(context, StaffDetail(list[i]['id']));
              getSj();
            },
            leading: circularImg(
                'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                50, t: 2),
            title: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text('${list[i]['name']}'),
                ),
                MyChip(
                  '${list[i]['role_name']}',
                  color: c1,
                  height: 20,
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        getImg('5.3_03'),
                        width: 13,
                        height: 13,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${list[i]['number']}',
                          style: TextStyle(color: c1),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(getImg('5.3_06'),
                          width: 13, height: 13, fit: BoxFit.fill),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          '${list[i]['mobile']}',
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            trailing: MyButton(
              title: '提成设置',
              onPressed: () {
                getDetail(list[i]['id']);
              },
              width: 80,
              height: 35,
              titleStyle: TextStyle(fontSize: 15),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
