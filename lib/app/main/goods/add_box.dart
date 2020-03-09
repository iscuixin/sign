import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';
import 'package:myh_shop/widget/MyInput2.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoApp, CupertinoPicker, showCupertinoModalPopup;
import 'package:myh_shop/widget/MyItem.dart';
import 'package:myh_shop/widget/MyRadio.dart';
import 'package:myh_shop/widget/MyRadio2.dart';
import 'package:flutter/cupertino.dart';

class AddBox extends StatefulWidget {
  final int type;
  final int id;

  AddBox({Key key, this.type = 1, this.id}) : super(key: key);

  @override
  _AddBoxState createState() => _AddBoxState();
}

class _AddBoxState extends State<AddBox> {
  TextEditingController _snCon = TextEditingController(text: '');
  TextEditingController _nameCon = TextEditingController(text: '');
  TextEditingController _priceCon = TextEditingController(text: '');
  TextEditingController _stockCon = TextEditingController(text: '');
  TextEditingController _timeCon = TextEditingController(text: '');
  TextEditingController _feeCon = TextEditingController(text: '');
  TextEditingController _jsCon = TextEditingController(text: '');
  TextEditingController _dayCon = TextEditingController(text: '');
  List classify = [];
  Map now;
  int nurse = 1;
  int free = 1;

