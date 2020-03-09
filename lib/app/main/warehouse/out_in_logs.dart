import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyInput.dart';

class OutInLogs extends StatefulWidget {
  final int id;

  const OutInLogs(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _OutInLogsState createState() => _OutInLogsState();
}

class _OutInLogsState extends State<OutInLogs> with TickerProviderStateMixin {
  List inData;
  List out;
  TabController _tabController;
  int now = 0;
  String input = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        now = _tabController.index;
      });
    });
    getSj();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void getSj({String day = ''}) async {
    var rs = await post('get_record_detail', data: {
      'day': day,
      'ware': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        //print(rs);
        List i = [];
        List o = [];
        for (var v in rs['res']) {
          if (v['status'] == 1) {
            i.add(v);
          } else {
            o.add(v);
          }
        }
        setState(() {
          inData = i;
          out = o;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('出入库流水记录'),
          bottom: PreferredSize(
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: [
                      Tab(
                        text: '入库',
                      ),
                      Tab(
                        text: '出库',
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 20, left: 10),
                          height: 35,
                          child: MyInput(
                            prefixIcon: Icon(
                              Icons.search,
                              color: textColor,
                            ),
                            hintText: '输入名称',
                            onChanged: (v){
                              setState(() {
                                input = v;
                              });
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showMyDate(context);
                          }),
                    ],
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
                    Expanded(child: Center(child: Text('入库时间'))),
                    Expanded(child: Center(child: Text('名称'))),
                    now == 1
                        ? Expanded(child: Center(child: Text('出库类型')))
                        : Offstage(),
                    Expanded(child: Center(child: Text('入库数量'))),
                    Expanded(child: Center(child: Text('操作人'))),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  inData != null
                      ? ListView.builder(
                          itemBuilder: (_, i) => _item(i, 1),
                          itemCount: inData.length,
                        )
                      : Center(
                          child: loading(),
                        ),
                  out != null
                      ? ListView.builder(
                          itemBuilder: (_, i) => _item(i, 2),
                          itemCount: out.length,
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
      length: 2,
    );
  }

  Widget _item(int i, t) {
    Map data;
    if (t == 1) {
      data = inData[i];
    } else {
      data = out[i];
    }
    if(input.length>0){
      if(data['name'].toString().toLowerCase().indexOf(input.toLowerCase()) < 0){
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
                '${data['time']}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))),
              Expanded(
                  child: Center(
                      child: Text('${data['name']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              t == 2
                  ? Expanded(
                      child: Center(
                          child: Text(
                              '${data['type'] == 1 ? '消费出库' : data['type'] == 2 ? '调仓出库' : '手动出库'}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)))
                  : Offstage(),
              Expanded(
                  child: Center(
                      child: Text('${data['sum']}',
                          maxLines: 1, overflow: TextOverflow.ellipsis))),
              Expanded(
                  child: Center(
                      child: Text('${data['operation_human']}',
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

  void showMyDate(BuildContext context,
      {bool showTitleActions = true,
      DateTime minTime,
      DateTime maxTime}) async {
    DatePicker.showDatePicker(context,
        showTitleActions: showTitleActions,
        maxTime: maxTime,
        minTime: minTime,
        locale: LocaleType.zh, onConfirm: (DateTime d) {
      getSj(day: '${d.year}-${d.month}-${d.day}');
    });
  }
}
