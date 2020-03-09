import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';

class AddCoupon extends StatefulWidget {
  final int id;

  const AddCoupon({Key key, this.id}) : super(key: key);
  @override
  _AddCouponState createState() => _AddCouponState();
}

class _AddCouponState extends State<AddCoupon> {
  TextEditingController _nameCon = TextEditingController(text: '');
  TextEditingController _manCon = TextEditingController(text: '');
  TextEditingController _janCon = TextEditingController(text: '');
  TextEditingController _yuanCon = TextEditingController(text: '');
  int now = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text(widget.id==null?'新增优惠券':'编辑优惠券'),
      ),
      body: ListView(
        children: <Widget>[
          MyItem(
            child: MyRadio(
              text2: '抵扣',
              text: '满减',
              value: now,
              onChanged: (v) {
                setState(() {
                  now = v;
                });
              },
            ),
            label: '类$kg型',
          ),
          MyInput2(
            controller: _nameCon,
            label: '名$kg称',
            hintText: '请输入优惠券名称',
          ),
          /*MyInput2(
            label: '数$kg量',
            hintText: '请输入优惠券数量',
          ),
          MyInput2(
            label: '领取上限',
            hintText: '没人最多领取x张',
          ),*/
          MyItem(
              label: now == 1 ? '属$kg性' : '抵$kg扣',
              child: now == 1
                  ? Row(
                      children: <Widget>[
                        Text(
                          '满',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          child: TextField(
                            controller: _manCon,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: '0.00'),
                            textAlign: TextAlign.center,
                          ),
                          width: 60,
                          alignment: Alignment.center,
                        ),
                        Text(
                          '减',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _janCon,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: '0.00'),
                            textAlign: TextAlign.center,
                          ),
                          width: 60,
                          alignment: Alignment.center,
                        ),
                      ],
                    )
                  : Row(
                      children: <Widget>[
                        Container(
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _yuanCon,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: '0.00'),
                            textAlign: TextAlign.center,
                          ),
                          width: 60,
                          alignment: Alignment.center,
                        ),
                        Text(
                          '元',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
          /*MyItem(
              label: '日$kg期',
              child: Row(
                children: <Widget>[
                  Text(
                    '选取开始时间',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '-',
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                  ),
                  Text(
                    '选取结束时间',
                    style: TextStyle(color: textColor, fontSize: 16),
                  ),
                ],
              )),*/
          Padding(
            padding: const EdgeInsets.all(30),
            child: MyButton(
              title: widget.id==null?'创建':'修改',
              onPressed: () {
                sub();
              },
              height: 40,
            ),
          ),
        ],
      ),
    );
  }

  void sub() async {
    String name = _nameCon.text;
    String man = _manCon.text;
    String jan = _janCon.text;
    String yuan = _yuanCon.text;
    if(now==1){
      if(name.length==0||man.length==0||jan.length==0){
        return tip(context, '请填完以上内容');
      }
    }else{
      if(name.length==0||yuan.length==0){
        return tip(context, '请填完以上内容');
      }
    }
    Map d = {};
    if(widget.id!=null){
      d = {
        'coupon_type': now==1?1:4,
        'coupon_name': name,
        'enough': man,
        'dedut': now == 1 ? jan : yuan,
        'id': widget.id,
      };
    }else{
      d = {
        'coupon_type': now==1?1:4,
        'name': name,
        'enough': man,
        'deductible': now == 1 ? jan : yuan,
        'most': 1,
      };
    }
    var rs = await post('CouponOperation', data: {
      'data': d,
      'type': widget.id==null?'add':'modify',
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //print(widget.id);

    if(widget.id!=null){
      getSj();
    }
  }

  void getSj()async{
    var rs = await get('couponDetails', data: {
      'coupon': widget.id,
    });
    if(rs!=null){
      if(rs['code']==1){
        //print(rs);
        _nameCon.text = rs['res']['coupon_name'];
        now = rs['res']['coupon_type']==4?2:1;
        if(rs['res']['coupon_type']==1){
          _manCon.text = rs['res']['enough'];
          _janCon.text = rs['res']['dedut'];
        }else{
          _yuanCon.text = rs['res']['dedut'];
        }
        setState(() {

        });
      }
    }
  }
}
