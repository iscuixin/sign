import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/classify.dart';
import 'package:myh_shop/app/main/member_manage/add_archives.dart';
import 'package:myh_shop/app/main/member_manage/member_info.dart';
import 'package:myh_shop/common.dart';
import 'package:flutter/cupertino.dart' show CupertinoButton;
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class Manage extends StatefulWidget {
  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  List list;
  String input = '';
  int type = 1;
  TextEditingController controller = TextEditingController(text: '');
  TextEditingController controller2 = TextEditingController(text: '');
  TextEditingController inputCont = TextEditingController(text: '');
  String room = '';
  String s = '';
  String e = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    var rs = await get('get_member_list', data: {'page': 1});
    if (rs['code'] == 1) {
      setState(() {
        list = rs['res']['all_member'];
      });
    } else {
      tip(context, rs['error']);
    }
  }

  void getMem() async {
    back(context);
    String s = controller.text;
    String e = controller2.text;
    if (s.length == 0 || e.length == 0) {
      getUser();
      return;
    }
    var rs = await post('get_arrival_member', data: {'s': s, 'e': e});
    if (rs != null) {
      if (rs['code'] == 1) {
        list = rs['res'];
        setState(() {});
      }
    }
  }

  void getSy() async {
    back(context);
    String s = controller.text;
    String e = controller2.text;
    if (s.length == 0 || e.length == 0) {
      getUser();
      return;
    }
    var rs = await get('get_member_surplus', data: {'start': s, 'end': e});
//    print(rs['res'].length);
    if (rs != null) {
      if (rs['code'] == 1) {
        list = [];
        for (var v in rs['res']) {
          if (int.parse(v['current_num'].toString()) >= double.parse(s) &&
              int.parse(v['current_num'].toString()) <= double.parse(e)) {
            list.add(v);
          }
        }
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
            onPressed: () => back(context)),
        title: Text('客户管理'),
        actions: <Widget>[
          Builder(
              builder: (c) => GestureDetector(
                    onTap: () => open(c),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Image.asset(
                              'img/screen.png',
                              height: 20.0,
                              color: c1,
                            ),
                          ),
                          Text(
                            '智能筛选',
                            style: TextStyle(color: c1),
                          ),
                        ],
                      ),
                    ),
                  ))
        ],
        bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20.0, bottom: 10.0),
              child: MyInput(
                hintText: '输入姓名/电话',
                controller: inputCont,
                onChanged: (v) {
                  setState(() {
                    input = v;
                    controller.text = '';
                    controller2.text = '';
                  });
                },
                prefixIcon: Icon(
                  Icons.search,
                  color: textColor,
                ),
              ),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 50)),
        elevation: 0,
      ),
      body: list != null
          ? Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: ListTile(
                        title: Text(
                      '会员人数(${list.length})',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
                    color: Colors.white,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemBuilder: (_, i) => _item(i),
                      itemCount: list.length,
                    )
                  )
                ],
              ),
            )
          : Center(
              child: loading(),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyButton(
                onPressed: () => jump(context, 'new_manage'),
                title: '进入新客',
                width: 120,
                color: myColor(113, 204, 137),
                margin: EdgeInsets.only(left: 40.0),
              ),
              MyButton(
                onPressed: () async {
                  var rs = await Navigator.pushNamed(context, 'add_menber');
                  getUser();
                },
                title: '新增会员',
                width: 120,
                margin: EdgeInsets.only(right: 40.0),
              )
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    left: 15,
                    right: 15),
                children: <Widget>[
                  Text(
                    '智能筛选',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              type = 1;
                              controller.text = '';
                              controller2.text = '';
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, top: 10),
                            width: 60.0,
                            height: 35.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: type == 1 ? c1 : bg,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              '到店次数',
                              style: TextStyle(
                                  color:
                                      type == 1 ? Colors.white : Colors.black54,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              type = 2;
                              controller.text = '';
                              controller2.text = '';
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, top: 10),
                            width: 60.0,
                            height: 35.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: type == 2 ? c1 : bg,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              '剩余次数',
                              style: TextStyle(
                                  color:
                                      type == 2 ? Colors.white : Colors.black54,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              type = 3;
                              getUser();
                              controller.text = '';
                              controller2.text = '';
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, top: 10),
                            width: 60.0,
                            height: 35.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: type == 3 ? c1 : bg,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              '余额查询',
                              style: TextStyle(
                                  color:
                                      type == 3 ? Colors.white : Colors.black54,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        GestureDetector(
                          onTap: () async{
                            getUser();
                            back(context);
                            setState(() {
                              type=4;
                            });
                            String rs = await jump2(context, AddArchives(-1));
                            if(rs==null){
                              return;
                            }
                            List arr = rs.split(',');
                            List need = [];
                            for(var v in arr) {
                              if(need.indexOf(v)<0){
                                need.add(v);
                              }
                            }
                            List data = [];
                            for(var x in need) {
                              for(var v in list) {
                                if(x.toString() == v['id'].toString()){
                                  data.add(v);
                                  break;
                                }
                              }
                            }
                            list = data;
                            setState(() {

                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, top: 10),
                            width: 60.0,
                            height: 35.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: type == 4 ? c1 : bg,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              '健康筛选',
                              style: TextStyle(
                                  color:
                                      type == 4 ? Colors.white : Colors.black54,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                        Offstage(),
                        Offstage(),
                      ]),
                    ],
                  ),
                  type==4?Offstage():Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          type == 1
                              ? '到店次数'
                              : type == 2 ? '剩余次数' : type == 3 ? '余额查询' : '健康筛选',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                child: MyInput(
                                  controller: controller,
                                  onChanged: (v) {
                                    s = v;
                                  },
                                  keyboardType: TextInputType.numberWithOptions(),
                                  hintText: type == 1
                                      ? '到店次数'
                                      : type == 2 ? '剩余次数' : type == 3 ? '0.00元' : '',
                                  hintStyle: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('至'),
                            ),
                            Expanded(
                                child: MyInput(
                                  keyboardType: TextInputType.numberWithOptions(),
                                  controller: controller2,
                                  onChanged: (v) {
                                    e = v;
                                  },
                                  hintText: type == 1
                                      ? '到店次数'
                                      : type == 2 ? '剩余次数' : type == 3 ? '0.00元' : '',
                                  hintStyle: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 40.0,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.top ?? 10),
                    child: CupertinoButton(
                      padding: EdgeInsets.all(0),
                      borderRadius: BorderRadius.circular(30.0),
                      child: Text('确定'),
                      onPressed: () {
                        if (type == 1) {
                          getMem();
                        } else if (type == 2) {
                          getSy();
                        } else if (type == 3) {
                          back(context);
                          String s = controller.text;
                          String e = controller2.text;
                          if (s.length == 0 || e.length == 0) {
                            getUser();
                            return;
                          }
                          List r = [];
                          for (var v in list) {
                            if (double.parse(v['balance'].toString()) >=
                                    double.parse(s) &&
                                double.parse(v['balance'].toString()) <=
                                    double.parse(e)) {
                              r.add(v);
                            }
                          }
                          list = r;
                          setState(() {});
                        }
                      },
                      color: c1,
                    )),
              ),
            ],
          ),
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
              0 &&
          list[i]['tel'].toString().toLowerCase().indexOf(input.toLowerCase()) <
              0) {
        return Offstage();
      }
    }
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 15.0),
          color: Colors.white,
          child: ListTile(
            onTap: () async {
              var rs = await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MemberInfo(list[i]['id'])));
              getUser();
            },
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                list[i]['sex'] == 1 ?'https://myh.myhkj.cn/images/backend/woman.png':'https://myh.myhkj.cn/images/backend/man.png'
              ),
            ),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                  child: Text(
                    '${list[i]['name']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Image.asset(
                    getImg(list[i]['sex'] == 1 ? 'woman' : 'man'),
                    height: 15.0,
                    color: textColor,
                  ),
                ),
                Container(
                  width: 50,
                  child: Text(
                    '${list[i]['shop_num'] ?? ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: textColor, fontSize: 13),
                  ),
                )
              ],
            ),
            subtitle: Text(
              '${list[i]['tel']}',
              style: TextStyle(color: textColor),
            ),
            trailing: Container(
              width: getRange(context) / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyButton(
                    title: '购买',
                    color: c3,
                    onPressed: () {
                      jump2(context, Classify(list[i]['id']));
                    },
                    width: 60,
                    height: 30,
                    titleStyle: TextStyle(fontSize: 14),
                  ),
                  MyButton(
                    title: '到店',
                    onPressed: () async {
                      //jump2(context, Classify(1));
                      showModel(list[i]['id']);
                    },
                    width: 60,
                    height: 30,
                    titleStyle: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }

/*Material(
                color: bg2,
                child: MyInput2(
                  label: '房间号',
                  hintText: '请输入房间号',
                  onChanged: (v) {
                    room = v;
                  },
                ),
              )*/
  void showModel(id) async {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('请输入房间号'),
              content: CupertinoTextField(
                placeholder: '请输入房间号',
                keyboardType: TextInputType.numberWithOptions(),
                autofocus: true,
                onChanged: (v) {
                  room = v;
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
                  child: Text('确定'),
                  onPressed: () async {
                    if (room.length == 0) {
                      return tip(context, '请输入房间号');
                    }
                    var rs = await addArrive(id, room);
                    if (rs['code'] == 1) {
                      room = '';
                      getComeShop();
                      ok(context, rs['Msg']);
                    } else {
                      tip(context, rs['errorMsg']);
                    }
                    //print(rs);
                  },
                ),
              ],
            ));
  }

  void open(BuildContext c) async {
    Scaffold.of(c).openEndDrawer();
  }
}
