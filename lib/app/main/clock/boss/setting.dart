import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/clock/boss/address_set.dart';
import 'package:myh_shop/app/main/clock/boss/distance.dart';
import 'package:myh_shop/app/main/clock/boss/time_set.dart';
import 'package:myh_shop/app/main/clock/boss/wifi_set.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/route_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List workDays = [];
  var signAddress ;
  var wifi;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getTime();
      getSignAddress();
      getWifiSet();
    });
  }

  getTime(){
    HttpService.get(Api.workDays+'1', context).then((res){
      setState(() {
        workDays = res['data'];
      });
    });
  }
  getSignAddress(){
    HttpService.get(Api.signAddress+'1', context).then((res){
      setState(() {
        signAddress = res['data'];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        elevation: 1,
        title: Text('考勤设置'),        
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height:10),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text('工作日设置',style: TextStyle(color: Colors.black38,fontSize: 13),),
          ),
          SizedBox(height:5),
          workDaySet(),
          SizedBox(height:5),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text('考勤范围设置',style: TextStyle(color: Colors.black38,fontSize: 13),),
          ),
          SizedBox(height:5),
          signAddress != null?signAddressInfo() : signAddressSet(),
          SizedBox(height:5),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text('WIFI打卡设置',style: TextStyle(color: Colors.black38,fontSize: 13),),
          ),
          SizedBox(height:5),
          wifi != null? wifiInfo():signWIFISet()
        ],
      ),
    );
  }

  Widget signAddressInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            routePush(Distance(double.parse((signAddress['maxDistance']/100).toString()).toInt(),signAddress['id'])).then((res){
              getSignAddress();
            });
          },
          child:Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20,right:20, top:15,bottom:15),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(signAddress['maxDistance'].toString()+'米'),
                    Text('(允许打卡范围)',style: TextStyle(color: Colors.black38,fontSize: 13),),
                  ],
                ),
                Icon(Icons.arrow_forward_ios,size:14,color:Colors.black54)
              ]
            ),
          )
        ),
        SizedBox(height:0.6),
        GestureDetector(
          onTap: (){
            routePush(AddressSet(address: signAddress['positionAddress'],
                                  latitude: signAddress['latitude'],
                                    longitude:signAddress['longitude'])).then((res){
                                      getSignAddress();
            });
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20,right:20, top:15,bottom:15),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Flexible(child: Text(signAddress['positionAddress'],maxLines: 2,overflow: TextOverflow.ellipsis)),
                Icon(Icons.arrow_forward_ios,size:14,color:Colors.black54)
              ]
            ),
          ),
        )
      ],
    );
  }
  Widget wifiInfo(){
    return GestureDetector(
      onTap: (){
        routePush(WIFISet(wifiCode: wifi['wifiOnlyCode'],wifiName: wifi['wifiName'])).then((res){
          getWifiSet();
        });
      },
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 20,right:20, top:15,bottom:15),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(wifi['wifiName']),
                    Text('(${wifi['wifiOnlyCode']})',style: TextStyle(color: Colors.black38,fontSize: 13),),
                  ],
                ),
                Icon(Icons.arrow_forward_ios,size:14,color:Colors.black54)
              ]
            ),
          )
        ]
      )
    );
  }

  Widget workDaySet(){
    return GestureDetector(
      onTap: (){
        routePush(TimeSet(list: workDays)).then((res){
          getTime();
        });
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left:20,right:20,top:15,bottom:15),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Container(
              child:Text('考勤日期',style: TextStyle(color: Colors.black38,fontSize: 13),)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(getTimeStr()),
                Icon(Icons.arrow_forward_ios,size:14,color:Colors.black54)
              ]
            )
          ]
        )
      )
    );
  }
  String getTimeStr(){
    String str = '星期';
    for(String s in workDays){
      switch(s){
        case '1':
          str = str + '一、';
          break;
        case '2':
          str = str + '二、';
          break;
        case '3':
          str = str + '三、';
          break;
        case '4':
          str = str + '四、';
          break;
        case '5':
          str = str + '五、';
          break;
        case '6':
          str = str + '六、';
          break;
        case '7':
          str = str + '日、';
          break;
      }
    }
    return str.substring(0,str.length-1);
  }

  Widget signAddressSet(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left:20,right:20,top:15),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(
            child:Text('考勤地点(满足地点或WIFI任意一项即可打卡)',style: TextStyle(color: Colors.black38,fontSize: 13),)
          ),
          Container(
            padding: EdgeInsets.only(top:15,bottom:15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  child:Text('添加考勤地点',style: TextStyle(color: Colors.blue),)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('(在此范围内即可打卡)',style: TextStyle(color: Colors.black38,fontSize: 13),),
                    Container(
                      padding: EdgeInsets.only(left:10,right:10,top:2,bottom:2),
                      decoration:BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child:Text('添加',style: TextStyle(color: Colors.white,fontSize: 12),)
                    )
                  ]
                )
              ]
            ),
          ),
        ]
      )
    );
  }

  Widget signWIFISet(){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left:20,right:20,top:15),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(
            padding: EdgeInsets.only(bottom:15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  child:Text('添加办公WIFI',style: TextStyle(color: Colors.blue),)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text('(连接指定WIFI即可打卡)',style: TextStyle(color: Colors.black38,fontSize: 13),),
                    Container(
                      padding: EdgeInsets.only(left:10,right:10,top:2,bottom:2),
                      decoration:BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child:Text('添加',style: TextStyle(color: Colors.white,fontSize: 12),)
                    )
                  ]
                )
              ]
            ),
          ),
        ]
      )
    );
  }

  final Widget line = Container(
    height: 0.5,
    color:prefix0.hintColor.withOpacity(0.4),
  );
}