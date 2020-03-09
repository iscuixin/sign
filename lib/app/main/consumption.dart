import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/classify.dart';
import 'package:myh_shop/app/main/member_manage/member_info.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyInput.dart';

class Consumption extends StatefulWidget {
  @override
  _ConsumptionState createState() => _ConsumptionState();
}

class _ConsumptionState extends State<Consumption> {
  List list;
  String input = '';

  void getUser() async {
    var rs = await get('get_member_list', data: {'page': 1});
    if (rs['code'] == 1) {
      setState(() {
        list = rs['res']['all_member'];
      });
    } else {
      tip(context, rs['error']);
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('消费'),
        bottom: PreferredSize(
            child: Container(
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
                hintText: '输入姓名/电话',
              ),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            ),
            preferredSize: Size(getRange(context), 50)),
      ),
      body: Container(
        child: list == null
            ? Center(
                child: loading(),
              )
            : ListView.builder(
                itemBuilder: (_, i) => _item(i),
                itemCount: list.length,
              ),
        color: bg2,
        margin: EdgeInsets.only(top: 10),
      ),
    );
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
//    //print(list[i]);
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 15.0),
          color: Colors.white,
          child: ListTile(
            onTap: () async {
              var rs = await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MemberInfo(list[i]['id'])));
              getUser();
            },
            leading: circularImg(
                'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                55, t: 2),
            title: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  child: Text(
                    '${list[i]['name']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                Container(
                  width: 50,
                  child: Text(
                    '${list[i]['shop_num'] ?? ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textColor, fontSize: 13),
                  ),
                )
              ],
            ),
            subtitle: Text(
              '${list[i]['tel']}',
              style: TextStyle(color: textColor),
            ),
            trailing: Container(
              width: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      jump2(context, Classify(list[i]['id']));
                    },
                    child: Container(
                      width: 60.0,
                      height: 35.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: c1, borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        '消费',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
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

/*Widget _item(int i) => Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 15.0),
            color: Colors.white,
            child: ListTile(
              onTap: () {},
              leading: circularImg(
                  'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                  60),
              title: Row(
                children: <Widget>[
                  Text('亚索'),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Image.asset(
                      'img/man.png',
                      height: 18.0,
                      color: textColor,
                    ),
                  ),
                  Text(
                    '123456',
                    style: TextStyle(color: textColor, fontSize: 13),
                  )
                ],
              ),
              subtitle: Text(
                '18586324598',
                style: TextStyle(color: textColor),
              ),
              trailing: Container(
                width: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        jump2(context, Classify(1));
                      },
                      child: Container(
                        width: 60.0,
                        height: 35.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: c1, borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          '消费',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider()
        ],
      );*/
}
