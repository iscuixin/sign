import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';

class ConsumeInfo extends StatefulWidget {
  final String type;

  const ConsumeInfo({Key key, this.type}) : super(key: key);

  @override
  _ConsumeInfoState createState() => _ConsumeInfoState();
}

class _ConsumeInfoState extends State<ConsumeInfo> {
  List list;
  String title = '';
  String input = '';

  @override
  void initState() {
    super.initState();
    if (widget.type == 'items') {
      title = '项目消耗详情';
    } else {
      title = '套盒消耗详情';
    }
    getSj();
  }

  void getSj() async {
    var rs = await get('consumed_detail_list', data: {
      'end': '',
      'start': '',
      'type': widget.type,
    });
    if (rs != null) {
      //print(rs);
      setState(() {
        list = rs['list'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(title),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
              child: MyInput(
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
                hintText: '输入姓名',
                onChanged: (v) {
                  setState(() {
                    input = v;
                  });
                },
              ),
            ),
            preferredSize: Size(getRange(context), 55)),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 50,
            color: bg2,
            width: getRange(context),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: 100,
                    child: Text('消耗人'),
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Container(
                      width: 150,
                      child: Text('名称'),
                      alignment: Alignment.center),
                ),
                Expanded(
                  child: Container(
                      width: 100,
                      child: Text('金额'),
                      alignment: Alignment.center),
                ),
                Expanded(
                  child: Container(
                      width: 100,
                      child: Text('消耗次数'),
                      alignment: Alignment.center),
                ),
                Expanded(
                    child: Container(
                        child: Text('时间'), alignment: Alignment.center)),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: list != null
                ? Container(
                    color: bg2,
                    width: getRange(context) * 2,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    ),
                  )
                : Center(
                    child: loading(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _item(int i) {
    if(input.length>0) {
      if(list[i]['name'].toString().toLowerCase().indexOf(input.toLowerCase()) < 0){
        return Offstage();
      }
    }
    return Column(
      children: <Widget>[
        Container(
          height: 50,
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
                '${list[i]['designation_name']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['consume_money']}',
                          style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Center(
                      child: Text(
                '${list[i]['consume_num']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['time']}',
                          style: TextStyle(fontSize: 12)))),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
