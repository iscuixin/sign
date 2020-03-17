import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/intel_util.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class WIFISet extends StatefulWidget {
  String wifiName;
  String wifiCode;
  int id;
  bool isSet;
  WIFISet({this.wifiName,this.wifiCode,this.id,this.isSet = false});
  @override
  _WIFISetState createState() => _WIFISetState();
}

class _WIFISetState extends State<WIFISet> {

  var data;

  Timer _timer;

  refresh(){
    const oneSec = const Duration(seconds: 3);
    _timer = Timer.periodic(oneSec, (timer){
      setState(() {});
    }); 
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((res){
      refresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        elevation: 1,
        title: Text('WIFI考勤'),   
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              if(data == null){
                ToastUtil.toast('请选择WIFI');
                return;
              }
              if(widget.isSet){
                HttpService.post(Api.wifiSave, context,params: {
                  'wifiName': data['wifiname'],
                  'wifiOnlyCode': data['ssid'],
                  'companyId':prefix0.userModel.loginData['sid']
                },showLoading: true).then((val){
                  var res = json.decode(val.toString());
                  if(res['data']){
                    ToastUtil.toast('保存成功');
                    Navigator.pop(context);
                  }else{
                    ToastUtil.toast('保存失败,请稍后再试');
                  }
                });
              }else{
                HttpService.patch(Api.wifiSet+widget.id.toString(), context,
                params: {
                  'wifiName': data['wifiname'],
                  'wifiOnlyCode': data['ssid']
                },showLoading: true
                ).then((val){
                  var res = json.decode(val.toString());
                  if(res['data']){
                    ToastUtil.toast('保存成功');
                    Navigator.pop(context);
                  }else{
                    ToastUtil.toast('保存失败,请稍后再试');
                  }
                });
              }
            }, 
            child: Text('保存',style: TextStyle(color: Colors.blue))
          )
        ],     
      ),
      body: Column(
        children: <Widget>[
          widget.isSet ? Container() : Container(
            padding: EdgeInsets.only(left:20,right:20,top:15,bottom:15),
            color: Colors.white,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(widget.wifiName),
                    Text('('+widget.wifiCode+')',style: TextStyle(color: Colors.black45,fontSize: 13)),
                  ]
                ),
                Text('当前WIFI设置',style: TextStyle(color: Colors.blue,fontSize: 13))
              ]
            )
          ),
          Container(
            padding: EdgeInsets.only(left:20,top:10,bottom: 10),
            width: double.maxFinite,
            child: Text('WIFI列表(只显示当前已连接WIFI)',style: TextStyle(color: Colors.black38,fontSize: 13)),
          ),
          IntelUtil.wifiList.length == 0 ? Expanded(
            child:Container(
              alignment: Alignment.center,
              child:Text('请连接WIFI再试')
            ),
          ):Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: IntelUtil.wifiList.map((res){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      data = res;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom:1),
                    padding: EdgeInsets.only(left:20,right:20,top:15,bottom:15),
                    color: Colors.white,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(res['wifiname']),
                            Text('('+res['ssid']+')',style: TextStyle(color: Colors.black45,fontSize: 13)),
                          ]
                        ),
                        Icon(
                          res == data ? Icons.check_circle: Icons.check_circle_outline,
                          color: res == data? Colors.blue : Colors.black26,
                          size: 16
                        )
                      ]
                    )
                  )
                );
              }).toList(),
            )
          )
        ],
      ),
    );
  }
}