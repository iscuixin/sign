import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyButton.dart';

class JurEdit extends StatefulWidget {
  final int id;

  const JurEdit(this.id, {Key key}) : super(key: key);

  @override
  _JurEditState createState() => _JurEditState();
}

class _JurEditState extends State<JurEdit> {
  List list = [1, 1, 1, 1, 1, 1];
  String roleName = '';
  List title;
  List info;
  List jg = [];

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_access', data: {'role': widget.id});
    if (rs != null) {
      title = rs['res']['acc_category'];
      info = rs['res']['acc_list'];
      jg = rs['res']['return_acc'];
      for (var v in title) {
        v['arr'] = [];
//        //print(v);
        for (var v2 in info) {
          if (v2['category_id'] == v['id']) {
            if (jg.indexOf(v2['id']) >= 0) {
              v2['zt'] = true;
            } else {
              v2['zt'] = false;
            }
            v['arr'].add(v2);
          }
        }
      }
      setState(() {
        roleName = rs['res']['role_name'];
      });
    }
    ////print(rs);
  }

  void setJur() async {
    List j = [];
    for (var v in title) {
      for (var v2 in v['arr']) {
        if (v2['zt']) {
          j.add(v2['id']);
        }
      }
    }
    var rs = await post('set_jur', data: {'data': toString({'accId': j, 'id': widget.id})});
    if(rs!=null){
      if(rs['code']==1){
        ok(context, rs['Msg']);
      }else{
        tip(context, rs['error']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('权限设置'),
        bottom: PreferredSize(
            child: Container(
              color: tableBg,
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              height: 50,
              child: Text('当前界面为设置"$roleName"权限'),
            ),
            preferredSize: Size(getRange(context), 50)),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
          height: 50,
          child: MyButton(
            onPressed: () {
              setJur();
            },
            title: '设置权限',
          ),
        ),
      ),
      body: title != null
          ? ListView.builder(
              itemBuilder: (_, i) => _item2(i),
              itemCount: title.length,
            )
          : Center(
              child: loading(),
            ),
    );
  }

  Widget _item2(int i) {
    List<Widget> ws = [];
    int k = 0;
    for (var v in title[i]['arr']) {
      ws.add(_item(i, k));
      k++;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                color: bg2,
                height: 50,
                child: Text(
                  '${title[i]['category_name']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerLeft,
              ),
              Divider(
                height: 0,
              )
            ],
          ),
          Container(
            color: bg2,
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            width: getRange(context),
            child: Wrap(
              spacing: 10,
              children: ws,
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(int i, k) {
    return GestureDetector(
      onTap: () {
        setState(() {
          title[i]['arr'][k]['zt'] = !title[i]['arr'][k]['zt'];
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            getImg(title[i]['arr'][k]['zt'] ? 'radio_yes' : 'radio_no'),
            height: 20,
            color: c1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${title[i]['arr'][k]['title']}',
                style: TextStyle(color: textColor, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
