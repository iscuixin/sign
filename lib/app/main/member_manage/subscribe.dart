import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class Subscribe extends StatefulWidget {
  @override
  _SubscribeState createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  List list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('预约列表'),
      ),
      body: list != null
          ? list.length == 0
              ? Center(child: Text('还没有预约'),)
              : ListView.builder(
                  itemBuilder: (_, i) => Container(),
                  itemCount: list.length,
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

  void getSj() async {
    var rs = await get('BespeakDetail');
    if(rs!=null){
      if(rs['code']==1){
        setState(() {
          list = rs['res'];
        });
      }
    }
  }
}
