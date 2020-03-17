import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/clock/boss/apply_list.dart';
import 'package:myh_shop/app/main/clock/employee/work_month.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/dialog_util.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/route_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:url_launcher/url_launcher.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  DateTime dateTime = DateTime.now();
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  List tabList = [
    {'name':'日统计'},
    {'name':'周统计'},
    {'name':'月统计'}
  ];
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('员工列表'),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              routePush(ApplyList(prefix0.userModel.loginData['sid'].toString()));
            },
            child: Text('补卡申请',style: TextStyle(color: Colors.blue),),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height:15),
          Expanded(
            child: DefaultTabController(
              length: tabList.length, 
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar:TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: Colors.blue,
                  indicatorWeight: 1,
                  isScrollable: false,
                  labelStyle: TextStyle(fontSize: 14),
                  tabs: tabList.map((res){
                    return Tab(
                      child: Text(res['name']),
                    );
                  }).toList()
                ),
                body: Column(
                  children:[
                    Container(
                      height: 0.4,
                      color:Color.fromRGBO(0, 0, 0, 0.1)
                    ),
                    Expanded(
                      child:TabBarView(
                        children: <Widget>[
                          DayStatistics(),
                          WeekStatistics(),
                          MonthStatistics()
                        ],
                      )
                    ),
                  ]
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}

class DayStatistics extends StatefulWidget {
  @override
  _DayStatisticsState createState() => _DayStatisticsState();
}

class _DayStatisticsState extends State<DayStatistics> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  DateTime dateTime = DateTime.now();
  List signList = [];
  List notSignList = [];
  int companyEmployCount = -1;
  bool isSign = true;
  Map roleList = {};
  getData({bool show = true}){
    HttpService.get(Api.getDayStatistics+prefix0.userModel.loginData['sid'].toString(), context,params: {'date':dateTime.toString().substring(0,19)}).then((res){
      setState(() {
        signList = res['data']['signList'];
        notSignList = res['data']['notSignList'];
        companyEmployCount = res['data']['companyEmployCount'];
      });
    });
  }

  getRoleList({bool show = true}){
    HttpService.get(Api.roleList, context,showLoading: false).then((res){
      setState(() {
        roleList = res['data'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData(show: false);
      getRoleList(show: false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return companyEmployCount == -1 && roleList.length != 0? Container() : days();
  }

  Widget chart(){
    GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
    return AnimatedCircularChart(
      key: _chartKey,
      size:  Size(300, 280),
      holeRadius: 50,
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              (signList.length/companyEmployCount)*100,
              Colors.blue[400],
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              100-((signList.length/companyEmployCount)*100),
              Color.fromRGBO(0, 0, 0, 0.1),
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      percentageValues: true,
    );
  }
  Widget days(){
    return ListView(
      children:[
        Stack(
          alignment: AlignmentDirectional.center,
          children:[
            chart(),
            Positioned(
              child:Column(
                children:[
                  Text('打卡人数/应到人数'),
                  SizedBox(height:5),
                  Text('${signList.length.toString()}/${companyEmployCount.toString()}',style: TextStyle(color: Colors.blue,fontSize:20,fontWeight: FontWeight.w500))
                ]
              )
            ),
            Positioned(
              top: 10,
              left: 10,
              child:GestureDetector(
                onTap: (){
                  showDatePicker(
                    context: context,
                    initialDate: dateTime,
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
                      dateTime = res;
                    });
                    getData();
                  }
                });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children:[
                      Text(dateTime.toString().substring(0,10).replaceAll('-', '.'),style: TextStyle(color: Colors.blue,fontSize: 16)),
                      Icon(Icons.keyboard_arrow_down,size: 14,color: Colors.blue,)
                    ]
                  )
                ),
              )
            ),
            Positioned(
              bottom: 10,
              child:Container(
                width: MediaQuery.of(context).size.width,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSign = true;
                        });
                      },
                      child: Text('已打卡[${signList.length.toString()}]',style: TextStyle(fontSize: 16,color: isSign ? Colors.black : Colors.black54)),
                    ),
                    GestureDetector(
                      onTap: ()=>setState(() {
                        isSign = false;
                      }),
                      child: Text('应到但未打卡[${notSignList.length.toString()}]',style: TextStyle(fontSize: 16,color: !isSign ? Colors.black : Colors.black54)),
                    )
                  ]
                )
              )
            ) 
          ]
        ),
        Container(
          height: 0.5,
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(0, 0, 0, 0.1),
        ),
        Column(
          children:(isSign ? signList : notSignList).map((res){
            return GestureDetector(
              onTap: (){
                routePush(WorkMonth(isBoss: true,id:res['id']));
              },
              child:Container(
              decoration: BoxDecoration(
                border:Border(
                  bottom:BorderSide(
                    width:0.6,
                    color:Color.fromRGBO(0, 0, 0, 0.1)
                  )
                )
              ),
              margin: EdgeInsets.only(left:15,right:15),
              padding: EdgeInsets.only(top: 15,bottom:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Row(
                    children:[
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'http://image.biaobaiju.com/uploads/20180803/23/1533308847-sJINRfclxg.jpeg'
                        ),
                      ),
                      SizedBox(width:10),
                      Text(res['nickname'],style:TextStyle(fontSize: 15)),
                      SizedBox(width:10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.only(left:6,right:6),
                        height: 20,
                        child: Text(roleList[res['role'].toString()].toString(),style: TextStyle(color: Colors.white,fontSize: 13))
                      )
                    ]
                  ),
                  res['morningStatus'] == null && res['afternoonStatus'] == null ?Text('旷工',style: TextStyle(color:Colors.red,fontSize: 15)): RichText(
                    text: TextSpan(
                      text:'早',
                      style:TextStyle(color:Colors.black,fontSize: 15),
                      children: [
                        TextSpan(
                          text: res['morningStatus'] == 0? '缺卡':
                          res['morningStatus'] == 1? '迟到':
                          res['morningStatus'] == 2? '正常':
                          res['morningStatus'] == 5? '迟到':'缺卡',
                          style:TextStyle(color:res['morningStatus'] == 0? Colors.red:
                          res['morningStatus'] == 1? Colors.orange:
                          res['morningStatus'] == 2? Colors.blue:
                          res['morningStatus'] == 5? Colors.orange:Colors.red,fontSize: 15),
                        ),
                        TextSpan(
                          text:',晚',
                          style:TextStyle(color:Colors.black,fontSize: 15),
                        ),
                        TextSpan(
                          text: res['afternoonStatus'] == 0? '缺卡':
                          res['afternoonStatus'] == 4? '早退':
                          res['afternoonStatus'] == 2? '正常':
                          res['afternoonStatus'] == 6? '早退':'缺卡',
                          style:TextStyle(color:res['afternoonStatus'] == 0? Colors.red:
                          res['afternoonStatus'] == 4? Colors.orange:
                          res['afternoonStatus'] == 2? Colors.blue:
                          res['afternoonStatus'] == 6? Colors.orange:Colors.red,fontSize: 15),
                        ),
                      ]
                    ),
                  )
                ]
              )
            )
            );
          }).toList()
        )
      ]
    );
  }
}

