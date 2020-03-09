import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';

class EditCard extends StatefulWidget {
  final int cardId;
  final int id;

  EditCard(this.id, this.cardId);

  @override
  _EditCardState createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  Map detail;
  TextEditingController _amountCon = TextEditingController(text: '');
  TextEditingController _zkCon = TextEditingController(text: '');
  TextEditingController _cpCon = TextEditingController(text: '');
  TextEditingController _boxCon = TextEditingController(text: '');
  TextEditingController _itemsCon = TextEditingController(text: '');
  TextEditingController _planCon = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('会员卡编辑'),
      ),
      body: detail != null
          ? ListView(
              children: <Widget>[
                MyInput2(
                  label: '卡项名称',
                  hintText: detail['name'],
                  enabled: false,
                  hintStyle: TextStyle(color: Colors.black),
                ),
                MyInput2(
                  keyboardType: TextInputType.numberWithOptions(),
                  label: '卡项余额',
                  controller: _amountCon,
                  suffixText: '元',
                ),
                detail['card_type'] == 3
                    ? MyInput2(
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: _zkCon,
                        label: '折扣率',
                        suffixText: '%',
                      )
                    : Offstage(),
                detail['card_type'] == 2
                    ? Column(
                        children: <Widget>[
                          MyInput2(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _cpCon,
                            label: '产品折扣',
                            suffixText: '%',
                          ),
                          MyInput2(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _boxCon,
                            label: '套盒折扣',
                            suffixText: '%',
                          ),
                          MyInput2(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _itemsCon,
                            label: '项目折扣',
                            suffixText: '%',
                          ),
                          MyInput2(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: _planCon,
                            label: '方案折扣',
                            suffixText: '%',
                          ),
                        ],
                      )
                    : Offstage(),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: MyButton(
                    onPressed: () {
                      sub();
                    },
                    title: '保存',
                  ),
                ),
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

  void sub() async {
    String amount = _amountCon.text;
    String zk = _zkCon.text;
    String cp = _cpCon.text;
    String box = _boxCon.text;
    String items = _itemsCon.text;
    String plan = _planCon.text;
    if (detail['card_type'] == 3) {
      if (amount.length == 0 || zk.length == 0) {
        return tip(context, '请填完以上内容');
      } else {
        detail['amount'] = amount;
        detail['discount'] = zk;
      }
    } else if (detail['card_type'] == 2) {
      if (amount.length == 0 ||
          cp.length == 0 ||
          box.length == 0 ||
          items.length == 0 ||
          plan.length == 0) {
        return tip(context, '请填完以上内容');
      } else {
        detail['amount'] = amount;
        detail['product'] = cp;
        detail['items'] = items;
        detail['suitbox'] = box;
        detail['gift'] = plan;
      }
    }
    var rs = await post('modify_member_card_details', data: {
      'data': detail,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  void getSj() async {
    var rs = await get('modify_member_card_details', data: {
      'id': widget.cardId,
      'mid': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          detail = rs['res'];
          detail['id'] = widget.cardId;
          detail['mid'] = widget.id;
          if (detail['card_type'] == 2) {
            _cpCon.text =
                double.parse(detail['product'].toString()).toStringAsFixed(2);
            _boxCon.text =
                double.parse(detail['suitbox'].toString()).toStringAsFixed(2);
            _itemsCon.text =
                double.parse(detail['items'].toString()).toStringAsFixed(2);
            _planCon.text =
                double.parse(detail['gift'].toString()).toStringAsFixed(2);
          } else if (detail['card_type'] == 3) {
            _zkCon.text =
                double.parse(detail['discount'].toString()).toStringAsFixed(2);
          }
          _amountCon.text =
              double.parse(detail['amount'].toString()).toStringAsFixed(2);
        });
      }
    }
  }
}
