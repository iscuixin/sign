import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class WareSetting extends StatefulWidget {
  final int id;

  WareSetting(this.id);

  @override
  _WareSettingState createState() => _WareSettingState();
}

class _WareSettingState extends State<WareSetting> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('仓库设置'),
          bottom: PreferredSize(
              child: TabBar(
                tabs: [
                  Tab(
                    text: '仓库编辑',
                  ),
                  Tab(
                    text: '仓库合并',
                  ),
                ],
                indicatorColor: c1,
                unselectedLabelColor: textColor,
                labelColor: c1,
                indicatorSize: TabBarIndicatorSize.label,
              ),
              preferredSize: Size(getRange(context), 40)),
        ),
        body: TabBarView(children: [
          Container(
            child: ListView(
              children: <Widget>[
                MyInput2(label: '新名称', hintText: '请输入新的仓库名称',),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
                  child: MyButton(title: '新建', onPressed: () {},),
                ),
              ],
            ),
            color: bg2,
            margin: EdgeInsets.only(top: 10),
          ),
          Container(
            child: ListView(),
            color: bg2,
            margin: EdgeInsets.only(top: 10),
          ),
        ]),
      ),
      length: 2,
    );
  }
}