class WeekStatistics extends StatefulWidget {
  @override
  _WeekStatisticsState createState() => _WeekStatisticsState();
}

class _WeekStatisticsState extends State<WeekStatistics> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  DateTime dateTime = DateTime.now();
  List signList = [];
  List notSignList = [];
  int companyEmployCount = -1;
  bool isSign = true;
  Map roleList = {};
  getData({bool show = true}){
    HttpService.get(Api.getWeekStatistics+prefix0.userModel.loginData['sid'].toString(), context,params: {'date':dateTime.toString().substring(0,19)},showLoading: show).then((res){
      setState(() {
        signList = res['data']['signList'];
        notSignList = res['data']['notSignList'];
        companyEmployCount = res['data']['companyEmployCount'];
      });
    });
  }

  getRoleList({bool show = false}){
    HttpService.get(Api.roleList, context,showLoading: show).then((res){
      setState(() {
        roleList = res['data'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
      getRoleList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return companyEmployCount == -1 && roleList.length != 0? Container() : days();
  }

  Widget chart(){
    GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
    return AnimatedCircularChart(
      key: _chartKey,
      size:  Size(300, 280),
      holeRadius: 50,
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              (signList.length/companyEmployCount)*100,
              Colors.blue[400],
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              100-((signList.length/companyEmployCount)*100),
              Color.fromRGBO(0, 0, 0, 0.1),
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      percentageValues: true,
    );
  }
  Widget days(){
    return ListView(
      children:[
        Stack(
          alignment: AlignmentDirectional.center,
          children:[
            chart(),
            Positioned(
              child:Column(
                children:[
                  Text('打卡人数/应到人数'),
                  SizedBox(height:5),
                  Text('${signList.length.toString()}/${companyEmployCount.toString()}',style: TextStyle(color: Colors.blue,fontSize:20,fontWeight: FontWeight.w500))
                ]
              )
            ),
            Positioned(
              top: 10,
              left: 10,
              child:GestureDetector(
                onTap: (){
                  showDatePicker(
                    context: context,
                    initialDate: dateTime,
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
                      dateTime = res;
                    });
                    getData();
                  }
                });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children:[
                      Text(dateTime.toString().substring(0,10).replaceAll('-', '.'),style: TextStyle(color: Colors.blue,fontSize: 16)),
                      Icon(Icons.keyboard_arrow_down,size: 14,color: Colors.blue,)
                    ]
                  )
                ),
              )
            ),
            Positioned(
              bottom: 10,
              child:Container(
                width: MediaQuery.of(context).size.width,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSign = true;
                        });
                      },
                      child: Text('已打卡[${signList.length.toString()}]',style: TextStyle(fontSize: 16,color: isSign ? Colors.black : Colors.black54)),
                    ),
                    GestureDetector(
                      onTap: ()=>setState(() {
                        isSign = false;
                      }),
                      child: Text('矿工[${notSignList.length.toString()}]',style: TextStyle(fontSize: 16,color: !isSign ? Colors.black : Colors.black54)),
                    )
                  ]
                )
              )
            ) 
          ]
        ),
        Container(
          height: 0.5,
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(0, 0, 0, 0.1),
        ),
        Column(
          children:(isSign ? signList : notSignList).map((res){
            return GestureDetector(
              onTap:(){
                routePush(WorkMonth(isBoss: true,id:res['id']));
              },
              child:Container(
              decoration: BoxDecoration(
                border:Border(
                  bottom:BorderSide(
                    width:0.6,
                    color:Color.fromRGBO(0, 0, 0, 0.1)
                  )
                )
              ),
              margin: EdgeInsets.only(left:15,right:15),
              padding: EdgeInsets.only(top: 15,bottom:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Row(
                    children:[
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'http://image.biaobaiju.com/uploads/20180803/23/1533308847-sJINRfclxg.jpeg'
                        ),
                      ),
                      SizedBox(width:10),
                      Text(res['nickname'],style:TextStyle(fontSize: 15)),
                      SizedBox(width:10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.only(left:6,right:6),
                        height: 20,
                        child: Text(roleList[res['role'].toString()].toString(),style: TextStyle(color: Colors.white,fontSize: 13))
                      )
                    ]
                  ),
                  !isSign?Text('本周未出勤',style: TextStyle(color: Colors.black45,fontSize: 15),) : RichText(
                    text: TextSpan(
                      text:'出勤',
                      style:TextStyle(color:Colors.black,fontSize: 15),
                      children: [
                        TextSpan(
                          text: res['signCounts'].toString()+'天',
                          style:TextStyle(color:Colors.black,fontSize: 15),
                        ),
                        TextSpan(
                          text:',异常',
                          style:TextStyle(color:Colors.black,fontSize: 15),
                        ),
                        TextSpan(
                          text: res['errorCounts'].toString(),
                          style:TextStyle(color:Colors.orange,fontSize: 15),
                        ),
                        TextSpan(
                          text:'天',
                          style:TextStyle(color:Colors.black,fontSize: 15),
                        ),
                      ]
                    ),
                  )
                ]
              )
            )
            );
          }).toList()
        )
      ]
    );
  }
}

