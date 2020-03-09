import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/model/user.dart';
import 'package:scoped_model/scoped_model.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  List list = [
    {'name': '权限管理', 'img': '5.0_16', 'id': 1},
    {'name': '客户分配', 'img': '5.0_19', 'id': 2},
    {'name': '店员管理', 'img': '5.0_22', 'id': 3},
    {'name': '负债率', 'img': '5.0_27', 'id': 4},
    {'name': '订单中心', 'img': '5.0_28', 'id': 5},
    {'name': '员工工资', 'img': '5.0_29', 'id': 6},
    {'name': '积分管理', 'img': '5.0_33', 'id': 7},
    {'name': '打印设置', 'img': '5.0_34', 'id': 8},
    {'name': '员工分析', 'img': '5.0_35', 'id': 9},
  ];

  @override
  void initState() {
    super.initState();
    print(userModel.loginData['days']);
    if(userModel.loginData['type']==2){
      list.removeAt(0);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: userModel,
      child: ScopedModelDescendant<UserModel>(builder: (_, __, v) {
        print(v.loginData.toString());
        return Container(
          color: bg2,
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverAppBar(
                title: Container(
                  height: 80,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '个人中心',
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                      ),
                      v.loginData['days']<=7?Text(
                        '提示：还有${(v.loginData['days'])}天到期，请联系管理员续费哦',
                        style: TextStyle(color: Colors.white,fontSize: 14,),textAlign: TextAlign.left,
                      ):Offstage(),
                    ],
                  ),
                ),
                centerTitle: true,
                brightness: Brightness.dark,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        jump(context, 'setting');
                      })
                ],
                leading: Offstage(),
                expandedHeight: 220,
                backgroundColor: c1,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              getImg('5.01_01'),
                              fit: BoxFit.fill,
                              width: getRange(context),
                            ),
                            height: 150 + getRange(context, type: 3),
                          ),
                          Container(
                            color: Colors.white,
                            height: 70,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        left: 10,
                        child: Container(
                          height: 120,
                          width: getRange(context),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: circularImg(
                                        '${(v.loginData['type'] == 1 ? v.loginData['logo'] : (v.loginData['head_img'] == null || v.loginData['head_img'] == '' ? 'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg':v.loginData['head_img']))}',
                                        80, t: (v.loginData['type'] == 1 ? v.loginData['logo'] : v.loginData['head_img'])==null?2:1),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          '${v.loginData['name']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.home,
                                                  color: c1,
                                                ),
                                                Text(
                                                    '${v.loginData['type'] == 1 ? v.loginData['num'] : v.loginData['store_name']}'),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.phone,
                                                  color: c1,
                                                ),
                                                Text(
                                                    '${v.loginData['mobile']}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              color: c1,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${v.loginData['type'] == 1 ? v.loginData['address'] : v.loginData['number']}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((_, i) => _item(i, v),
                        childCount: list.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, crossAxisSpacing: 10)),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _item(int i, UserModel v) => GestureDetector(
        onTap: () {
          switch (list[i]['id']) {
            case 1:
              jump(context, 'jur_list');
              break;
            case 2:
              jump(context, 'clerk_manage');
              break;
            case 3:
              jump(context, 'staff_manage');
              break;
            case 4:
              jump(context, 'load_rate');
              break;
            case 5:
              jump(context, 'order');
              break;
            case 6:
              jump(context, 'wages');
              break;
            case 8:
              jump(context, 'printer');
              break;
            case 9:
              jump(context, 'analysis');
              break;
          }
        },
        child: Column(
          children: <Widget>[
            Image.asset(
              getImg(list[i]['img']),
              height: 65.0,
              width: 65.0,
            ),
            Text(list[i]['name']),
          ],
        ),
      );
}
