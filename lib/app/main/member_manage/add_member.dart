import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';

class AddMember extends StatefulWidget {
  final Map<String, dynamic> data;

  const AddMember({Key key, this.data}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  int sex = 1;
  TextEditingController _nameCont;
  TextEditingController _ageCont;
  TextEditingController _telCont;
  TextEditingController _numCont;
  int marital = 2;
  int birType = 1;
  Map adviser;
  int adviser2;
  List advisers = [];
  Map gw;
  String birthday = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    getData();
    print(widget.data);
    _nameCont = TextEditingController(
        text: widget.data == null || widget.data['name'] == null
            ? ''
            : widget.data['name'].toString());
    _ageCont = TextEditingController(
        text: widget.data == null || widget.data['age'] == null
            ? ''
            : widget.data['age'].toString());
    _telCont = TextEditingController(
        text: widget.data == null || widget.data['tel'] == null
            ? ''
            : widget.data['tel'].toString());
    _numCont = TextEditingController(
        text: widget.data == null || widget.data['shop_num'] == null
            ? ''
            : widget.data['shop_num'].toString());
    if (widget.data != null) {
      if (widget.data['marital'] != null) {
        marital = int.parse(widget.data['marital'].toString());
      }
      if (widget.data['adviser'] != null) {
        adviser2 = widget.data['adviser'];
      }
      if (widget.data['bir_type'] != null) {
        birType = int.parse(widget.data['bir_type'].toString());
      }
      if (widget.data['sex'] != null) {
        sex = int.parse(widget.data['sex'].toString());
      }
      if (widget.data['birthday'] != null) {
        birthday = widget.data['birthday'].toString();
      }
    }
  }

  void _add() async {
    if (_nameCont.text.length == 0 ||
        _telCont.text.length == 0 ||
        birthday.length == 0) {
      return tip(context, '姓名，电话，生日为必填');
    }
    if (_telCont.text.length != 11) {
      return tip(context, '电话必须11位');
    }
    var rs = await post(widget.data == null ? 'addvip' : 'viplevel',
        data: widget.data == null
            ? {
                'name': _nameCont.text,
                'age': _ageCont.text,
                'num': _numCont.text,
                'password': password,
                'sex': sex,
                'tel': _telCont.text,
                'marital': marital,
                'bir_type': birType,
                'birthday': birthday,
                'adviser': adviser == null ? '' : adviser['id'],
              }
            : {
                'name': _nameCont.text,
                'age': _ageCont.text,
                'num': _numCont.text,
                'password': password,
                'sex': sex,
                'tel': _telCont.text,
                'marital': marital,
                'bir_type': birType,
                'birthday': birthday,
                'adviser': adviser2,
                'id': widget.data['id'],
              });
    if (rs != null) {
      if (rs['code'] == 1) {
        back(context);
        ok(context, rs['msg']);
      } else {
        tip(context, rs['error']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.data);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Text(widget.data == null ? '添加会员' : '升级会员'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          alignment: Alignment.center,
          child: MyButton(
            onPressed: () {
              _add();
            },
            title: widget.data == null ? '添加会员' : '升级会员',
          ),
          height: 50,
        ),
      ),
      body: ListView(
        children: <Widget>[
          MyInput2(
            label: '会员编号',
            controller: _numCont,
            hintText: '请输入会员编号',
          ),
          MyInput2(
            label: '姓$kg名',
            controller: _nameCont,
            hintText: '请输入会员的姓名(必填)',
          ),
          MyInput2(
            label: '年$kg龄',
            controller: _ageCont,
            hintText: '请输入会员的年龄',
          ),
          MyInput2(
            label: '手机号码',
            controller: _telCont,
            hintText: '请输入会员的手机号码(必填)',
          ),
          MyInput2(
            label: '密$kg码',
            hintText: '默认密码为：123456',
            onChanged: (v) {
              password = v;
            },
          ),
          MyItem(
              child: MyRadio(
                onChanged: (v) {
                  setState(() {
                    sex = v;
                  });
                },
                value: sex,
                text: '女性',
                text2: '男性',
              ),
              label: '性$kg别'),
          MyItem(
              child: MyRadio(
                onChanged: (v) {
                  setState(() {
                    marital = v;
                  });
                },
                value: marital,
                text: '已婚',
                text2: '未婚',
              ),
              label: '婚$kg姻'),
          MyItem(
              child: MyRadio(
                onChanged: (v) {
                  setState(() {
                    marital = birType;
                  });
                },
                value: birType,
                text2: '阴历',
                text: '阳历',
              ),
              label: '生$kg日'),
          GestureDetector(
            onTap: () {
              showMyDate(context);
            },
            child: MyItem(
                label: '出生日期',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      birthday.length == 0 ? '请选择客户生日' : birthday,
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              birthday.length == 0 ? hintColor : Colors.black),
                    )),
                    IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: hintColor,
                        ),
                        onPressed: null)
                  ],
                )),
          ),
          GestureDetector(
            onTap: () {
              if (advisers.length == 0) {
                return tip(context, '暂无顾问');
              }
              setState(() {
                adviser = advisers[0];
              });
              showMyPicker(context);
            },
            child: MyItem(
                label: '顾$kg问',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      adviser == null ? '请选择顾问' : adviser['name'],
                      style: TextStyle(
                          fontSize: 16,
                          color: adviser == null ? hintColor : Colors.black),
                    )),
                    IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: hintColor,
                        ),
                        onPressed: null)
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void showMyDate(BuildContext context,
      {bool showTitleActions = false,
      DateTime minTime,
      DateTime maxTime}) async {
    DatePicker.showDatePicker(context,
        showTitleActions: showTitleActions,
        maxTime: maxTime,
        minTime: DateTime(min),
        currentTime: DateTime(begin),
        locale: LocaleType.zh, onChanged: (DateTime d) {
      setState(() {
        birthday = '${d.year}-${d.month}-${d.day}';
      });
    });
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
                        adviser = advisers[v];
                      });
                    },
                    children: advisers
                        .map((v) => Center(child: Text('${v['name']}')))
                        .toList()),
              ),
            ));
  }

  //Center(child: Text('test'))

  void getData() async {
    var rs = await get('get_advister');
    if (rs != null) {
      if (rs['code'] == 1) {
        advisers = rs['res'];
        setState(() {});
      } else {
        tip(context, '顾问获取失败');
      }
    }
    //print(rs);
  }
}
