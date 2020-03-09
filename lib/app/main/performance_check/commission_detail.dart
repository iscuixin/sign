import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/performance_check/edit_data.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';

class CommissionDetail extends StatefulWidget {
  final int type;
  final int id;

  const CommissionDetail(this.type,
      this.id, {
        Key key,
      }) : super(key: key);

  @override
  _CommissionDetailState createState() => _CommissionDetailState();
}

class _CommissionDetailState extends State<CommissionDetail> {
  List list;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await post('performance_fei_details', data: {
      'start': '',
      'end': '',
      'type': widget.type,
      'staff': widget.id,
    });
    //print(rs.toString() + '----');
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
        title: Text('员工业绩详情'),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                width: getRange(context) + 200,
                color: bg2,
                child: Row(
                  children: <Widget>[
                    widget.type != 3 ? Expanded(
                        child: Center(child: Text('提成类型'))) : Offstage(),
                    widget.type == 1
                        ? Expanded(child: Center(child: Text('名称')))
                        : Offstage(),
                    Expanded(child: Center(child: Text('客户'))),
                    Expanded(child: Center(child: Text('消耗金额'))),
                    Expanded(child: Center(child: Text('提成业绩'))),
                    Expanded(child: Center(child: Text('时间'))),
                    Expanded(child: Center(child: Text('操作'))),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                    width: getRange(context) + 200,
                    child: list == null
                        ? Center(
                      child: loading(),
                    )
                        : ListView.builder(
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget _item(int i) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 60,
          color: bg2,
          child: Row(
            children: <Widget>[
              widget.type != 3 ? Expanded(
                  child: Center(
                      child: Text(
                        '${list[i]['raise_type'] == 1
                            ? '按提成'
                            : list[i]['raise_type'] == 2 ? '按业绩' : ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))) : Offstage(),
              widget.type == 1
                  ? Expanded(
                  child: Center(
                      child: Text(
                        '${list[i]['c_name']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )))
                  : Offstage(),
              Expanded(
                  child: Center(
                      child: Text(
                        '${list[i]['v_name'] ?? 0}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))),
              Expanded(
                  child: Center(
                      child: Text(
                          '${widget.type == 1 ? list[i]['actual'] ?? 0 : widget
                              .type == 2 || widget.type == 4
                              ? list[i]['total_price'] ?? 0:widget.type==3?list[i]['total_fee'] ?? 0:''}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${widget.type==3?list[i]['fee'] ?? 0:list[i]['money'] ?? 0}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${list[i]['time'] ?? 0}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: MyButton(
                    width: 80,
                    height: 30,
                    title: '修改',
                    onPressed: () async {
                      await jump2(
                          context, EditData(widget.type, list[i]['id']));
                      getSj();
                    },
                  ),
                ),
              ),
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