  void del() async {
    var rs = await post('get_box_detail', data: {'type': 'del', 'id': widget.id});
    //print(rs);
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(widget.type == 1 ? '创建套盒' : '编辑套盒'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('删除', style: TextStyle(color: Colors.red),),
              onPressed: () async {
                var rs = await showAlert(context, '是否确定删除');
                if(rs){
                  del();
                }
              })
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
            child: MyButton(
              title: widget.type == 1 ? '创建' : '保存',
              onPressed: () {
                if (widget.type == 1) {
                  save();
                } else {
                  edit();
                }
              },
            ),
          ),
        ),
      ),
      body: ListView(
        //padding: EdgeInsets.all(10),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            color: bg2,
            child: Column(
              children: <Widget>[
                /*Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 60,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: hintColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.camera_alt,
                        color: hintColor,
                      ),
                    ),
                    Text(
                      '套盒图片：建议尺寸 32*240',
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.w500),
                    )
                  ],
                ),*/
                MyInput2(
                  controller: _snCon,
                  label: '套盒编号',
                  hintText: '请填写产品编号(非必填)',
                  alignment: Alignment.centerLeft,
                ),
                MyInput2(
                  controller: _nameCon,
                  label: '套盒名称',
                  hintText: '请填写产品名称(必填)',
                  alignment: Alignment.centerLeft,
                ),
                MyInput2(
                  controller: _priceCon,
                  keyboardType: TextInputType.numberWithOptions(),
                  label: '价$kg格',
                  hintText: '请填写销售价(必填)',
                  suffixText: '元',
                  alignment: Alignment.centerLeft,
                ),
                MyInput2(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _stockCon,
                  label: '库$kg存',
                  hintText: '请填写库存(必填)',
                  suffixText: '件',
                  alignment: Alignment.centerLeft,
                ),
                MyInput2(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _timeCon,
                  label: '次$kg数',
                  hintText: '请填写次数(必填)',
                  suffixText: '次',
                  alignment: Alignment.centerLeft,
                ),
                InkWell(
                  onTap: () {
                    if (classify.length > 0) {
                      showMyPicker(context);
                      if (now == null) {
                        setState(() {
                          now = classify[0];
                        });
                      }
                    }
                  },
                  child: MyItem(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      now == null ? '点击选择(必填)' : now['name'],
                      style: TextStyle(
                          fontSize: 16,
                          color: now == null ? textColor : Colors.black),
                    ),
                    label: '类$kg别',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            color: bg2,
            child: Column(
              children: <Widget>[
                MyInput2(
                  controller: _feeCon,
                  keyboardType: TextInputType.numberWithOptions(),
                  label: '手  工  费',
                  hintText: '请填写项目手工费(必填)',
                  suffixText: '元',
                  alignment: Alignment.centerLeft,
                ),
                MyItem(
                    label: '护理周期',
                    alignment: Alignment.centerLeft,
                    child: MyRadio2(
                      value: nurse,
                      onChanged: (v) {
                        nurse = v;
                      },
                      widget: Text('每周一次'),
                      widget2: Row(
                        children: <Widget>[
                          Text('每'),
                          Container(
                            child: TextField(
                              controller: _dayCon,
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5)),
                              textAlign: TextAlign.center,
                            ),
                            width: 30,
                            alignment: Alignment.center,
                          ),
                          Text('天1次')
                        ],
                      ),
                    )),
                MyItem(
                    label: '可  赠  送',
                    alignment: Alignment.centerLeft,
                    child: MyRadio(
                      value: free,
                      onChanged: (v) {
                        free = v;
                      },
                      text2: '不可赠送',
                      text: '可赠送',
                    )),
                MyItem(
                  label: '套盒介绍',
                  alignment: Alignment.centerLeft,
                  child: Offstage(),
                  showLine: false,
                ),
                TextField(
                  controller: _jsCon,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: '请填写套盒介绍',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hintColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hintColor))),
                ),
              ],
            ),
          )
        ],
      ),
    );
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
                        now = classify[v];
                      });
                    },
                    children: classify
                        .map((v) => Center(child: Text(v['name'])))
                        .toList()),
              ),
            ));
  }

  void save() async {
    String sn = _snCon.text;
    String name = _nameCon.text;
    String price = _priceCon.text;
    String stock = _stockCon.text;
    String time = _timeCon.text;
    String fee = _feeCon.text;
    String js = _jsCon.text;
    String day = _dayCon.text;
    if (name.length == 0 ||
        price.length == 0 ||
        stock.length == 0 ||
        time.length == 0 ||
        fee.length == 0 ||
        now == null) {
      return tip(context, '请填完以上内容');
    }
    if (nurse == 2 && day.length == 0) {
      return tip(context, '请输入护理周期');
    }
    var rs = await post('addbox', data: {
      'data': {
        'sn': sn,
        'box_name': name,
        'price': price,
        'stock': stock,
        'times': time,
        'fee': fee,
        'nurse': nurse,
        'days': day,
        'category': now['id'],
        'free': free,
        'introduce': js,
      }
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
    //print(rs);
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == 1) {
      getClassify();
    } else {
      getDetail();
    }
  }

  void getDetail() async {
    var rs = await get('get_box_detail', data: {'id': widget.id});
    if (rs != null) {
      if (rs['code'] == 1) {
        var d = rs['res']['detail'];
        _snCon.text = d['sn'].toString();
        _nameCon.text = d['box_name'].toString();
        _priceCon.text = d['price'].toString();
        _stockCon.text = d['stock'].toString();
        _timeCon.text = d['times'].toString();
        _feeCon.text = d['fee'].toString();
        free = d['free'];
        nurse = d['nurse'] == 7 ? 1 : 2;
        if (nurse == 2) {
          _dayCon.text = d['nurse'].toString();
        }
        classify = rs['res']['category'];
        for (var v in classify) {
          if (v['id'] == d['category']) {
            now = v;
          }
        }
        setState(() {});
      }
    }
    //print(rs);
  }

  void edit() async {
    String sn = _snCon.text;
    String name = _nameCon.text;
    String price = _priceCon.text;
    String stock = _stockCon.text;
    String time = _timeCon.text;
    String fee = _feeCon.text;
    String js = _jsCon.text;
    String day = _dayCon.text;
    if (name.length == 0 ||
        price.length == 0 ||
        stock.length == 0 ||
        time.length == 0 ||
        fee.length == 0 ||
        now == null) {
      return tip(context, '请填完以上内容');
    }
    if (nurse == 2 && day.length == 0) {
      return tip(context, '请输入护理周期');
    }
    var rs = await post('get_box_detail', data: {
      'data': {
        'sn': sn,
        'box_name': name,
        'price': price,
        'stock': stock,
        'times': time,
        'fee': fee,
        'cycle': nurse,
        'nurse': day,
        'category': now['id'],
        'free': free,
        'introduce': js,
        'id': widget.id,
      },
      'type': "modify"
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        ok(context, rs['Msg']);
      }
    }
    //print(rs);
  }

  void getClassify() async {
    var rs = await get('get_box_cate', data: {'type': 2});
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          classify = rs['res'];
        });
      }
    }
    //print(rs);
  }
}
