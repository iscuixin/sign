import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/my/staff_add.dart';
import 'package:myh_shop/app/main/my/wages_edit.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;

class StaffDetail extends StatefulWidget {
  final int id;

  const StaffDetail(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _StaffDetailState createState() => _StaffDetailState();
}

class _StaffDetailState extends State<StaffDetail> {
  dynamic type;
  Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
          child: MyButton(
            color: Colors.red,
            onPressed: () async {
              var rs = await showAlert(context, '是否离职？');
              if (rs) {
                leave();
              }
            },
            title: '离职',
          ),
        ),
      ),
      body: data != null
          ? Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: getRange(context, type: 2) / 4,
                      width: getRange(context),
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            getImg('5.21_01'),
                            fit: BoxFit.fill,
                            height: getRange(context, type: 2) / 4,
                            width: getRange(context),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: getRange(context, type: 3)),
                            child: backButton(context, color: bg2),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 120, left: 15, right: 15),
                      height: getRange(context, type: 2) * 3 / 4 -
                          getRange(context, type: 4) -
                          50,
                      width: getRange(context),
                      color: bg2,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      '上月工资总计',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  Text(
                                    '¥${data['total_wages']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var rs = await jump2(
                                      context,
                                      WagesEdit(data['id']));
                                  getSj();
                                },
                                child: Text(
                                  '工资调整',
                                  style: TextStyle(color: c1, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Divider(),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              '底薪',
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            '¥${data['salary']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              '奖金',
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            '¥${data['bonus']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              '提成',
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            '¥${data['commission']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              '手工',
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            '¥${data['manual']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              '加班',
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            '¥${data['work_money']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              '扣罚',
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            '¥${data['amerce']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: getRange(context, type: 2) / 4 - 100,
                  left: 15,
                  right: 15,
                  child: Container(
                    child: InkWell(
                      onTap: () async {
                        await jump2(context, StaffAdd(id: data['id'],));
                        getSj();
                      },
                      child: Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              height: 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: circularImg(
                                        'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                                        70, t: 2),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${data['name']}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  getImg('5.3_03'),
                                                  width: 13,
                                                  height: 13,
                                                  fit: BoxFit.fill,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    '${data['number']}',
                                                    style: TextStyle(color: c1),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Image.asset(getImg('5.3_06'),
                                                  width: 13,
                                                  height: 13,
                                                  fit: BoxFit.fill),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  '${data['mobile']}',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Icon(Icons.chevron_right)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Divider(
                                height: 0,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '上月总业绩',
                                        style: TextStyle(color: textColor),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${data['AchieveTotal']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '上月消费业绩',
                                        style: TextStyle(color: textColor),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${data['XfTotalMoney']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '上月消耗业绩',
                                        style: TextStyle(color: textColor),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${data['XhTotalMoney']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    height: 190,
                    width: getRange(context),
                  ),
                )
              ],
            )
          : Center(
              child: loading(),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('staffDetail', data: {
      'staff': widget.id,
    });
    if (rs != null) {
      setState(() {
        type = rs['type'];
        data = rs['res'];
      });
    }
  }

  void leave() async {
    var rs = await post('StaffLeave', data: {
      'staff': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }
}
