import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';

class EditMember extends StatefulWidget {
  final Map data;

  const EditMember(this.data, {Key key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<EditMember> {
  int sex = 1;
  TextEditingController _nameCont;
  TextEditingController _telCont;
  TextEditingController _addCont;
  TextEditingController _numCont;
  String address = '';
  int marital = 2;
  int birType = 1;
  String birthday = '';

  @override
  void initState() {
    super.initState();
    _nameCont = TextEditingController(text: widget.data['name']);
    _telCont = TextEditingController(text: widget.data['tel']);
    _addCont = TextEditingController(text: widget.data['address']);
    _numCont = TextEditingController(text: widget.data['shop_num']);
    sex = widget.data['sex'];
    marital = widget.data['marital'];
    birType = widget.data['bir_type'];
    birthday = widget.data['yl'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Text('编辑会员'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          alignment: Alignment.center,
          child: MyButton(
            onPressed: () {
              save();
            },
            title: '保存',
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
            label: '手机号码',
            controller: _telCont,
            hintText: '请输入会员的手机号码(必填)',
          ),
          MyInput2(
            label: '地$kg址',
            controller: _addCont,
            hintText: '请输入会员地址',
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
                text: '未婚',
                text2: '已婚',
              ),
              label: '婚$kg姻'),
          MyItem(
              child: MyRadio(
                onChanged: (v) {
                  setState(() {
                    birType = v;
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
        ],
      ),
    );
  }

  void save() async {
    if(_nameCont.text.length==0 || _telCont.text.length==0 || birthday.length==0){
      return tip(context, '姓名，手机号码，生日必填');
    }
    var rs = await post('vipdetails_edit', data: {
      'data': toString({
        'name': _nameCont.text,
        'shop_num': _numCont.text,
        'tel': _telCont.text,
        'address': _addCont.text,
        'id': widget.data['id'],
        'bir_type': birType,
        'birthday': birthday,
        'marital': marital,
        'sex': sex,
      })
    });
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }else{
        tip(context, rs['errorMsg']);
      }
    }
  }

  void showMyDate(BuildContext context,
      {bool showTitleActions = false,
      DateTime minTime,
      DateTime maxTime}) async {
    DatePicker.showDatePicker(context,
        showTitleActions: showTitleActions,
        maxTime: maxTime,
        minTime: minTime,
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
                      //print(v);
                    },
                    children: [
                      Center(child: Text('test')),
                      Center(child: Text('test')),
                      Center(child: Text('test')),
                      Center(child: Text('test')),
                    ]),
              ),
            ));
  }
}
