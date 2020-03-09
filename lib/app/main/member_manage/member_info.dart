import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/member_manage/archives.dart';
import 'package:myh_shop/app/main/member_manage/arrears.dart';
import 'package:myh_shop/app/main/member_manage/card.dart';
import 'package:myh_shop/app/main/member_manage/consume_detail.dart';
import 'package:myh_shop/app/main/member_manage/coupon.dart';
import 'package:myh_shop/app/main/member_manage/entry.dart';
import 'package:myh_shop/app/main/member_manage/info.dart';
import 'package:myh_shop/app/main/member_manage/integral.dart';
import 'package:myh_shop/app/main/member_manage/items.dart';
import 'package:myh_shop/app/main/member_manage/member_need.dart';
import 'package:myh_shop/app/main/member_manage/my_coupon.dart';
import 'package:myh_shop/app/main/member_manage/plan.dart';
import 'package:myh_shop/app/main/member_manage/product.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:flutter/cupertino.dart';

class MemberInfo extends StatefulWidget {
  final int id;

  MemberInfo(this.id);

  @override
  _MemberInfoState createState() => _MemberInfoState();
}

class _MemberInfoState extends State<MemberInfo> {
  double width = 90;
  Map user;
  String money = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs =
        await get('vipDetails', data: {'id': widget.id, 'redirect_url': ''});
    if (rs != null) {
      if (rs['code'] == 0) {
        //print(rs);
        setState(() {
          user = rs['data'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          user == null
              ? Center(
                  child: loading(),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      brightness: Brightness.dark,
                      backgroundColor: c1,
                      leading: backButton(context, color: Colors.white),
                      pinned: true,
                      title: Text(
                        '会员信息',
                        style: TextStyle(color: Colors.white),
                      ),
                      centerTitle: true,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 100,
                                width: getRange(context) - 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${user['name']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Image.asset(
                                              getImg(user['sex'] == 1
                                                  ? 'woman'
                                                  : 'man'),
                                              height: 18,
                                              color: textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${user['shop_num']}',
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              child: GestureDetector(
                                onTap: () async {
                                  await jump2(context, Entry(widget.id));
                                  getSj();
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.centerEnd,
                                  children: <Widget>[
                                    Container(
                                      height: 25,
                                      width: 75,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          '录入',
                                          style: TextStyle(color: c1),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border:
                                              Border.all(width: 2, color: c1)),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border:
                                              Border.all(width: 2, color: c1)),
                                      child: Icon(
                                        Icons.edit,
                                        size: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              bottom: 85,
                              left: getRange(context) / 2 -
                                  (getRange(context) - 20) / 4 -
                                  width / 2,
                            ),
                            Positioned(
                              child: GestureDetector(
                                onTap: () {
                                  launcherTel('${user['tel']}');
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.centerStart,
                                  children: <Widget>[
                                    Container(
                                      height: 25,
                                      width: 75,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          '电话',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(color: c1),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border:
                                              Border.all(width: 2, color: c1)),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border:
                                              Border.all(width: 2, color: c1)),
                                      child: Icon(
                                        Icons.phone,
                                        size: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              bottom: 85,
                              right: getRange(context) / 2 -
                                  (getRange(context) - 20) / 4 -
                                  width / 2,
                            ),
                            Positioned(
                              child: Center(
                                child: circularImg(
                                    'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                                    width, t: 2),
                              ),
                              bottom: 50,
                              left: getRange(context) / 2 - width / 2,
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Container(
                        child: Card(
                          elevation: 8,
                          margin: EdgeInsets.all(0),
                          child: Row(
                            children: <Widget>[
                              _item2('账户余额', '${user['balance']}', 1),
                              _item2('赠送余额', '${user['send_balance']}', 2),
                              _item2('总欠款', '${user['money']}', 3),
                              _item2('积分', '${user['integral']}', 4),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 80,
                      ),
                      _item(context, '健康档案', '会员身体分析档案', 1),
                      _item(context, '消费明细', '全部消费明细', 2),
                      _item(context, '基本信息', '电话/生日/地址', 3),
                      _item(context, '优惠券查看', '共${user['coupon_num']}张', 4),
                      _item(
                          context, '会员项目', '剩余项目${user['items_num'] ?? 0}次', 5),
                      _item(context, '会员套盒', '剩余套盒${user['box_num'] ?? 0}次', 6),
                      _item(context, '会员产品', '累计购买¥${user['goods_total'] ?? 0}',
                          7),
                      _item(context, '所持卡项', '总余额¥${user['card_amount'] ?? 0}',
                          8),
                      _item(context, '方案打包',
                          '累计购买¥${user['plan_total_money'] ?? 0}', 9),
                      _item(context, '客户需求', '', 10),
                      bottom(context, height: getRange(context, type: 4) + 50),
                    ])),
                  ],
                ),
          Positioned(
            bottom: 0,
            child: PhysicalShape(
              clipper:
                  const ShapeBorderClipper(shape: RoundedRectangleBorder()),
              color: Colors.white,
              elevation: 10,
              child: Container(
                padding: EdgeInsets.only(bottom: getRange(context, type: 4)),
                alignment: Alignment.center,
                child: MyButton(
                  onPressed: () async{
                    if(await showAlert(context, '是否删除该会员?')){
                      delData();
                    }
                  },
                  title: '删除会员',
                ),
                height: 50 + getRange(context, type: 4),
                width: getRange(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  void delData() async {
    var rs = await post('DelMember', data: {
      'type': 'member',
      'id': widget.id,
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
  }

  Expanded _item2(String text, String text2, int t) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        if (t == 1 || t == 2) {
          show(t);
        }
        if (t == 3) {
          jump2(context, MyArrears(widget.id));
        }
        if (t == 4) {
          jump2(context, Integral(widget.id));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
          Padding(padding: EdgeInsets.all(5)),
          Text(
            '¥$text2',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ));
  }

  void show(int type) async {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text('账户余额修改'),
            content: CupertinoTextField(
              keyboardType: TextInputType.numberWithOptions(),
              placeholder: '请输入要修改的账户余额',
              onChanged: (v) {
                money = v;
              },
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  back(context);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  '确定',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  editBalance(type);
                },
              ),
            ],
          ),
    );
  }

  void editBalance(type) async {
    if (money.length == 0) {
      return tip(context, '请输入金额');
    }
    var rs = await post('modify_send_balance', data: {
      'id': widget.id,
      'money': money,
      'type': type,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        getSj();
        back(context);
      }
    }
  }

  Column _item(
    BuildContext context,
    String title,
    String text,
    int type,
  ) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () async {
            switch (type) {
              case 1:
                jump2(context, Archives(widget.id));
                break;
              case 2:
                jump2(context, ConsumeDetail(widget.id));
                break;
              case 3:
                var rs = await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Info(widget.id)));
                break;
              case 4:
                jump2(context, MyCoupon(widget.id));
                break;
              case 5:
                jump2(context, Items(widget.id, 'items'));
                break;
              case 6:
                jump2(context, Items(widget.id, 'box'));
                break;
              case 7:
                jump2(context, Product(widget.id));
                break;
              case 8:
                jump2(context, MyCard(widget.id));
                break;
              case 9:
                jump2(context, Items(widget.id, 'plan'));
                break;
              case 10:
                jump2(context, MemberNeed(widget.id));
                break;
              default:
                break;
            }
            getSj();
          },
          leading: Icon(Icons.add),
          title: Text(title),
          trailing: Container(
            width: getRange(context) / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(color: textColor),
                ),
                Icon(
                  Icons.chevron_right,
                  color: textColor,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }
}
