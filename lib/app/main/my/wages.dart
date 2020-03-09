import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyChip.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyInput3.dart';

class Wages extends StatefulWidget {
  @override
  _WagesState createState() => _WagesState();
}

class _WagesState extends State<Wages> {
  List list;
  TextEditingController _sCon = TextEditingController(text: '');
  TextEditingController _eCon = TextEditingController(text: '');
  double total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('工资统计'),
        actions: <Widget>[
//          CupertinoButton(child: Text('导出表格'), onPressed: () {})
        ],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('每月', style: TextStyle(fontSize: 16)),
                          Container(
                            child: MyInput3(
                              controller: _sCon,
                              keyboardType: TextInputType.numberWithOptions(),
                              showBottomLine: true,
                            ),
                            width: 50,
                            alignment: Alignment.center,
                          ),
                          Text('号', style: TextStyle(fontSize: 16)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              '至',
                              style: TextStyle(color: textColor, fontSize: 16),
                            ),
                          ),
                          Text('下月', style: TextStyle(fontSize: 16)),
                          Container(
                            child: MyInput3(
                              controller: _eCon,
                              keyboardType: TextInputType.numberWithOptions(),
                              showBottomLine: true,
                            ),
                            width: 50,
                            alignment: Alignment.center,
                          ),
                          Text('号', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              '实发工资',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            total.toStringAsFixed(2),
                            style: TextStyle(
                                color: c1,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  )),
                  MyButton(
                    onPressed: () {
                      editTime();
                    },
                    title: '保存',
                    width: getRange(context) / 5,
                    height: 35,
                  )
                ],
              ),
            ),
            preferredSize: Size(getRange(context), 90)),
      ),
      body: list!=null?ListView.builder(
        itemBuilder: (_, i) => _item(i),
        itemCount: list.length,
      ):Center(child: loading(),),
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_member_wages');
    if(rs!=null){
      if(rs['code']==1){
        list = rs['res']['data'];
        for(var v in list) {
          total += double.parse(v['total_wages'].toString());
        }
        if(rs['res']['time']!=null){
          _sCon.text = rs['res']['time']['start'].toString();
          _eCon.text = rs['res']['time']['end'].toString();
        }
        setState(() {

        });
      }
    }
  }

  void editTime() async {
    String s = _sCon.text;
    String e = _eCon.text;
    var rs = await post('edit_time', data: {
      'e': e,
      's': s,
    });
    //print(rs);
    if(rs!=null){
      if(rs['code']==0){
        ok(context, rs['data'], type: 2);
      }
    }
  }

  Widget _item(int i) => Container(
        height: 160,
        decoration:
            BoxDecoration(color: bg2, borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text('${list[i]['name']}'),
                      ),
                      MyChip(
                        '${list[i]['role_name']}',
                        color: c1,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '实发工资：',
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        '${list[i]['total_wages']}',
                        style: TextStyle(color: c1),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '底薪',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          '${list[i]['salary']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '手工',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          '${list[i]['manual']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '提成',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          '${list[i]['commission']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '加班',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          '${list[i]['work_money']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '奖金',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          '${list[i]['bonus']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '扣罚',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          '${list[i]['amerce']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '项目操作',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          '${list[i]['operation']}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '底薪',
                          style: TextStyle(color: Colors.transparent),
                        ),
                        Text(
                          '3500.00',
                          style: TextStyle(color: Colors.transparent),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      );
}
