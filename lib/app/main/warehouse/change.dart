import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/warehouse/dc.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class Change extends StatefulWidget {
  final int id;

  const Change(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _ChangeState createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  List list;
  String input = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_transfer_goods');
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['res'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('商品调仓'),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
              child: MyInput(
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
                hintText: '输入商品名称',
                onChanged: (v) {
                  setState(() {
                    input = v;
                  });
                },
              ),
            ),
            preferredSize: Size(getRange(context), 50)),
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
                  Expanded(child: Center(child: Text('剩余库存'))),
                  Expanded(child: Center(child: Text('操作'))),
                ],
              ),
            ),
            Expanded(
              child: list != null
                  ? ListView.builder(
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    )
                  : Center(
                      child: loading(),
                    ),
            )
          ],
        ),
      ),
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
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 60,
          color: bg2,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['name']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['stock']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ))),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: MyButton(
                    onPressed: () async {
                      await jump2(context,
                          Dc(list[i]['id'], widget.id, list[i]['cate']));
                    },
                    title: '调仓'),
              )),
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
