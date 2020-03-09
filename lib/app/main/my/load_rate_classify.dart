import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/my/load_rate_detail.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyChip.dart';

class LoadRateClassify extends StatefulWidget {
  final String name;

  const LoadRateClassify(this.name, {Key key, }) : super(key: key);
  @override
  _LoadRateState createState() => _LoadRateState();
}

class _LoadRateState extends State<LoadRateClassify> {
  List list = [];
  String money = '';
  String time = '';
  String title = '';

  @override
  void initState() {
    super.initState();
    title = widget.name+'类别';
    getSj();
  }

  void getSj() async {
    var rs = await post('get_category', data: {
      'type': widget.name=='项目'?4:3
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        if(rs['res']!=null){
          Map r = rs['res'];
          List l = [];
          r.forEach((k, v){
            l.add(v);
          });
          list = l;
          setState(() {});
        }
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
            leading: backButton(context),
            title: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            pinned: true,
            elevation: 0,
            bottom: PreferredSize(
                child: Container(
                  height: 50,
                  color: bg2,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Center(child: Text('名称'))),
                      Expanded(child: Center(child: Text('总负债'))),
                      Expanded(child: Center(child: Text('总次数'))),
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
                Expanded(child: Center(child: MyChip('${list[i]['other_name']}', width: 80, fontSize: 12,))),
                Expanded(child: Center(child: Text('${list[i]['money']}'))),
                Expanded(child: Center(child: Text('${list[i]['old']}'))),
                Expanded(
                    child: Center(
                        child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: MyButton(
                    onPressed: () {
                      jump2(context, LoadRateDetail(type: widget.name=='项目'?4:3, validate: list[i]['validate'],));
                    },
                    title: '查看负债',
                    height: 30,
                    titleStyle: TextStyle(fontSize: 13),
                  ),
                ))),
              ],
            ),
          ),
          Divider(),
        ],
      );
}
