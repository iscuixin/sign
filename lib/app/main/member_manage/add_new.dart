import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';

class AddNew extends StatefulWidget {
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  Map<String, dynamic> data = {
    'name': '',
    'age': '',
    'tel': '',
    'sex': 1,
    'type': 1,
    'weixin': '',
    'adviser': '',
  };
  List members = [];
  List staff = [];
  Map nowStaff;
  Map nowMem;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('guest_operation');
    if (rs != null) {
      if (rs['code'] == 1) {
        staff = rs['res']['staff_arr'];
        members = rs['res']['member_list'];
        setState(() {

        });
      }
    }
  }

  void showMyPicker(BuildContext context, int t) async {
    List data;
    if (t == 1) {
      data = members;
    } else {
      data = staff;
    }
//    print(data);
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: getRange(context, type: 2) / 3,
              child: CupertinoApp(
                home: CupertinoPicker(
                    useMagnifier: true,
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    magnification: 1.2,
                    onSelectedItemChanged: (v) {
                      setState(() {
                        if (t == 1) {
                          nowMem = data[v];
                        } else {
                          nowStaff = data[v];
                        }
                      });
                    },
                    children: data
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('添加新客/嘉宾'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          alignment: Alignment.center,
          child: MyButton(
            onPressed: data['tel'].toString().length > 0 &&
                    data['name'].toString().length > 0
                ? () {
                    add();
                  }
                : null,
            title: '添加新客',
          ),
          height: 50,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                showMyPicker(context, 1);
              },
              child: MyItem(
                  label: '推荐人',
                  child: Text(
                    nowMem == null ? '选择推荐人' : nowMem['name'],
                    style: TextStyle(
                        color: nowMem == null ? hintColor : Colors.black,
                        fontSize: 16),
                  )),
            ),
            MyInput2(
              label: '姓$kg名',
              hintText: '请输入客户姓名(必填)',
              onChanged: (v) {
                setState(() {
                  data['name'] = v;
                });
              },
            ),
            MyInput2(
              label: '年$kg龄',
              keyboardType: TextInputType.numberWithOptions(),
              hintText: '请输入客户的年龄',
              onChanged: (v) {
                setState(() {
                  data['age'] = v;
                });
              },
            ),
            MyInput2(
              label: '手机号码',
              keyboardType: TextInputType.numberWithOptions(),
              hintText: '请输入客户的手机号码(必填)',
              onChanged: (v) {
                setState(() {
                  data['tel'] = v;
                });
              },
            ),
            /*MyInput2(
              label: '微信号码',
              hintText: '请输入客户的微信号码',
              onChanged: (v) {
                setState(() {
                  data['weixin'] = v;
                });
              },
            ),*/
            MyItem(
                child: MyRadio(
                  onChanged: (v) {
                    setState(() {
                      data['type'] = v;
                    });
                  },
                  text: '新客',
                  text2: '嘉宾',
                ),
                label: '类$kg型'),
            MyItem(
                child: MyRadio(
                  onChanged: (v) {
                    setState(() {
                      data['sex'] = v;
                    });
                  },
                  text: '女性',
                  text2: '男性',
                ),
                label: '性$kg别'),
            GestureDetector(
              onTap: (){
                showMyPicker(context, 2);
              },
              child: MyItem(
                  label: '顾$kg问',
                  child: Text(
                    nowStaff == null ? '选择顾问' : nowStaff['name'],
                    style: TextStyle(
                        color: nowStaff == null ? hintColor : Colors.black,
                        fontSize: 16),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void add() async {
    if(data['name'].toString().length==0){
      tip(context, '请输入姓名');
      return;
    }
    if (data['tel'].toString().length != 11) {
      tip(context, '请输入11位手机号码');
      return;
    }
    var rs = await post('guest_operation', data: {
      'data': {
        'tel': data['tel'],
        'name': data['name'],
        'age': data['age'],
        'member': nowMem==null?'':nowMem['id'],
        'staff': nowStaff==null?'':nowStaff['id'],
        'type': data['type'],
        'sex': data['sex'],
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, '添加成功');
      } else {
        tip(context, '添加失败');
      }
    }
    //print(rs);
  }
}
