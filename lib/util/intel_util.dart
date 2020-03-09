import 'dart:async';

import 'package:connectivity/connectivity.dart';

class IntelUtil{
  static List wifiList = [];
  static var wifiInfo = {};
  static StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static void getWifi(){
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(result.toString() == 'ConnectivityResult.wifi'){
        var ssid = await Connectivity().getWifiBSSID();
        var wifiName  = await Connectivity().getWifiName();
        if(ssid != null && wifiName != null){
          wifiInfo = {
            'ssid':ssid.toString(),
            'wifiname':wifiName.toString()
          };
          bool has = false;
          for(var v in wifiList){
            if(v['ssid'] == ssid){
              has = true;
            }
          }
          if(!has){
            wifiList.add({
              'ssid':ssid.toString(),
              'wifiname':wifiName.toString()
            });
          }
        }
      }else{
        wifiInfo = {};
      }
    });
  }

  static void cancel(){
    _connectivitySubscription.cancel();
  }

}