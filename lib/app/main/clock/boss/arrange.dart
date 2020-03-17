import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:myh_shop/app/main/clock/boss/arrage_detail.dart';
import 'package:myh_shop/app/main/clock/boss/arrange_type.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/dialog_util.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/route_util.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:date_utils/date_utils.dart' as date;

class Arrange extends StatefulWidget {
  @override
  _ArrangeState createState() => _ArrangeState();
}

class _ArrangeState extends State<Arrange> {

  List employeeList = [];

  var arrangeInfo;

  List morning = [];

  List afternnon = [];

  List evening = [];

  List all = [];

  var monthInfo = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      HttpService.get(Api.employeeList+prefix0.userModel.loginData['sid'].toString(), context,showLoading: false).then((res){
        setState(() {
          employeeList = res['data'];
        });
      });
      getArrangeInfo(DateTime.parse(dt),show: false);
      getMonthArrange(DateTime.parse(dt));
    });
  }

  getMonthArrange(DateTime month){
    HttpService.get(Api.arrangeMonth+prefix0.userModel.loginData['sid'].toString(), context,params: {
      'arrangeDate':month.toString().substring(0,19)
    },showLoading: false).then((res){
      setState(() {
        monthInfo = res['data'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        elevation: 1,
        title: Text('排班'),
        actions: <Widget>[
          FlatButton(onPressed: (){
            List list = [];
            map.forEach((k,v){
              list.add({'type':k,'select':new TextEditingController(text:'请选择')});
            });
            if(employeeList.length == 0){
              ToastUtil.toast('当前暂无员工');
              return;
            }
            routePush(ArrageDetail(DateTime.parse(dt),list,employeeList,prefix0.userModel.loginData['sid']));
          }, child: Text('详情',style: TextStyle(color: Colors.blue),))
        ],
      ),
      body: Column(
        children: <Widget>[
          calender(),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child:days.length >= 2?Text('设置'+days.first.toString().substring(5,10)+'到'+days.last.toString().substring(5,10)+'排班' ,style: TextStyle(color: Colors.black54,fontSize: 14)):
            Text('设置'+DateTime.parse(dt).month.toString()+'月'+DateTime.parse(dt).day.toString()+'号排班',style: TextStyle(color: Colors.black54,fontSize: 14))
          ),
          Expanded(
            child: days.length >= 2? Container(
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    bool has = false;
                    for(DateTime day in days){
                      if(monthInfo[day.toString().substring(0,10)] != null){
                        has = true;
                      }
                    }
                    if(has){
                      DialogUtil.showEnterDialog(context,content: 
                      '''此时间段中包含已设置的排班,继续操作将覆盖原有记录''').then((res){
                        if(res){
                          List list = [];
                          map.forEach((k,v){
                            list.add({'type':k,'select':new TextEditingController(text:'请选择')});
                          });
                          if(employeeList.length == 0){
                            ToastUtil.toast('当前暂无员工');
                            return;
                          }
                          routePush(ArrangeType(list,employeeList,days,prefix0.userModel.loginData['sid'],isSection: true)).then((res){
                            getArrangeInfo(DateTime.parse(dt));
                            getMonthArrange(DateTime.parse(dt));
                          });
                        }
                      });
                    }else{
                      List list = [];
                      map.forEach((k,v){
                        list.add({'type':k,'select':new TextEditingController(text:'请选择')});
                      });
                      if(employeeList.length == 0){
                        ToastUtil.toast('当前暂无员工');
                        return;
                      }
                      routePush(ArrangeType(list,employeeList,days,prefix0.userModel.loginData['sid'],isSection: true)).then((res){
                        getArrangeInfo(DateTime.parse(dt));
                        getMonthArrange(DateTime.parse(dt));
                      });
                    }
                  },
                  child:Container(
                    decoration: BoxDecoration(
                      border: Border.all(width:1,color:Colors.black26),
                      borderRadius: BorderRadius.circular(3)
                    ),
                    padding: EdgeInsets.only(left:15,right:15,top:10,bottom:10),
                    child: Text('此时段暂无排班,去设置')
                  )
                )
              )
            ):( arrangeInfo == null ? Container(
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    List list = [];
                    map.forEach((k,v){
                      list.add({'type':k,'select':new TextEditingController(text:'请选择')});
                    });
                    if(employeeList.length == 0){
                      ToastUtil.toast('当前暂无员工');
                      return;
                    }
                    routePush(ArrangeType(list,employeeList,[DateTime.parse(dt),DateTime.parse(dt)],prefix0.userModel.loginData['sid'])).then((res){
                      getArrangeInfo(DateTime.parse(dt));
                      getMonthArrange(DateTime.parse(dt));
                    });
                  },
                  child:Container(
                    decoration: BoxDecoration(
                      border: Border.all(width:1,color:Colors.black26),
                      borderRadius: BorderRadius.circular(3)
                    ),
                    padding: EdgeInsets.only(left:15,right:15,top:10,bottom:10),
                    child: Text('暂无排班,去设置')
                  )
                )
              )
            ):workTime())
          )
        ],
      ),
    );
  }
  List<DateTime> days = [];
  String dt = DateTime.now().year.toString()+'-'+(DateTime.now().month.toString().length==1?'0'+DateTime.now().month.toString():DateTime.now().month.toString())+'-'+((DateTime.now().day+1).toString().length==1?'0'+(DateTime.now().day+1).toString():(DateTime.now().day+1).toString())+' 00:00:00.000';
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  Widget calender(){
    return Container(
      color: Colors.white,
      child:new Calendar(
        firstDate: firstController,
        lastDate: lastController,
        initialCalendarDateOverride: DateTime.now().add(Duration(days:1)),
        isExpandable: false,
        dayBuilder: (BuildContext context, DateTime day) {
          return new GestureDetector(
            onDoubleTap: () {
              days.clear();
              if(DateTime.parse(dt).isBefore(day)){
                DateTime start = DateTime.parse(dt);
                int differenceDay = day.difference(start).inDays;
                DateTime time = start;
                days.add(start);
                for(int i = 0; i < differenceDay; i++){
                  time = time.add(Duration(days: 1));
                  days.add(time);         
                }
              }else if(DateTime.parse(dt).isAfter(day)){
                DateTime time = DateTime.now();
                if((day.year == time.year && day.month == time.month && day.day == time.day)){
                  ToastUtil.toast('请从当前时间的第二日设置');
                  return;
                }
                if(day.isBefore(time)){
                  ToastUtil.toast('请从当前时间的第二日设置');
                  return;
                }
                DateTime start = DateTime.parse(dt);
                int differenceDay = start.difference(day).inDays;
                DateTime times = day;
                days.add(day);
                for(int i = 0; i < differenceDay; i++){
                  times = times.add(Duration(days: 1));
                  days.add(times);         
                }
              }
              setState(() {});
            },
            onTap: () => onTap(day),
            child: Container(
              color: Colors.white,
              child:Column(
                children:[
                  Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (days.length>=2?days.indexOf(day) != -1 :dt == day.toString() )?Colors.blue:Colors.transparent,
                    ),
                    child: new Text(
                      day.toString() == '1970-01-02 00:00:00.000'?'':day.day.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        color:(days.length>=2?days.indexOf(day) != -1 :dt == day.toString() )?Colors.white:(date.Utils.firstDayOfWeek(day).toString().substring(0,10) == day.toString().substring(0,10) || date.Utils.lastDayOfWeek(day).subtract(Duration(days:1)).toString().substring(0,10) == day.toString().substring(0,10))?Colors.grey : Colors.black
                      ),
                    ),
                  ),
                  SizedBox(height:3),
                  monthInfo.length != 0 && monthInfo[day.toString().substring(0,10)] != null? Container(
                    width: 5,
                    height: 5,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green,
                    ),
                  ):Container()
                ]
              )
            ),
          );
        },
      )
    );
  }

  void onTap(DateTime day){
    if(day.toString() == '1970-01-02 00:00:00.000'){
      return;
    }
    DateTime time = DateTime.now();
    if((day.year == time.year && day.month == time.month && day.day == time.day)){
      ToastUtil.toast('请从当前时间的第二日设置');
      return;
    }
    if(day.isBefore(time)){
      ToastUtil.toast('请从当前时间的第二日设置');
      return;
    }
    setState(() {
      dt = day.toString();
      days.clear();
    });
    getArrangeInfo(day);
  }

  getArrangeInfo(DateTime day,{bool show = true}){
    HttpService.get(Api.arrangeInfo+prefix0.userModel.loginData['sid'].toString(), context,params: {'signDate':day.toString().substring(0,19)},showLoading: show).then((res){
      var data = res['data'];
      if(data['1'].length != 0 || data['2'].length != 0 || data['3'].length != 0 || data['0'].length != 0){
        setState(() {
          arrangeInfo = data;
          morning= data['0'];
          afternnon = data['1'];
          evening = data['2'];
          all = data['3'];
        });
      }else{
        setState(() {
          arrangeInfo = null;
        });
      }
    });
  }
  Map map = {
    '早班':false,
    '中班':false,
    '晚班':false,
    '通班':false,
  };
  Widget workTime(){
    List<Widget> list = [];
    map.forEach((k,v){
      List thisList = k == '早班' ? morning : k == '中班'? afternnon : k == '晚班'? evening : k == '通班'? all :[];
      list.add(
        Expanded(
          child:Container(
            child: GestureDetector(
              onTap: (){
                List list = [];
                map.forEach((k,v){
                  list.add({'type':k,'select':new TextEditingController(text:'请选择')});
                });
                if(employeeList.length == 0){
                  ToastUtil.toast('当前暂无员工');
                  return;
                }
                routePush(ArrangeType(list,employeeList,[DateTime.parse(dt),DateTime.parse(dt)],prefix0.userModel.loginData['sid'])).then((res){
                  getArrangeInfo(DateTime.parse(dt));
                  getMonthArrange(DateTime.parse(dt));
                });
              },
              child:Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom:BorderSide(
                      width:0.6,
                      color:Color.fromRGBO(0, 0, 0, 0.1)
                    )
                  )
                ),
                padding: EdgeInsets.only(left: 20,right: 20),
                width: MediaQuery.of(context).size.width,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(k.toString()+"(${thisList.length.toString()}人)",style: TextStyle(fontSize: 14)),
                        SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            thisList.length >= 1 ? Container(
                              padding: EdgeInsets.only(left:5,right:5),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(thisList[0]['nickname'],style: TextStyle(color: Colors.white,fontSize: 11)),
                            ):Container(),
                            SizedBox(width:3),
                            thisList.length >= 2 ? Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.only(left:5,right:5),
                              child: Text(thisList[1]['nickname'],style: TextStyle(color: Colors.white,fontSize: 11)),
                            ):Container(),
                            SizedBox(width:3),
                            thisList.length >= 3 ? Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.only(left:5,right:5),
                              child: Text(thisList[2]['nickname'],style: TextStyle(color: Colors.white,fontSize: 11)),
                            ):Container(),
                            SizedBox(width:3),
                            thisList.length >= 4 ? Text('...'):Container()
                          ],
                        )
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,color: Colors.black38,size: 15)
                  ]
                )
              )
            )
          )
        )
      );
    });
    return Column(children:list);
  }
}