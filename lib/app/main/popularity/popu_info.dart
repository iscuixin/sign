import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/popularity/popu_member.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyInput.dart';

class PopuInfo extends StatefulWidget {
  final Map data;

  const PopuInfo(this.data, {Key key}) : super(key: key);

  @override
  _PopuInfoState createState() => _PopuInfoState();
}

class _PopuInfoState extends State<PopuInfo> {
  List list;
  String input = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_popularity_detail', data: {
      'px': widget.data['px'],
      'cate_id': widget.data['cate_id'],
      'name': widget.data['name'],
      'type': 'detail',
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['list'];
        });
      }
    }
    //print(rs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: MyInput(
          prefixIcon: Icon(
            Icons.search,
            color: textColor,
          ),
          hintText: '请输入关键字查找',
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: list!=null?ListView.builder(
        itemBuilder: (_, i) => _item(i),
        itemCount: list.length,
      ):Center(child: loading(),),
    );
  }

  Widget _item(int i) {
    String name = '';
    if(widget.data['px']==1){
      name = list[i]['goods_name'];
    }else if(widget.data['px']==2){
      name = list[i]['box_name'];
    }else if(widget.data['px']==3){
      name = list[i]['pro_name'];
    }
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  constraints: BoxConstraints(maxWidth: 90),
                  decoration: BoxDecoration(
                      color: c3, borderRadius: BorderRadius.circular(15)),
                  padding:
                  EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
                ),
                RichText(
                    text: TextSpan(
                        text: '已购人数',
                        style: TextStyle(color: textColor, fontSize: 13),
                        children: [
                          TextSpan(
                              text: ' ${list[i]['buy_count']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ])),
                RichText(
                    text: TextSpan(
                        text: '未购人数',
                        style: TextStyle(color: textColor, fontSize: 13),
                        children: [
                          TextSpan(
                              text: ' ${list[i]['not_count']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ])),
                Icon(Icons.chevron_right)
              ],
            ),
          ),
          Divider(
            height: 5,
          ),
        ],
      ),
      onTap: () {
        Map data = {'id': list[i]['id'], 'px': widget.data['px'], 'type': 'member'};
        jump2(context, PopuMember(data));
      },
    );
  }
}
