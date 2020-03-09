import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myh_shop/app/main/clock/employee/summary.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/model/user.dart';
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/intel_util.dart';
import 'package:myh_shop/util/route_util.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:amap_location/amap_location.dart';
import 'package:permission_handler/permission_handler.dart';
class Clock extends StatefulWidget {
  final bool isBoss;
  Clock({this.isBoss = false});
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String address;
  double lng,lat;
  double lngSet = 0;
  double latSet = 0;
  double distanceSet = 0;

  String date = DateTime.now().toString().substring(0,11);
  DateTime dateNow = DateTime.now();
  Timer _timer;
  Timer _timeloader;
  int distanceStatus = 1;
  var info;
  var daySignInfo;
  DateTime datePicker = DateTime.now();
  int timeSectionStatus = 0;
  var wifi;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getInfo(dateNow);
      getLocation();
      getSignAddressInfo();
      getSignInfo();
      onTimeLoad();
      getWifiSet();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
    _timeloader?.cancel();
    _timeloader = null;
    AMapLocationClient.shutdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Text('考勤打卡'),
        actions: <Widget>[
          !widget.isBoss? GestureDetector(
            onTap: (){
              routePush(ClockSummary());
            },
            child: Container(
              height: 50,
              width: 70,
              child: Center(
                child: Text('统计',style: TextStyle(color: Colors.blue,fontSize: 16)),
              ),
            ),
          ):Container()
        ],
        bottom: _bottom(),
      ),
      body: ScopedModel<UserModel>(
        model: userModel,
        child: ScopedModelDescendant<UserModel>(
          builder: (_,__,v){
            return daySignInfo == null || info == null ?ListView() : ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(height: 10,color: bg,),
                layoutWidget(titleBlue('上班打卡 ${daySignInfo['data']==null? info['upWork'].toString().substring(11,16):daySignInfo['data']['upTime'].toString().substring(11,16)}'), new Container(),180,15),
                daySignInfo['data']!= null && daySignInfo['data']['morningStatus'] != 0? _morningSignInfo() :  _morningSign(),
                layoutWidget(titleBlue('下班打卡 ${daySignInfo['data']==null?info['downWork'].toString().substring(11,16) : daySignInfo['data']['downTime'].toString().substring(11,16)}'), new Container(),150,0),
                daySignInfo['data'] == null ? Container():  daySignInfo['data']['afternoonSignTime'] != null ?  _afternoonSignInfo() :  _afternoonSign(),
              ],
            );
          },
        )
      ),
    );
  }
  /*--------------------------------------*/

  Widget _morningSignInfo(){
    var data = daySignInfo['data'];
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Container(
          height: 100,
          padding: EdgeInsets.only(left: 8),
          margin: EdgeInsets.only(left:41,right: 41),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(height:5),
              Row(
                children: <Widget>[
                  Text(
                    '打卡时间${data['morningSignTime'].toString().substring(11,16)}'
                    ,style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  data['morningStatus'] == 1 || data['morningStatus'] == 5? Container(
                    margin: EdgeInsets.only(left:10),
                    padding: EdgeInsets.only(left:5,right:5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:Colors.orange,
                        width:1
                      ),
                      borderRadius: BorderRadius.circular(3)
                    ),
                    child:Text('迟到',style: TextStyle(color: Colors.orange,fontSize: 12),)
                  ):Container(),
                  data['morningStatus'] == 3 || data['morningStatus'] == 5 ? Container(
                    margin: EdgeInsets.only(left:10),
                    padding: EdgeInsets.only(left:5,right:5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:Colors.green,
                        width:1
                      ),
                      borderRadius: BorderRadius.circular(3)
                    ),
                    child:Text('外勤',style: TextStyle(color: Colors.green,fontSize: 12),)
                  ):Container(),
                ],
              ),
              SizedBox(height:5),
              Row(
                crossAxisAlignment: data['morningSignWifiName']!= null? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(data['morningSignWifiName'] != null?Icons.wifi :Icons.location_on,color: Colors.green,size: 18,),
                  Flexible(child: Text(data['morningSignWifiName']!= null? data['morningSignWifiName'] :data['morningSignAddress'],maxLines: 3,style: TextStyle(color: Colors.black45,fontSize: 12),overflow: TextOverflow.ellipsis))
                ],
              ),
            ]
          ),
        ),
        Positioned(
          left: 41,
          child: Container(height: 200,decoration: BoxDecoration(border: Border(left: BorderSide(width: 1,color: prefix0.bg)))),
        )
      ],
    );
  }

  Widget _afternoonSignInfo(){
    var data = daySignInfo['data'];
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Container(
          height: 100,
          padding: EdgeInsets.only(left: 8),
          margin: EdgeInsets.only(left:41,right: 41),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(height:5),
              Row(
                children: <Widget>[
                  Text(
                    '打卡时间${data['afternoonSignTime'].toString().substring(11,16)}'
                    ,style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  data['afternoonStatus'] == 4 || data['afternoonStatus'] == 6? Container(
                    margin: EdgeInsets.only(left:10),
                    padding: EdgeInsets.only(left:5,right:5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:Colors.orange,
                        width:1
                      ),
                      borderRadius: BorderRadius.circular(3)
                    ),
                    child:Text('早退',style: TextStyle(color: Colors.orange,fontSize: 12),)
                  ):Container(),
                  data['afternoonStatus'] == 3 || data['afternoonStatus'] == 6? Container(
                    margin: EdgeInsets.only(left:10),
                    padding: EdgeInsets.only(left:5,right:5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:Colors.green,
                        width:1
                      ),
                      borderRadius: BorderRadius.circular(3)
                    ),
                    child:Text('外勤',style: TextStyle(color: Colors.green,fontSize: 12),)
                  ):Container(),
                ],
              ),
              SizedBox(height:5),
              Row(
                crossAxisAlignment: data['eveningSignWifiName'] != null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(data['eveningSignWifiName']!= null?Icons.wifi : Icons.location_on,color: Colors.green,size: 18,),
                  Flexible(child: Text(data['eveningSignWifiName']!= null?data['eveningSignWifiName'] : data['afternoonSignAddress']??'',maxLines: 3,style: TextStyle(color: Colors.black45,fontSize: 12),overflow: TextOverflow.ellipsis))
                ],
              ),
            ]
          ),
        ),
        Positioned(
          left: 41,
          child: Container(height: 200,decoration: BoxDecoration(border: Border(left: BorderSide(width: 1,color: prefix0.bg)))),
        )
      ],
    );
  }

  //晚打卡
  Widget _afternoonSign(){
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.center,
          children:[
            Container(
              height: 200,
              width: 360,
              color: Colors.white,
              child: Center(
                child:
                    Container(
                      height: 120,
                      width: 120,
                      child: Image.asset((distanceStatus == 0 || wifiStatus == 0) && eveningStatus == 0 && timeSectionStatus == 0 ? 'img/yuan.png'  : timeSectionStatus == 1 ? 'img/yuan_grey.png' : 'img/WechatIMG45.png'),
                    ),
              ),
            ),
            Positioned(
              child: GestureDetector(
                onTap: (){
                  if(datePicker.year == DateTime.now().year && datePicker.month == DateTime.now().month && datePicker.day == DateTime.now().day){
                    sign(1, distanceStatus == 1 && wifiStatus != 0  ? true : false);
                  }else{
                    ToastUtil.toast('当前不在考勤时间范围内');
                  }
                },
                child: Container(
                  height: 120,
                  width: 120,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(timeSectionStatus == 1 ? '无法打卡':(distanceStatus == 0 || wifiStatus == 0) ?'下班打卡' :'外勤打卡',style: TextStyle(color: Colors.white,fontSize: 18)),
                      Text(dateNow.toString().substring(11,19),style: TextStyle(color: Colors.white,fontSize: 16))
                    ],
                  ),
                ),
              )
            ),
          ]
        ),
        timeSectionStatus == 1 ? Container():Positioned(
          top:160,
          child: Row(
            children: <Widget>[
              (distanceStatus == 0 || wifiStatus == 0)?Icon(Icons.check_circle,color: Colors.green,size: 18,):Icon(IconData(0xe836,fontFamily:'iconfont'),size: 18,color: Colors.orange,),
              Text((distanceStatus == 0 || wifiStatus == 0)?'已经进入打卡考勤范围':'当前不在考勤范围' ,style: TextStyle(color: prefix0.textColor,fontSize: 13)),
              SizedBox(width: 5),
              GestureDetector(
                onTap: ()=> getDistanceStatus(true),
                child: Text('重新定位',style: TextStyle(color: Colors.blue,fontSize: 13)),
              )
            ],
          ),
        ),
        Positioned(
          left: 41,
          child: Container(height: 200,decoration: BoxDecoration(border: Border(left: BorderSide(width: 1,color: prefix0.bg)))),
        )
      ],
    );
  }


  //早打卡
  Widget _morningSign(){
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.center,
          children:[
            Container(
              height: 200,
              width: 360,
              color: Colors.white,
              child: Center(
                child:
                    Container(
                      height: 120,
                      width: 120,
                      child: Image.asset((distanceStatus == 0 || wifiStatus == 0) && morningStatus != 1 && timeSectionStatus == 0 ? 'img/yuan.png' : timeSectionStatus == 1 ? 'img/yuan_grey.png' : 'img/WechatIMG45.png'),
                    ),
              ),
            ),
            Positioned(
              child: GestureDetector(
                onTap: (){
                  if(datePicker.year == DateTime.now().year && datePicker.month == DateTime.now().month && datePicker.day == DateTime.now().day){
                    sign(0, distanceStatus == 1 && wifiStatus != 0  ? true : false);
                  }else{
                    ToastUtil.toast('当前不在考勤时间范围内');
                  }
                },
                child: Container(
                  height: 120,
                  width: 120,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(timeSectionStatus == 1 ? '无法打卡':(distanceStatus == 0 || wifiStatus == 0) ?'上班打卡': '外勤打卡',style: TextStyle(color: Colors.white,fontSize: 18)),
                      Text(dateNow.toString().substring(11,19),style: TextStyle(color: Colors.white,fontSize: 16))
                    ],
                  ),
                ),
              )
            ),
          ]
        ),
        timeSectionStatus == 1 ? Container():Positioned(
          top:160,
          child: Row(
            children: <Widget>[
              (distanceStatus == 0 || wifiStatus == 0)?Icon(Icons.check_circle,color: Colors.green,size: 18,):Icon(IconData(0xe836,fontFamily:'iconfont'),size: 18,color: Colors.orange,),
              Text((distanceStatus == 0 || wifiStatus == 0)?'已经进入打卡考勤范围':'当前不在考勤范围' ,style: TextStyle(color: prefix0.textColor,fontSize: 13)),
              SizedBox(width: 5),
              GestureDetector(
                onTap: ()=> getDistanceStatus(true),
                child: Text('重新定位',style: TextStyle(color: Colors.blue,fontSize: 13)),
              )
            ],
          ),
        ),
        Positioned(
          left: 41,
          child: Container(height: 200,decoration: BoxDecoration(border: Border(left: BorderSide(width: 1,color: prefix0.bg)))),
        )
      ],
    );
  }

  Widget _bottom(){
    return new PreferredSize(
        child: Container(
          height: 60,
          padding: EdgeInsets.only(left:20,right: 20,bottom: 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(userModel.loginData['head_img'] == null || userModel.loginData['head_img'] == '' ? 'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg':userModel.loginData['head_img']),
                    ),
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(userModel.loginData['name'],style: TextStyle(fontSize: 18)),
                      SizedBox(height: 2),
                      Text(widget.isBoss?prefix0.userModel.loginData['manager_name']:userModel.loginData['role_name'],style: TextStyle(fontSize: 12,color: prefix0.textColor))
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: (){
                  showDatePicker(
                      context: context,
                      initialDate: datePicker,
                      firstDate: new DateTime.now().subtract(new Duration(days: 60)), // 减 30 天
                      lastDate: new DateTime.now(),
                      locale: Locale('zh'),
                      builder: (context,child){
                        return Theme(
                          data: ThemeData(primaryTextTheme: TextTheme(subhead: TextStyle(fontSize: 0))),
                          child: child,
                        );
                      }
                  ).then((res){
                    if(res != null){
                      setState(() {
                        date = res.toString().substring(0,11);
                        datePicker = res;
                        if(datePicker.year == DateTime.now().year && datePicker.month == DateTime.now().month && datePicker.day == DateTime.now().day){
                          timeSectionStatus = 0;
                        }else{
                          timeSectionStatus = 1;
                        }
                      });
                      getSignInfo(date:res.toString().substring(0,19));
                      getInfo(res);
                    }
                  });
                },
                child: Row(
                  children: <Widget>[
                    Text(date,style: TextStyle(fontSize: 14,color: prefix0.textColor)),
                    Icon(Icons.keyboard_arrow_down,size: 14,color: prefix0.textColor,)
                  ],
                ),
              )
            ],
          ),
        ),
      preferredSize: Size.fromHeight(60),
    );
  }

  Widget titleBlue(String title){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 3,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(1.5)
          ),
        ),
        SizedBox(width: 5),
        Container(
          height: 18,
          child: Text(title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: prefix0.textColor),)
        ),
        
      ],
    );
  }

  //布局组件 1:3.6
  Widget layoutWidget(Widget left,Widget right,double width,double top){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: top,bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40),
            alignment: Alignment.center,
            width: width,
            child: left,
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: right,
          )
        ],
      ),
    );
  }

  /*--------------------------------------------*/

  void getInfo(DateTime time){
    HttpService.get(Api.getEmployeeInfo+'1', context,params: {'date':time.toString().substring(0,19)}).then((res){
      setState(() {
        info = res['data'];
      });
    });
  }

  void sign(int signSection,bool isOut){
    if(address == null){
      ToastUtil.toast('获取定位中...');
      return;
    }
    HttpService.post(Api.sign, context,params: {
      'employeeId':1,
      'longitude': lng,
      'latitude': lat,
      'signAddress': address,
      'signSection':signSection,
      'outWorkFlag':isOut,
      'wifiName':IntelUtil.wifiInfo.length != 0 && wifiStatus == 0 ?IntelUtil.wifiInfo['wifiname']:null
    },
      showLoading: true
    ).then((res){
      getSignInfo();
    });
  }

  void getSignAddressInfo(){
     HttpService.get(Api.getSignAddressInfo+"1", context,showLoading: false).then((res){
       setState(() {
         latSet = res['data']['latitude'];
         lngSet = res['data']['longitude'];
         distanceSet = double.parse(res['data']['maxDistance'].toString());
       });
       getDistance();
     });
  }

  void getSignInfo({String date}){
    HttpService.get(Api.getDaySignInfo+"1", context,params: {'date': date ?? DateTime.now().toString().substring(0,19)}).then((res){
      print(res.toString());
      setState(() {
        daySignInfo = res;
      });
    });
  }

  int morningStatus = 1; 

  int eveningStatus = 1;

  int wifiStatus = 1;

  void getDistance(){
    const oneSec = const Duration(seconds: 5);
    _timer = Timer.periodic(oneSec, (timer)=>getDistanceStatus(false)); 
  }
  void onTimeLoad(){
    const oneSec = const Duration(seconds: 1);
    _timeloader = Timer.periodic(oneSec, (timer){
      if(daySignInfo != null){
        if(daySignInfo['data'] == null){
          DateTime morning = new DateTime(dateNow.year,dateNow.month,dateNow.day,DateTime.parse(info['upWork']).hour,DateTime.parse(info['upWork']).minute,59);
          DateTime evening = new DateTime(dateNow.year,dateNow.month,dateNow.day,DateTime.parse(info['downWork']).hour,DateTime.parse(info['downWork']).minute,00);
          if(dateNow.isAfter(morning)){
            if(morningStatus != 1){
              setState(() {
                morningStatus = 1;
              });
            }
          }else{
            if(morningStatus != 0){
              setState(() {
                morningStatus = 0;
              });
            }
          }
          if(dateNow.isBefore(evening)){
            if(eveningStatus != 0){
              setState(() {
                eveningStatus = 0;
              });
            }
          }else{
            if(eveningStatus != 1){
              setState(() {
                eveningStatus = 1;
              });
            }
          }
        }else{
          DateTime morning = new DateTime(dateNow.year,dateNow.month,dateNow.day,DateTime.parse(daySignInfo['data']['upTime']).hour,DateTime.parse(daySignInfo['data']['upTime']).minute,59);
          DateTime evening = new DateTime(dateNow.year,dateNow.month,dateNow.day,DateTime.parse(daySignInfo['data']['downTime']).hour,DateTime.parse(daySignInfo['data']['downTime']).minute,00);
          if(dateNow.isBefore(morning)){
            if(morningStatus != 1){
              setState(() {
                morningStatus = 1;
              });
            }
          }else{
            if(morningStatus != 0){
              setState(() {
                morningStatus = 0;
              });
            }
          }
          if(dateNow.isAfter(evening)){
            if(eveningStatus != 0){
              setState(() {
                eveningStatus = 0;
              });
            }
          }else{
            if(eveningStatus != 1){
              setState(() {
                eveningStatus = 1;
              });
            }
          }
        }
      }
      if(IntelUtil.wifiInfo.length != 0 && wifi != null){
        if(wifi['wifiOnlyCode'] == IntelUtil.wifiInfo['ssid']){
          if(wifiStatus != 0){
            setState(() {
              wifiStatus = 0;
            });
          }
        }else{
          if(wifiStatus != 1){
            setState(() {
              wifiStatus = 1;
            });
          }
        }
      }else{
        if(wifiStatus != 1){
          setState(() {
            wifiStatus = 1;
          });
        }
      }
      setState(() {
        this.dateNow = DateTime.now();
      });
    }); 
  }

  void getDistanceStatus(bool showLocading){
    HttpService.get(Api.distanceJudge, context,params: {
      'longitude':lng,
      'latitude' :lat,
      'longitudeSet':lngSet,
      'latitudeSet':latSet,
      'distanceSet':distanceSet},showLoading: showLocading).then((res){
      setState(() {
        distanceStatus = res['data'];
      });
    });
  }

  getWifiSet(){
    HttpService.get(Api.wifiSet+'1', context).then((res){
      setState(() {
        wifi = res['data'];
      });
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
          if(loc != null){
            setState(() {
              address = loc.formattedAddress;
              lng = loc.longitude;
              lat = loc.latitude;
            });
          }
        });
        AMapLocationClient.startLocation();
      });
      
    }
  }
}
