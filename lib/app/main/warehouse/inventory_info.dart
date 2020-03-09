import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyInput.dart';

class InventoryInfo extends StatefulWidget {
  @override
  _InventoryInfoState createState() => _InventoryInfoState();
}

class _InventoryInfoState extends State<InventoryInfo> {
  List list;
  List cp;
  List box;
  List hc;
  List un;
  String input = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('盈亏数'),
          bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: [
                      Tab(
                        text: '产品',
                      ),
                      Tab(
                        text: '套盒',
                      ),
                      Tab(
                        text: '耗材',
                      ),
                      Tab(
                        text: '内衣',
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 20, left: 10, right: 10),
                    height: 35,
                    child: MyInput(
                      onChanged: (v){
                        setState(() {
                          input = v;
                        });
                      },
                      prefixIcon: Icon(
                        Icons.search,
                        color: textColor,
                      ),
                      hintText: '输入产品名称',
                    ),
                  ),
                ],
              ),
              preferredSize: Size(getRange(context), 110)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                color: bg2,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Center(child: Text('名称'))),
                    Expanded(child: Center(child: Text('日期'))),
                    Expanded(child: Center(child: Text('盈亏数量'))),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  cp != null
                      ? ListView.builder(
                          itemBuilder: (_, i) => _item(i, 1),
                          itemCount: cp.length,
                        )
                      : Center(
                          child: loading(),
                        ),
                  box != null
                      ? ListView.builder(
                          itemBuilder: (_, i) => _item(i, 2),
                          itemCount: box.length,
                        )
                      : Center(
                          child: loading(),
                        ),
                  hc != null
                      ? ListView.builder(
                          itemBuilder: (_, i) => _item(i, 3),
                          itemCount: hc.length,
                        )
                      : Center(
                          child: loading(),
                        ),
                  un != null
                      ? ListView.builder(
                    itemBuilder: (_, i) => _item(i, 4),
                    itemCount: un.length,
                  )
                      : Center(
                    child: loading(),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
      length: 4,
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('pdLogs');
    if (rs != null) {
      if (rs['code'] == 0) {
        setState(() {
          cp = [];
          box = [];
          hc = [];
          un = [];
          for(var v in rs['data']) {
            if(v['type']==1){
              cp.add(v);
            }
            if(v['type']==2){
              box.add(v);
            }
            if(v['type']==3){
              hc.add(v);
            }
            if(v['type']==4){
              un.add(v);
            }
          }
        });
      }
    }
  }

  Widget _item(int i, t) {
    Map data;
    if(t==1){
      data = cp[i];
    }else if(t==2){
      data = box[i];
    }else if(t==3){
      data = hc[i];
    }else if(t==4){
      data = un[i];
    }
    if(input.length>0){
      if(data['name'].toString().toLowerCase().indexOf(input.toLowerCase())<0){
        return Offstage();
      }
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
                      child: Text('${data['inventory_time']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${data['num']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
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
