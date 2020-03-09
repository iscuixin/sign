import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/classify.dart';
import 'package:myh_shop/app/main/member_manage/member_info.dart';
import 'package:myh_shop/app/main/my/customer_allocation.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyInput.dart';

class ClerkManage extends StatefulWidget {
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<ClerkManage> {
  List list;
  String input = '';

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
        title: Text('店员管理'),
        bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20.0, bottom: 10.0),
              child: MyInput(
                onChanged: (v){
                  setState(() {
                    input = v;
                  });
                },
                hintText: '输入姓名/电话',
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
          child: list != null
              ? ListView.builder(
                  itemBuilder: (_, i) => _item(i),
                  itemCount: list.length,
                )
              : Center(
                  child: loading(),
                )),
    );
  }

  Widget _item(int i) {
    if (input.length > 0) {
      if (list[i]['name']
              .toString()
              .toLowerCase()
              .indexOf(input.toLowerCase()) <
          0) {
        return Offstage();
      }
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 15.0),
          color: Colors.white,
          height: 80,
          child: ListTile(
            onTap: () {
              jump2(context, CustomerAllocation(list[i]['id']));
            },
            leading: circularImg(
                'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                60, t: 2),
            title: Text('${list[i]['name']}'),
            trailing: Icon(Icons.chevron_right),
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
}