class MonthStatistics extends StatefulWidget {
  @override
  _MonthStatisticsState createState() => _MonthStatisticsState();
}

class _MonthStatisticsState extends State<MonthStatistics> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  DateTime dateTime = DateTime.now();
  List signList = [];
  List notSignList = [];
  int companyEmployCount = -1;
  bool isSign = true;
  Map roleList = {};
  getData(){
    HttpService.get(Api.getMonthStatistics+prefix0.userModel.loginData['sid'].toString(), context,params: {'date':dateTime.toString().substring(0,19)}).then((res){
      setState(() {
        signList = res['data']['signList'];
        notSignList = res['data']['notSignList'];
        companyEmployCount = res['data']['companyEmployCount'];
      });
    });
  }

  getRoleList(){
    HttpService.get(Api.roleList, context,showLoading: false).then((res){
      setState(() {
        roleList = res['data'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData();
      getRoleList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return companyEmployCount == -1 && roleList.length != 0? Container() : days();
  }

  Widget chart(){
    GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
    return AnimatedCircularChart(
      key: _chartKey,
      size:  Size(300, 280),
      holeRadius: 50,
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              (signList.length/companyEmployCount)*100,
              Colors.blue[400],
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              100-((signList.length/companyEmployCount)*100),
              Color.fromRGBO(0, 0, 0, 0.1),
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      percentageValues: true,
    );
  }
  Widget days(){
    return ListView(
      children:[
        Stack(
          alignment: AlignmentDirectional.center,
          children:[
            chart(),
            Positioned(
              child:Column(
                children:[
                  Text('打卡人数/应到人数'),
                  SizedBox(height:5),
                  Text('${signList.length.toString()}/${companyEmployCount.toString()}',style: TextStyle(color: Colors.blue,fontSize:20,fontWeight: FontWeight.w500))
                ]
              )
            ),
            Positioned(
              top: 10,
              left: 10,
              child:Container(
                width: MediaQuery.of(context).size.width - 20,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      showDatePicker(
                        context: context,
                        initialDate: dateTime,
                        firstDate: new DateTime.now().subtract(new Duration(days: 100)), // 减 30 天
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
                          dateTime = res;
                        });
                        getData();
                      }
                    });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children:[
                          Text(dateTime.toString().substring(0,10).replaceAll('-', '.'),style: TextStyle(color: Colors.blue,fontSize: 16)),
                          Icon(Icons.keyboard_arrow_down,size: 14,color: Colors.blue,)
                        ]
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      DialogUtil.showEnterDialog(context,content: "是否导出本月出勤表").then((res)async{
                        if(res){
                          String url = 'http://sign.myhkj.cn/excel/download/sign?companyId=${prefix0.userModel.loginData['sid'].toString()}&date=${dateTime.toString().substring(0,19)}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                        }
                      });
                    },
                    child: Text('导出出勤报表',style: TextStyle(color: Colors.black54,fontSize: 13,decoration: TextDecoration.underline),)
                  )
                ],
              )
              )
            ),
            Positioned(
              bottom: 10,
              child:Container(
                width: MediaQuery.of(context).size.width,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSign = true;
                        });
                      },
                      child: Text('已打卡[${signList.length.toString()}]',style: TextStyle(fontSize: 16,color: isSign ? Colors.black : Colors.black54)),
                    ),
                    GestureDetector(
                      onTap: ()=>setState(() {
                        isSign = false;
                      }),
                      child: Text('矿工[${notSignList.length.toString()}]',style: TextStyle(fontSize: 16,color: !isSign ? Colors.black : Colors.black54)),
                    )
                  ]
                )
              )
            ) 
          ]
        ),
        Container(
          height: 0.5,
          width: MediaQuery.of(context).size.width,
          color: Color.fromRGBO(0, 0, 0, 0.1),
        ),
        Column(
          children:(isSign ? signList : notSignList).map((res){
            return GestureDetector(
              onTap: (){
                routePush(WorkMonth(isBoss: true,id: res['id']));
              },
              child: Container(
              decoration: BoxDecoration(
                border:Border(
                  bottom:BorderSide(
                    width:0.6,
                    color:Color.fromRGBO(0, 0, 0, 0.1)
                  )
                )
              ),
              margin: EdgeInsets.only(left:15,right:15),
              padding: EdgeInsets.only(top: 15,bottom:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Row(
                    children:[
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'http://image.biaobaiju.com/uploads/20180803/23/1533308847-sJINRfclxg.jpeg'
                        ),
                      ),
                      SizedBox(width:10),
                      Text(res['nickname'],style:TextStyle(fontSize: 15)),
                      SizedBox(width:10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.only(left:6,right:6),
                        height: 20,
                        child: Text(roleList[res['role'].toString()].toString(),style: TextStyle(color: Colors.white,fontSize: 13))
                      )
                    ]
                  ),
                  !isSign?Text('本月未出勤',style: TextStyle(color: Colors.black45,fontSize: 15),) : RichText(
                    text: TextSpan(
                      text:'出勤',
                      style:TextStyle(color:Colors.black,fontSize: 15),
                      children: [
                        TextSpan(
                          text: res['signCounts'].toString()+'天',
                          style:TextStyle(color:Colors.black,fontSize: 15),
                        ),
                        TextSpan(
                          text:',异常',
                          style:TextStyle(color:Colors.black,fontSize: 15),
                        ),
                        TextSpan(
                          text: res['errorCounts'].toString(),
                          style:TextStyle(color:Colors.orange,fontSize: 15),
                        ),
                        TextSpan(
                          text:'天',
                          style:TextStyle(color:Colors.black,fontSize: 15),
                        ),
                      ]
                    ),
                  )
                ]
              )
            ),
            );
          }).toList()
        )
      ]
    );
  }
}