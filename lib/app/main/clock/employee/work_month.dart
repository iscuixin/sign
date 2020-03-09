import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:date_utils/date_utils.dart' as date;

class WorkMonth extends StatefulWidget {
  bool isBoss;
  int id;
  WorkMonth({this.isBoss = false,this.id});
  @override
  _WorkMonthState createState() => _WorkMonthState();
}

class _WorkMonthState extends State<WorkMonth> {
  int status = 1;
  String dt = DateTime.now().year.toString()+'-'+(DateTime.now().month.toString().length==1?'0'+DateTime.now().month.toString():DateTime.now().month.toString())+'-'+(DateTime.now().day.toString().length==1?'0'+DateTime.now().day.toString():DateTime.now().day.toString())+' 00:00:00.000';
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  var data;
  var infos;
  Map dataMap = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      HttpService.get(Api.getEmployeeDaySign+'${widget.id??"1"}',context ,params: {'date':DateTime.now().toString().substring(0,19)}).then((res){
        if(res['data'] != null){
          setState(() {
            data = res['data'];
          });
        }
      });
      HttpService.get(Api.getEmployeeMonthSign+'${widget.id??"1"}',context ,params: {'date':DateTime.now().toString().substring(0,19)},showLoading: false).then((res){
        if(res['data'] != null){
          setState(() {
            dataMap = res['data'];
          });
        }
      });
      getInfo(DateTime.parse(dt));
    });
  }

  void getInfo(DateTime day){
    HttpService.get(Api.getEmployeeInfo+'${widget.id??"1"}', context,params: {
      'date':day.toString().substring(0,19)
    }).then((res){
      setState(() {
        infos = res['data'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('打卡月历'),
        bottom: new PreferredSize(
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
                        widget.isBoss? Container() : Text(userModel.loginData['role_name'],style: TextStyle(fontSize: 12,color: textColor))
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    
                  },
                  child: Container(
                    color: Colors.transparent,
                    child:Row(
                      children: <Widget>[
                        Text(dt.substring(0,10),style: TextStyle(fontSize: 14,color: Colors.blue))
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(60),
        ),
      ),
      // bottomNavigationBar: ((DateTime.parse(dt).weekday == 6 || DateTime.parse(dt).weekday==7) && data == null)? Container(height: 0,) : GestureDetector(
      //   onTap: (){

      //   },
      //   child:Container(
      //   width: MediaQuery.of(context).size.width,
      //     height: 60,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       boxShadow: [
      //         BoxShadow(color: Colors.black12)
      //       ]
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Icon(Icons.message,color: Colors.blue),
      //         SizedBox(width:10),
      //         Text('联系管理员',style: TextStyle(color: Colors.blue,fontSize:18))
      //       ],
      //     )
      //   )
      // ),
      body: infos != null? ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top:10),
        physics: BouncingScrollPhysics(),
        children:[
          calender(),
          // Container(
          //   padding: EdgeInsets.only(left:20,right:20,top: 5,bottom: 5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       Text(((DateTime.parse(dt).weekday == 6 || DateTime.parse(dt).weekday==7) && data == null)?'':'默认班次: ${data == null? infos['upWork'].toString().substring(11,16) : data['upTime'].toString().substring(11,16)} - ${data == null ? infos['downWork'].toString().substring(11,16):data['downTime'].toString().substring(11,16)}',style: TextStyle(color:Colors.black54,fontSize: 13),)
          //     ],
          //   ),
          // ),
          SizedBox(height:10),
          info(data)
        ]
      ) : Container(),
    );
  }
  Widget calender(){
    return Container(
      color: Colors.white,
      child:new Calendar(
        firstDate: firstController,
        lastDate: lastController,
        initialCalendarDateOverride: DateTime.now(),
        onSelectedRangeChange: (date){
          HttpService.get(Api.getEmployeeDaySign+'${widget.id??"1"}',context ,params: {'date':date.item1.toString().substring(0,19)}).then((res){
            if(res['data'] != null){
              setState(() {
                data = res['data'];
              });
            }
          });
          HttpService.get(Api.getEmployeeMonthSign+'${widget.id??"1"}',context ,params: {'date':date.item1.toString().substring(0,19)},showLoading: false).then((res){
            if(res['data'] != null){
              setState(() {
                dataMap = res['data'];
              });
            }
          });
        },
        isExpandable: false,
        dayBuilder: (BuildContext context, DateTime day) {
          Random random = Random();
          int status = random.nextInt(4);
          var thisData = dataMap[day.toString().substring(0,10)];
          return new GestureDetector(
            onTap: (){
              if(day.toString() == '1970-01-02 00:00:00.000'){
                return;
              }
              setState(() {
                dt = day.toString();
                this.status = status;
              });
              HttpService.get(Api.getEmployeeDaySign+'${widget.id??"1"}', context ,params: {'date':day.toString().replaceAll('.000', '')},showLoading: true).then((res){
                if(res['data'] != null){
                  setState(() {
                    data = res['data'];
                  });
                }else{
                  setState(() {
                    data = null;
                  });
                }
              });
              getInfo(day);
            },
            child: Container(
              color: Colors.white,
              child:Column(
                children:[
                  new Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: dt == day.toString()?Colors.blue:Colors.transparent,
                    ),
                    child: new Text(
                      day.toString() == '1970-01-02 00:00:00.000'?'':day.day.toString(),
                      style: TextStyle(
                        color:dt == day.toString()?Colors.white:(date.Utils.firstDayOfWeek(day).toString().substring(0,10) == day.toString().substring(0,10) || date.Utils.lastDayOfWeek(day).subtract(Duration(days:1)).toString().substring(0,10) == day.toString().substring(0,10))?Colors.grey : Colors.black
                      ),
                    ),
                  ),
                  SizedBox(height:5),
                  day.toString() == '1970-01-02 00:00:00.000'?Container():Container(
                    width:5,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color: thisData == null? day.weekday == 6 || day.weekday ==7?Colors.transparent:Colors.grey : 
                        ((thisData['morningStatus'] == 0 && thisData['afternoonStatus']==0)?Colors.grey:
                        (thisData['morningStatus'] == 2 && thisData['afternoonStatus']==2)?Colors.blue:
                        ((thisData['morningStatus'] == 1 || thisData['morningStatus'] == 5) || (thisData['afternoonStatus']==4 || thisData['afternoonStatus']==6))?Colors.orange:
                        (thisData['morningStatus'] == 0 || thisData['afternoonStatus']==0)?Colors.orange:
                        (thisData['morningStatus'] == 3 && thisData['afternoonStatus']==3)?Colors.yellow:Colors.grey)
                    ),
                  )
                ]
              )
            ),
          );
        },
      )
    );
  }
  Widget info(Map data){
    return ((DateTime.parse(dt).weekday == 6 || DateTime.parse(dt).weekday==7) && data == null)? Container(
      height: 200,
      child: Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('img/AK-LY休息区.png',width: 50),
          SizedBox(height:10),
          Text('当天休息',style: TextStyle(color: Colors.grey),)
        ],
      )),
    ) : Container(
      color: Colors.white,
      padding: EdgeInsets.only(left:20,right:20),
      child:Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top:15,bottom:15),
            child:Row(
              children: <Widget>[
                Icon(Icons.alarm,color:Colors.green),
                SizedBox(width: 10),
                Text('今日打卡${data == null?0 : (data['morningStatus'] !=0 && data['afternoonStatus'] != 0) ? 2 : (data['morningStatus'] ==0 && data['afternoonStatus'] == 0) ? 0:data['morningStatus'] !=0 || data['afternoonStatus'] != 0 ? 1:0}次,工时共计${data==null? 0: data['workTime'] == 0 || data['workTime'] == null? 0 : (double.parse(data['workTime'].toString())/60).toInt().toString()}小时')
              ],
            )
          ),
          Container(height: 0.6,color: Color.fromRGBO(0, 0, 0, 0.1),),
          Container(
            padding: EdgeInsets.only(top:10,bottom:10),
            child:Row(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  padding: EdgeInsets.only(right:3),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(12.5),
                    color: Colors.grey,
                  ),
                  child: Center(
                    child:Text('上',style:TextStyle(color:Colors.white,fontSize:12))
                  ),
                ),
                SizedBox(width: 10),
                Text('打卡时间  ${data == null? "无" : data['morningSignTime'] != null ? data['morningSignTime'].toString().substring(11,16): "无"}'),
                Text('  (上班时间${data == null? infos['upWork'].toString().substring(11,16) : data['upTime'].toString().substring(11,16)})',style:TextStyle(color:Colors.black54))
              ],
            )
          ),
          Container(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                data != null? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 25,
                    ),
                    Icon(Icons.location_on,color:Colors.green),
                    SizedBox(width: 10),
                    Flexible(child: Text(data['morningSignAddress']??'',style:TextStyle(color:Colors.black54,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis))
                  ],  
                ) : Container(),
                SizedBox(height:5),
                Row(
                  children:[
                    data != null?Container(
                      width: 60,
                    ):Container(width: 25),
                    Container(
                      padding: EdgeInsets.only(left:10,right:10),
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(12.5),
                        color: data == null? Colors.red:data['morningStatus']==0?Colors.red:data['morningStatus']==1 || data['morningStatus'] == 5?Colors.orange:data['morningStatus']==2?Colors.blue:data['morningStatus']==3?Colors.grey:Colors.blue,
                      ),
                      child:Text(
                        data == null? '缺卡':
                        data['morningStatus']==0?'缺卡':
                        data['morningStatus']==1 || data['morningStatus'] == 5?'迟到':
                        data['morningStatus']==2?'正常':
                        data['morningStatus']==3?'外勤':'',style:TextStyle(color:Colors.white,fontSize: 10))
                    )
                  ]
                ),
                Container(height:10)
              ]
            )
          ),
          Container(
            padding: EdgeInsets.only(top:10,bottom:10),
            child:Row(
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  padding: EdgeInsets.only(right:3),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(12.5),
                    color: Colors.grey,
                  ),
                  child: Center(
                    child:Text('下',style:TextStyle(color:Colors.white,fontSize:12))
                  ),
                ),
                SizedBox(width: 10),
                Text('打卡时间  ${data == null? "无":data['afternoonSignTime'] != null ? data['afternoonSignTime'].toString().substring(11,16): "无"}'),
                Text('  (下班时间${data == null? infos['downWork'].toString().substring(11,16) : data['downTime'].toString().substring(11,16)})',style:TextStyle(color:Colors.black54))
              ],
            )
          ),
          Container(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                data != null && data['afternoonStatus'] != 0? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 25,
                    ),
                    Icon(Icons.location_on,color:Colors.blue),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(data['afternoonSignAddress'],style:TextStyle(color:Colors.black54,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis),
                    )
                  ],  
                ):Container(),
                SizedBox(height:5),
                Row(
                  children:[
                    data != null && data['afternoonStatus'] != 0 ?Container(
                      width: 60,
                    ):Container(width: 25),
                    Container(
                      padding: EdgeInsets.only(left:10,right:10),
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(12.5),
                        color: data == null? Colors.red:data['afternoonStatus']==0?Colors.red:data['afternoonStatus']==2?Colors.blue:data['afternoonStatus']==3?Colors.grey:data['afternoonStatus']==4 || data['afternoonStatus']==6?Colors.orange:Colors.blue,
                      ),
                      child:Text(data == null? '缺卡':
                      data['afternoonStatus']==0?'缺卡':
                      data['afternoonStatus']==2?'正常':
                      data['afternoonStatus']==3?'外勤':
                      data['afternoonStatus']==4 || data['afternoonStatus']==6?'早退':'',style:TextStyle(color:Colors.white,fontSize: 10))
                    )
                  ]
                ),
                Container(height:10)
              ]
            )
          )
        ]
      )
    );
  }
}