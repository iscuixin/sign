import 'dart:convert';

import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:permission_handler/permission_handler.dart';

class AddressSet extends StatefulWidget {
  String address;
  double latitude;
  double longitude;
  int id;
  bool isSet;
  AddressSet({this.address, this.latitude, this.longitude,this.id,this.isSet = false});
  @override
  _AddressSetState createState() => _AddressSetState();
}

class _AddressSetState extends State<AddressSet> {


  List list = [];
  var select;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((res){
      getLocation();
    });
  }

  void getLocation() async{
    PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.locationAlways);
    if (permission != PermissionStatus.granted) {
      PermissionHandler().requestPermissions([PermissionGroup.locationAlways]).then((res) async {
        getLocation();
      });
    }else{
      AMapLocationClient.setApiKey('51c0317ad36636b5044ceac078635822').then((res) async {
        await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));
        AMapLocationClient.onLocationUpate.listen((AMapLocation loc) {
          if (!mounted) return;
          if(loc.formattedAddress != null && loc.formattedAddress.length != 0){
            if(list.length < 5){
              bool has = false;
              for(var v in list){
                if(v['address'] == loc.formattedAddress){
                  has = true;
                }
              }
              if(!has){
                setState(() {
                  list .add({
                    'address':loc.formattedAddress,
                    'lng' : loc.longitude,
                    'lat' : loc.latitude
                  });
                });
              }
            }
          }
        });
        AMapLocationClient.startLocation();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    AMapLocationClient.shutdown();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        elevation: 1,
        title: Text('考勤地点'),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              if(widget.isSet){
                if(select == null){
                  ToastUtil.toast('请选择打卡地点');
                  return;
                }
                HttpService.post(Api.saveAddress, context,params: {
                  'positionAddress':select['address'],
                  'longitude':select['lng'],
                  'latitude':select['lat'],
                  'companyId':prefix0.userModel.loginData['sid']
                },showLoading: true).then((res){
                  var rs = json.decode(res.toString());
                  if(rs['data']){
                    ToastUtil.toast('保存成功');
                    Navigator.pop(context);
                  }else{
                    ToastUtil.toast('保存失败,请稍后再试');
                  }
                });
              }else{
                HttpService.patch(Api.signAddress+widget.id.toString(), context,
                  params: {
                    'positionAddress':select['address'],
                    'longitude':select['lng'],
                    'latitude':select['lat']
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
        children:[
          Container(
            margin: EdgeInsets.only(bottom:1),
            padding: EdgeInsets.only(top:15,bottom:15,right:20,left:widget.isSet?10:20),
            color: widget.isSet? Colors.transparent : Colors.white,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child:Text(widget.isSet?'请选择打卡地点':widget.address,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14))
                ),
                widget.isSet?Text(''):Text('当前打卡地点',style: TextStyle(fontSize: 13,color: Colors.blue),)
              ],
            )
          ),
          list.length != 0 ? Column(
            children: list.map((res){
              return GestureDetector(
                onTap: (){
                  setState(() {
                    select = res;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom:1),
                  padding: EdgeInsets.only(top:15,bottom:15,right:20,left:20),
                  color: Colors.white,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child:Text(res['address'],maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14))
                      ),
                      Icon(
                        select == res ? Icons.check_circle:Icons.check_circle_outline,
                        color:select == res ? Colors.blue:Colors.black26,
                        size: 18,
                      )
                    ],
                  )
                )
              );
            }).toList()
          ):Container()
        ]
      ),
    );
  }
}