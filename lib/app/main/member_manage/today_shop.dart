import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class TodayShop extends StatefulWidget {
  @override
  _TodayShopState createState() => _TodayShopState();
}

class _TodayShopState extends State<TodayShop> {
  List m = [];
  List n = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('今日到店'),
          bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TabBar(
                  tabs: [
                    Tab(
                      text: '会员',
                    ),
                    Tab(
                      text: '新客',
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
                  Expanded(child: Center(child: Text('电话'))),
                  Expanded(child: Center(child: Text('到店时间'))),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(children: [
              m != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i, 1),
                      itemCount: m.length,
                    )
                  : Center(
                      child: loading(),
                    ),
              n != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i, 2),
                      itemCount: n.length,
                    )
                  : Center(
                      child: loading(),
                    )
            ]))
          ],
        ),
      ),
      length: 2,
    );
  }

  Widget _item(int i, t) {
    Map data;
    if(t==1){
      data = m[i];
    }else{
      data = n[i];
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
                      child: Text('${data['sex']==1?'女':'男'}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${data['tel']}',
                          style: TextStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${data['arrival_time']}',
                          style: TextStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis))),
            ],
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('toStoreDetail');
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          m = rs['res']['m'];
          n = rs['res']['n'];
        });
      }
    }
  }
}
