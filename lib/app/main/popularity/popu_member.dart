import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class PopuMember extends StatefulWidget {
  final Map data;

  const PopuMember(this.data, {Key key}) : super(key: key);

  @override
  _PopuMemberState createState() => _PopuMemberState();
}

class _PopuMemberState extends State<PopuMember> with TickerProviderStateMixin {
  List list = [1, 1, 1, 1, 1, 1, 1, 1];
  List buy;
  List no;
  String input = '';
  int now = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        now = _tabController.index;
      });
    });
    getSj();
  }

  void getSj() async {
    var rs = await get('get_popularity_detail', data: {
      'id': widget.data['id'],
      'px': widget.data['px'],
      'type': widget.data['type'],
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          buy = rs['res']['buy_arr'];
          no = rs['res']['not_arr'];
        });
      }
    }
    //print(rs);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: MyInput(
            prefixIcon: Icon(
              Icons.search,
              color: textColor,
            ),
            onChanged: (v) {
              setState(() {
                input = v;
              });
            },
            hintText: '请输入关键字查找',
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: null)
          ],
          bottom: PreferredSize(
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: '已购买',
                  ),
                  Tab(
                    text: '未购买',
                  ),
                ],
                indicatorSize: TabBarIndicatorSize.label,
              ),
              preferredSize: Size(getRange(context), 50)),
        ),
        body: Container(
          color: bg2,
          margin: const EdgeInsets.only(top: 10),
          child: TabBarView(controller: _tabController, children: [
            buy != null
                ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 1),
                    itemCount: buy.length,
                  )
                : Center(
                    child: loading(),
                  ),
            no != null
                ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 2),
                    itemCount: no.length,
                  )
                : Center(
                    child: loading(),
                  ),
          ]),
        ),
      ),
      length: 2,
    );
  }

  Widget _item(int i, t) {
    String name = '';
    String tel = '';
    if (t == 1) {
      name = buy[i]['name'];
      tel = buy[i]['tel'];
    }
    if (t == 2) {
      name = no[i]['name'];
      tel = no[i]['tel'];
    }
    if (now == 0 && t == 1) {
      if (input.length > 0) {
        if (buy[i]['name']
                    .toString()
                    .toLowerCase()
                    .indexOf(input.toLowerCase()) <
                0 &&
            buy[i]['tel']
                    .toString()
                    .toLowerCase()
                    .indexOf(input.toLowerCase()) <
                0) {
          return Offstage();
        }
      }
    } else if (now == 1 && t == 2) {
      if (input.length > 0) {
        if (no[i]['name']
                    .toString()
                    .toLowerCase()
                    .indexOf(input.toLowerCase()) <
                0 &&
            no[i]['tel'].toString().toLowerCase().indexOf(input.toLowerCase()) <
                0) {
          return Offstage();
        }
      }
    }

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 15.0),
          color: Colors.white,
          child: ListTile(
            onTap: () {},
            leading: circularImg(
                'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                60, t: 2),
            title: Row(
              children: <Widget>[
                Text(name),
              ],
            ),
            subtitle: Text(
              tel,
              style: TextStyle(color: textColor),
            ),
            trailing: Container(
              width: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MyButton(
                    onPressed: () {},
                    title: '拨打电话',
                    width: getRange(context) / 4,
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
