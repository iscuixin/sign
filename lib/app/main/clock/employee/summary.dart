import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/clock/employee/apply_datail.dart';
import 'package:myh_shop/app/main/clock/employee/apply_sign.dart';
import 'package:myh_shop/app/main/clock/employee/work_month.dart';

import 'package:myh_shop/common.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/route_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class ClockSummary extends StatefulWidget {
  @override
  _ClockSummaryState createState() => _ClockSummaryState();
}

class _ClockSummaryState extends State<ClockSummary> {
  var data;
  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  bool six = false;
  bool seven = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
    });
  }
  void getData(){
    HttpService.get(Api.getMonthSummary+userModel.loginData['id'].toString(), context).then((res){
      if(res['data'] != null){
        setState(() {
          data = res['data'];
        });
      }
    });
  }
  final Widget line = Container(
    height: 0.5,
    color: prefix0.hintColor.withOpacity(0.4),
    margin: EdgeInsets.only(left: 10,right:10),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('统计'),
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
                        Text(userModel.loginData['role_name'],style: TextStyle(fontSize: 12,color: textColor))
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    routePush(WorkMonth(id: userModel.loginData['id']));
                  },
                  child: Container(
                    color: Colors.transparent,
                    child:Row(
                      children: <Widget>[
                        Icon(Icons.date_range,size: 14,color: Colors.blue),
                        Text('打卡月历',style: TextStyle(fontSize: 14,color: Colors.blue))
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
      body: data == null ? Container() : ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 10),
          GestureDetector(
            onTap: ()=> setState(() { one = !one; }),
            child: pageLayout('出勤天数', data == null?0: data['signCount'].length, '天'),
          ),
          one?Container(
            child: Column(
              children:(data['signCount'] as List).map((res){
                return Column(
                  children:[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text(res.toString()+'(${getWeekDay(DateTime.parse(res.toString()+' 00:00:00'))})',style: TextStyle(fontSize: 16)),
                          Text('1天',style: TextStyle(color: Colors.black54,fontSize: 16))
                        ]
                      ),
                    ),line
                  ]
                );
              }).toList()
            ),
          ):Container(),
          GestureDetector(
            onTap: ()=> setState(() { two = !two; }),
            child: pageLayout('休息天数', data == null?0: data['wait'].length, '天'),
          ),
          two?Container(
            child: Column(
              children:(data['wait'] as List).map((res){
                return Column(
                  children:[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text(res.toString()+'(${getWeekDay(DateTime.parse(res.toString()+' 00:00:00'))})',style: TextStyle(fontSize: 16)),
                          Text('',style: TextStyle(color: Colors.black54,fontSize: 16))
                        ]
                      ),
                    ),line
                  ]
                );
              }).toList()
            ),
          ):Container(),
          GestureDetector(
            onTap: ()=> setState(() { three = !three; }),
            child: pageLayout('迟到', data == null?0: data['late'].length, '次'),
          ),
          three?Container(
            child: Column(
              children:(data['late'] as List).map((res){
                return Column(
                  children:[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(res['signDate'].toString()+'(${getWeekDay(DateTime.parse(res['signDate'].toString()+' 00:00:00'))})'+'  ${res['upTime'].toString().substring(11,16)}',style: TextStyle(fontSize: 16)),
                              Text('上班迟到${getLateTime(res['lateTime'])}',style: TextStyle(color: Colors.black38,fontSize: 12),)
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              if(res['morningApplyId']==null){
                                routePush(ApplySign(res['signDate'].toString()+' ',res['upTime'],0,userModel.loginData['id'])).then((res){
                                  getData();
                                });
                              }else{
                                routePush(ApplyDetail(res['signDate'].toString()+' ',res['upTime'],0,userModel.loginData['id']));
                              }
                            },
                            child:Text( res['morningApplyId']==null? '去处理' : '处理中',style: TextStyle(color: Colors.blue,fontSize: 16))
                          )
                        ]
                      ),
                    ),line
                  ]
                );
              }).toList()
            ),
          ):Container(),
          GestureDetector(
            onTap: ()=> setState(() { four = !four; }),
            child:pageLayout('早退', data == null?0: data['leaveEarly'].length, '次')
          ),
          four?Container(
            child: Column(
              children:(data['leaveEarly'] as List).map((res){
                return Column(
                  children:[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(res['signDate'].toString()+'(${getWeekDay(DateTime.parse(res['signDate'].toString()+' 00:00:00'))})'+'  ${res['downTime'].toString().substring(11,16)}',style: TextStyle(fontSize: 16)),
                              Text('下班早退${getLateTime(res['leaveEarlyTime'])}',style: TextStyle(color: Colors.black38,fontSize: 12),)
                            ],
                          ),
                          GestureDetector(
                            onTap:(){
                              if(res['afternoonApplyId']==null){
                                routePush(ApplySign(res['signDate'].toString()+' ',res['downTime'],1,userModel.loginData['id'])).then((res){
                                  getData();
                                });
                              }else{
                                routePush(ApplyDetail(res['signDate'].toString()+' ',res['downTime'],1,userModel.loginData['id']));
                              }
                            },
                            child:Text(res['afternoonApplyId']==null?'去处理' : '处理中',style: TextStyle(color: Colors.blue,fontSize: 16))
                          )
                        ]
                      ),
                    ),line
                  ]
                );
              }).toList()
            ),
          ):Container(),
          GestureDetector(
            onTap: ()=> setState(() { five = !five; }),
            child:pageLayout('缺卡', data == null?0: data['notSign'].length, '天')
          ),
          five?Container(
            child: Column(
              children:(data['notSign'] as List).map((res){
                return Column(
                  children:[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(res['signDate'].toString()+'(${getWeekDay(DateTime.parse(res['signDate'].toString()+' 00:00:00'))})'+'  ${res[res['morningStatus'] == 0?'upTime':'downTime'].toString().substring(11,16)}',style: TextStyle(fontSize: 16)),
                              Text(res['morningStatus'] == 0?'上班缺卡':'下班缺卡',style: TextStyle(color: Colors.black38,fontSize: 12),)
                            ],
                          ),
                          GestureDetector(
                            onTap:(){
                              if(res['morningStatus'] == 0){
                                if(res['morningApplyId']==null){
                                  routePush(ApplySign(res['signDate'].toString()+' ',res['upTime'],0,userModel.loginData['id'])).then((res){
                                    getData();
                                  });
                                }else{
                                  routePush(ApplyDetail(res['signDate'].toString()+' ',res['upTime'],0,userModel.loginData['id']));
                                }
                              }else{
                                if(res['afternoonApplyId']==null){
                                  routePush(ApplySign(res['signDate'].toString()+' ',res['downTime'],1,userModel.loginData['id'])).then((res){
                                    getData();
                                  });
                                }else{
                                  routePush(ApplyDetail(res['signDate'].toString()+' ',res['downTime'],1,1));
                                }
                              }
                            },
                            child:Text((res['morningStatus'] == 0 ?(res['morningApplyId']==null):(res['afternoonApplyId']==null))?'去处理':'处理中',style: TextStyle(color: Colors.blue,fontSize: 16))
                          )
                        ]
                      ),
                    ),line
                  ]
                );
              }).toList()
            ),
          ):Container(),
          GestureDetector(
            onTap: ()=> setState(() { six = !six; }),
            child:pageLayout('矿工', data == null?0: data['miner'].length, '天')
          ),
          six?Container(
            child: Column(
              children:(data['miner'] as List).map((res){
                return Column(
                  children:[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(res.toString()+'(${getWeekDay(DateTime.parse(res.toString()+' 00:00:00'))})',style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              routePush(ApplySign(res.toString()+' ','2000-02-03 09:00:00',0,userModel.loginData['id'])).then((res){
                                getData();
                              });
                            },
                            child: Text('去处理',style: TextStyle(color: Colors.blue,fontSize: 16)),
                          )
                        ]
                      ),
                    ),line
                  ]
                );
              }).toList()
            ),
          ):Container(),
          GestureDetector(
            onTap: ()=> setState(() { seven = !seven; }),
            child:pageLayout('外勤', data == null?0: data['out'].length, '天')
          ),
          seven?Container(
            child: Column(
              children:(data['out'] as List).map((res){
                return Column(
                  children:[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(res['signDate'].toString()+'(${getWeekDay(DateTime.parse(res['signDate'].toString()+' 00:00:00'))})',style: TextStyle(fontSize: 16)),
                              Container(
                                width: 340,
                                child:Text(res['morningSignAddress'],style: TextStyle(color: Colors.black38,fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis)
                              )
                            ],
                          ),
                          Text('',style: TextStyle(color: Colors.blue,fontSize: 16))
                        ]
                      ),
                    ),line
                  ]
                );
              }).toList()
            ),
          ):Container(),
        ],
      ),
    );
  }

  String getLateTime(int m){
    if(m < 60){
      return m.toString()+'分钟';
    }
    if(m == 60){
      return '1小时';
    }
    return (m/60).toInt().toString() + '小时' + (m%60).toString() + '分钟';
  }

  String getWeekDay(DateTime date){
    int day = date.weekday;
    String res = '';
    switch(day){
      case 1:
        res = '星期一';
        break;
      case 2:
        res = '星期二';
        break;
      case 3:
        res = '星期三';
        break;
      case 4:
        res = '星期四';
        break;
      case 5:
        res = '星期五';
        break;
      case 6:
        res = '星期六';
        break;
      case 7:
        res = '星期日';
        break;
    }
    return res;
  }

  Widget pageLayout(String title, int count, String unit){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: bg,
            width: 1
          )
        )
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title),
          Row(
            children: <Widget>[
              Text(count.toString() + unit,style: TextStyle(color: count == 0 ? textColor:Colors.black45)),
              Icon(Icons.keyboard_arrow_down,size: 15,color: textColor)
            ],
          )
        ],
      ),
    );
  }
}
