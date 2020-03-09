import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/my/load_rate_classify.dart';
import 'package:myh_shop/app/main/my/load_rate_detail.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyChip.dart';

class LoadRate extends StatefulWidget {
  @override
  _LoadRateState createState() => _LoadRateState();
}

class _LoadRateState extends State<LoadRate> {
  List list = [
    {'name': '项目', 'money': '', 'num': ''},
    {'name': '套盒', 'money': '', 'num': ''},
    {'name': '方案', 'money': '', 'num': ''},
    {'name': '卡项', 'money': '', 'num': ''},
    {'name': '余额', 'money': '', 'num': ''},
  ];
  String money = '';
  String time = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_debt_detail');
    if (rs != null) {
      if (rs['code'] == 1) {
        list[0]['money'] = double.parse(rs['res']['items_money'].toString())
            .toStringAsFixed(2);
        list[0]['num'] = rs['res']['items_time'].toString();

        list[1]['money'] = double.parse(rs['res']['box_money'].toString())
            .toStringAsFixed(2);
        list[1]['num'] = rs['res']['box_time'].toString();

        list[2]['money'] = double.parse(rs['res']['plan_money'].toString())
            .toStringAsFixed(2);
        list[2]['num'] = rs['res']['plan_time'].toString();

        list[3]['money'] = double.parse(rs['res']['card_amount'].toString())
            .toStringAsFixed(2);
        list[3]['num'] = '--';

        list[4]['money'] = double.parse(rs['res']['balance'].toString())
            .toStringAsFixed(2);
        list[4]['num'] = '--';

        money = double.parse(rs['res']['total_amount'].toString()).toStringAsFixed(2);
        time = rs['res']['total_time'].toString();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg2,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              '负债率',
              style: TextStyle(color: Colors.white),
            ),
            pinned: true,
            elevation: 0,
            backgroundColor: c1,
            leading: backButton(context, color: Colors.white),
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  Container(
                    height: 200 + getRange(context, type: 3),
                    child: Image.asset(
                      getImg('5.01_01'),
                      fit: BoxFit.fill,
                      width: getRange(context),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '未消耗总次数',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                time,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '总负载',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              money,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottom: PreferredSize(
                child: Container(
                  height: 50,
                  color: bg2,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Center(child: Text('类别'))),
                      Expanded(child: Center(child: Text('负载金额'))),
                      Expanded(child: Center(child: Text('未消耗次数'))),
                      Expanded(child: Center(child: Text('操作'))),
                    ],
                  ),
                ),
                preferredSize: Size(getRange(context), 50)),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((_, i) => _item(i),
                  childCount: list.length))
        ],
      ),
    );
  }

  Widget _item(int i) => Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(child: Center(child: MyChip('${list[i]['name']}', ))),
                Expanded(child: Center(child: Text('${list[i]['money']}'))),
                Expanded(child: Center(child: Text('${list[i]['num']}'))),
                Expanded(
                    child: Center(
                        child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: MyButton(
                    onPressed: () {
                      if(list[i]['name']=='项目' || list[i]['name']=='套盒'){
                        jump2(context, LoadRateClassify(list[i]['name']));
                      }else{
                        int t = 0;
                        if(list[i]['name']=='方案'){
                          t = 5;
                        }else if(list[i]['name']=='卡项') {
                          t = 2;
                        }else if(list[i]['name']=='余额') {
                          t = 1;
                        }
                        jump2(context, LoadRateDetail(type: t,));
                      }
                    },
                    title: '详情',
                    height: 30,
                    titleStyle: TextStyle(fontSize: 14),
                  ),
                ))),
              ],
            ),
          ),
          Divider(),
        ],
      );
}
