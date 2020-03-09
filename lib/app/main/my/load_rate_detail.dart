import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyChip.dart';
import 'package:myh_shop/widget/MyInput.dart';

class LoadRateDetail extends StatefulWidget {
  final int type;
  final int validate;

  const LoadRateDetail({Key key, this.type, this.validate}) : super(key: key);

  @override
  _LoadRateState createState() => _LoadRateState();
}

class _LoadRateState extends State<LoadRateDetail> {
  List list=[];
  double money = 0;
  int time = 0;
  String input = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg2,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              '负债详情',
              style: TextStyle(color: Colors.white),
            ),
            pinned: true,
            elevation: 0,
            backgroundColor: c1,
            leading: backButton(context, color: Colors.white),
            expandedHeight: 260,
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
                    margin: EdgeInsets.only(top: 0, left: 15),
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
                                '未消耗',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                time.toString(),
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
                              '负载',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              money.toStringAsFixed(2),
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
                  height: 60,
                  color: bg2,
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
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
                    hintText: '输入会员名称进行搜索',
                  ),
                ),
                preferredSize: Size(getRange(context), 60)),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((_, i) => _item(i),
                  childCount: list.length))
        ],
      ),
    );
  }

  Widget _item(int i) {
    if(input.length>0 && list[i]['m_name'].toString().toLowerCase().indexOf(input.toLowerCase()) <0) {
      return Offstage();
    }
    if(widget.type==3 || widget.type==4 || widget.type==5){
      String name = '';
      String gName = '';
      String num = '';
      double money = 0;
      name = list[i]['m_name'].toString();
      gName = list[i]['other_name'].toString();
      money = double.parse(list[i]['money'].toString());
      num = '${list[i]['current_num']}/${list[i]['old']}';
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 15, top: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          name,
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              text: '余数/总次数：',
                              children: [
                                TextSpan(
                                    text: num,
                                    style: TextStyle(color: Colors.black))
                              ],
                              style: TextStyle(color: textColor))),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: RichText(
                            text: TextSpan(
                                text: '名称：',
                                children: [
                                  TextSpan(
                                      text: gName,
                                      style: TextStyle(color: Colors.black))
                                ],
                                style: TextStyle(color: textColor))),
                      ),
                      RichText(
                          text: TextSpan(
                              text: '负载金额：',
                              children: [
                                TextSpan(
                                    text: money.toStringAsFixed(2),
                                    style: TextStyle(color: Colors.black))
                              ],
                              style: TextStyle(color: textColor))),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(),
        ],
      );
    }else if(widget.type==2||widget.type==1){
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 15, right: getRange(context) / 4, top: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        list[i]['m_name'],
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            text: '卡项余额：',
                            children: [
                              TextSpan(
                                  text: list[i]['money'].toString(),
                                  style: TextStyle(color: Colors.black))
                            ],
                            style: TextStyle(color: textColor))),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
        ],
      );
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: 15, right: getRange(context) / 4, top: 10),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      '亚索',
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          text: '余数/总次数：',
                          children: [
                            TextSpan(
                                text: '9/23',
                                style: TextStyle(color: Colors.black))
                          ],
                          style: TextStyle(color: textColor))),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: RichText(
                        text: TextSpan(
                            text: '名称：',
                            children: [
                              TextSpan(
                                  text: '面部护理',
                                  style: TextStyle(color: Colors.black))
                            ],
                            style: TextStyle(color: textColor))),
                  ),
                  RichText(
                      text: TextSpan(
                          text: '负载金额：',
                          children: [
                            TextSpan(
                                text: '9/23',
                                style: TextStyle(color: Colors.black))
                          ],
                          style: TextStyle(color: textColor))),
                ],
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    Map<String, dynamic> data = {};
    data['type'] = widget.type;
    if(widget.validate!=null){
      data['validate'] = widget.validate;
    }
    var rs = await get('get_one_debt', data: data);
    if(rs!=null){
      if(rs['code']==1){
        if(widget.type==3 || widget.type==4 || widget.type==5){
          for(var v in rs['res']) {
            money += v['money'];
            time += v['current_num'];
          }
        }else if(widget.type==2||widget.type==1){
          for(var v in rs['res']) {
            money += v['money'];
          }
        }
        list = rs['res'];
        setState(() {

        });
      }
    }
  }
}
