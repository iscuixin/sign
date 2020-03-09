import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class Distance extends StatefulWidget {
  int distance;
  int id;
  Distance(this.distance,this.id);
  @override
  _DistanceState createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  int index = 0;

  List list = [
    100,200,300,400,500,600,700,800,900,1000
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((res){
      setState(() {
        index = widget.distance - 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        elevation: 1,
        title: Text('考勤范围'), 
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              HttpService.patch(Api.signAddress+'1', context,
              params: {
                'maxDistance':(index + 1) * 100
              },showLoading: true
              ).then((val){
                var res = json.decode(val.toString());
                if(res['data']){
                  ToastUtil.toast('保存成功');
                }else{
                  ToastUtil.toast('保存失败,请稍后再试');
                }
              });
            }, 
            child: Text('保存',style: TextStyle(color: Colors.blue))
          )
        ],       
      ),
      body: Column(
        children:list.map((res){
          return GestureDetector(
            onTap: (){
              setState(() {
                index = int.parse(res.toString().replaceAll('00', '')) - 1;
              });
            },
            child: Container(
              margin: EdgeInsets.only(bottom:1),
              color: Colors.white,
              padding: EdgeInsets.only(left:20,right:20,top:15,bottom:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(res.toString()+'米'),
                  Icon(
                    double.parse((res/100).toString()).toInt() - 1 == index? Icons.check_circle: Icons.check_circle_outline,
                    color: double.parse((res/100).toString()).toInt() - 1 == index? Colors.blue : Colors.black26,
                    size: 16
                  )
                ],
              ),
            ),
          );
        }).toList()
      ),
    );
  }
}