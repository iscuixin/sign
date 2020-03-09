import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';

class StaffAdd extends StatefulWidget {
  final int id;

  const StaffAdd({Key key, this.id}) : super(key: key);
  @override
  _StaffAddState createState() => _StaffAddState();
}

class _StaffAddState extends State<StaffAdd> {
  TextEditingController _snCon = TextEditingController(text: '');
  TextEditingController _nameCon = TextEditingController(text: '');
  TextEditingController _telCon = TextEditingController(text: '');
  TextEditingController _pwdCon = TextEditingController(text: '');
  int gender = 1;
  int married = 1;
  Map zw;
  String bir = '';
  List role;
  Map data;

  @override
  void initState() {
    super.initState();
    if(widget.id==null){
      getSj();
    }else{
      getDetail();
    }
  }

  void getDetail() async {
    var rs = await get('updatePageDetail', data: {
      'staff': widget.id,
    });
    if(rs!=null){
      if(rs['code']==1){
        data = rs['res']['returnStaff'];//print(data);
        role = rs['res']['role'];
        _nameCon.text = data['name'].toString();
        _telCon.text = data['mobile'].toString();
        for(var v in role) {
          if(v['id'] == data['role_id']){
            zw = v;
            break;
          }
        }
        setState(() {

        });
      }
    }
  }

  void getSj() async {
    var rs = await get('addInit');
    if (rs != null) {
      setState(() {
        role = rs['res']['role'];
      });
    }
  }

  void update() async {
    String pwd = _pwdCon.text;
    String name = _nameCon.text;
    String tel = _telCon.text;
    if (name.length == 0 || tel.length == 0 || zw == null ) {
      return tip(context, '请填完以上内容');
    }
    if (tel.length != 11) {
      return tip(context, '请输入11位手机号码');
    }
    var rs = await post('updatePageDetail', data: {
      'data': {
        'id': widget.id,
        'name': name,
        'mobile': tel,
        'role_id': zw['id'],
        'head_img': '',
        'password': pwd,
      }
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text(widget.id==null?'新增员工':'编辑员工'),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 15),
        child: ListView(
          children: <Widget>[
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  //padding: EdgeInsets.only(left: 15),
                  height: 60,
                  child: Text(
                    '店员照片',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  ),
                  alignment: Alignment.center,
                  width: 100,
                ),
                circularImg(
                    'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                    50)
              ],
            ),
            Divider(
              height: 0,
            ),*/
            GestureDetector(
              onTap: () {
                if(role.length>0){
                  showMyPicker(context);
                  if(zw==null){
                    setState(() {
                      zw = role[0];
                    });
                  }
                }else{
                  tip(context, '请先添加职位');
                }
              },
              child: MyItem(
                  label: '员工职位',
                  child: Text(
                    zw==null?'点击选择':zw['role_name'],
                    style: TextStyle(fontSize: 16, color: zw==null?hintColor:Colors.black),
                  )),
            ),
            Offstage(
              offstage: widget.id==null?false:true,
              child: MyInput2(
                label: '编$kg号',
                hintText: '请输入员工编号(必填)',
                controller: _snCon,
              ),
            ),
            MyInput2(
              label: '姓$kg名',
              hintText: '请输入员工姓名(必填)',
              controller: _nameCon,
            ),
            MyInput2(
              label: '手机号码',
              hintText: '请输入员工手机号码(必填)',
              controller: _telCon,
            ),
            MyInput2(
              label: '密$kg码',
              hintText: '默认密码123456',
              controller: _pwdCon,
            ),
            Offstage(
              offstage: widget.id==null?false:true,
              child: Column(
                children: <Widget>[
                  MyItem(
                      label: '性$kg别',
                      child: MyRadio(
                        onChanged: (v){
                          gender = v;
                        },
                        text2: '男性',
                        text: '女性',
                        value: gender,
                      )),
                  MyItem(
                      label: '婚$kg姻',
                      child: MyRadio(
                        onChanged: (v){
                          married = v;
                        },
                        text2: '未婚',
                        text: '已婚',
                        value: married,
                      )),
                  MyItem(
                      label: '生$kg日',
                      child: Text(
                        '点击选择',
                        style: TextStyle(fontSize: 16, color: textColor),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: MyButton(
                title: widget.id==null?'确认添加':'确认修改',
                onPressed: () {
                  if(widget.id==null){
                    saveData();
                  }else{
                    update();
                  }
                },
                height: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveData() async {
    String pwd = _pwdCon.text;
    String name = _nameCon.text;
    String tel = _telCon.text;
    String sn = _snCon.text;
    if (name.length == 0 || tel.length == 0 || zw == null || sn.length == 0) {
      return tip(context, '请填完以上内容');
    }
    if (tel.length != 11) {
      return tip(context, '请输入11位手机号码');
    }
    var rs = await post('addstaff', data: {
      'info': {
        'name': name,
        'number': sn,
        'tel': tel,
        'sex': gender,
        'mar': married,
        'check_role': zw['id'],
        'bir': bir,
        'psw': pwd,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  void showMyPicker(BuildContext context) async {
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
                        zw = role[v];
                      });
                    },
                    children:
                        role.map((v) => Center(child: Text('${v['role_name']}'))).toList()),
              ),
            ));
  }
}
