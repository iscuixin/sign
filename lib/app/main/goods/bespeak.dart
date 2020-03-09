import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyChip.dart';
import 'package:myh_shop/widget/MyInput.dart';

class Bespeak extends StatefulWidget {
  @override
  _BespeakState createState() => _BespeakState();
}

class _BespeakState extends State<Bespeak> with TickerProviderStateMixin {
  List yes;
  List no;
  String input = '';
  TabController _tabController;
  int now = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      now = _tabController.index;

    });
    getSj(0);
    getSj(1);
  }

  void getSj(t) async {
    var rs = await post('getGoods', data: {'type': t});
    if (rs != null) {
      if (t == 0) {
        yes = rs['data'];
      } else {
        no = rs['data'];
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('预约推荐'),
          bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: MyInput(
                      prefixIcon: Icon(
                        Icons.search,
                        color: textColor,
                      ),
                      hintText: '输入名称查找',
                      onChanged: (v) {
                        setState(() {
                          input = v;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: '已上架',
                        ),
                        Tab(
                          text: '未上架',
                        ),
                      ],
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
                  )
                ],
              ),
              preferredSize: Size(getRange(context), 120)),
        ),
        body: Container(
          color: bg2,
          margin: EdgeInsets.only(top: 10),
          child: TabBarView(controller: _tabController, children: [
            yes != null
                ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 0),
                    itemCount: yes.length,
                  )
                : Center(
                    child: loading(),
                  ),
            no != null
                ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 1),
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
    if(input.length>0){
      if(now==0){
        if(yes[i]['name'].toString().toLowerCase().indexOf(input.toLowerCase()) < 0){
          return Offstage();
        }
      }else{
        if(no[i]['name'].toString().toLowerCase().indexOf(input.toLowerCase()) < 0){
          return Offstage();
        }
      }
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15),
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: MyChip(
                              '${t == 0 ? yes[i]['type'] : no[i]['type']}'),
                        ),
                        Container(
                          width: getRange(context) / 2,
                          child: Text(
                            '${t == 0 ? yes[i]['name'] : no[i]['name']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              text: '库存：',
                              children: [
                                TextSpan(
                                    text:
                                        '${t == 0 ? yes[i]['stock'] ?? '无' : no[i]['stock'] ?? '无'}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black))
                              ],
                              style: TextStyle(color: textColor))),
                    ),
                  ),
                ],
              ),
              MyButton(
                onPressed: () {
                  if (t == 0) {
                    xj(t == 0 ? yes[i] : no[i]);
                  } else {
                    sj(t == 0 ? yes[i] : no[i]);
                  }
                },
                title: t == 0 ? '下架' : '上架',
                width: 70,
                height: 30,
                titleStyle: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  void sj(Map data) async {
    var rs = await post('change', data: {
      'type': 0,
      'id': data['id'],
      'is': data['type'] == '项目' ? 1 : 2
    });
    if (rs != null) {
      if (rs['code'] == 0) {
        getSj(0);
        getSj(1);
      }
    }
  }

  void xj(Map data) async {
    var rs = await post('change', data: {
      'type': 1,
      'id': data['id'],
      'is': data['type'] == '项目' ? 1 : 2
    });
    if (rs != null) {
      if (rs['code'] == 0) {
        getSj(0);
        getSj(1);
      }
    }
  }
}
