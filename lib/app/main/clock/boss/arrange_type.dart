import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/clock/boss/select_employee.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/route_util.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';


class ArrangeType extends StatefulWidget {
  final List typeList;
  final List employeeList;
  final List dateTimes;
  final int companyId;
  final bool isSection;
  ArrangeType(this.typeList,this.employeeList,this.dateTimes,this.companyId,{this.isSection = false});
  @override
  _ArrangeTypeState createState() => _ArrangeTypeState();
}

class _ArrangeTypeState extends State<ArrangeType> {

  List hoursData = [];

  List minuteData = [];

  Map employeeArrange = {};

  Map employeeArrange2 = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((res){
      setState(() {
        for(int i = 0; i < 24; i++){
          hoursData.add({'name':i >= 10? i.toString() : '0'+i.toString()});
        }
        for(int i = 0; i < 60; i++){
          minuteData.add({'name':i >= 10? i.toString() : '0'+i.toString()});
        }
      });
      for(var v in widget.typeList){
        setState(() {
          employeeArrange[v['type']] = [];
        });
      }
      if(widget.isSection){
        setState(() {
          employeeArrange['早班'] = [];
          employeeArrange['中班'] = [];
          employeeArrange['晚班'] = [];
          employeeArrange['通班'] = [];
          employeeArrange2['早班'] = [];
          employeeArrange2['中班'] = [];
          employeeArrange2['晚班'] = [];
          employeeArrange2['通班'] = [];
        });
      }else{
        getArrangeInfo();
      }
    }); 
  }
  getArrangeInfo(){
    HttpService.get(Api.arrangeInfo+widget.companyId.toString(), context ,params: {'signDate':widget.dateTimes.first.toString().substring(0,19)}).then((res){
      (res['data'] as Map).forEach((k,v) {
        if(v.length != 0){
          setState(() {
            if(k == '0'){
              employeeArrange['早班'] = v;
              List list = [];
              for(var x in v){
                list.add(x);
              }
              employeeArrange2['早班'] = list;
              for(var x in widget.typeList){
                if(x['type'] == '早班'){
                  x['select'].text = DateTime.parse(v[0]['upWork'].toString()).toString().substring(11,16) + '-' + DateTime.parse(v[0]['downWork'].toString()).toString().substring(11,16);
                }
              }
            }
            if(k == '1'){
              employeeArrange['中班'] = v;
              List list = [];
              for(var x in v){
                list.add(x);
              }
              employeeArrange2['中班'] = list;
              for(var x in widget.typeList){
                if(x['type'] == '中班'){
                  x['select'].text = DateTime.parse(v[0]['upWork'].toString()).toString().substring(11,16) + '-' + DateTime.parse(v[0]['downWork'].toString()).toString().substring(11,16);
                }
              }
            }
            if(k == '2'){
              employeeArrange['晚班'] = v;
              List list = [];
              for(var x in v){
                list.add(x);
              }
              employeeArrange2['晚班'] = list;
              for(var x in widget.typeList){
                if(x['type'] == '晚班'){
                  x['select'].text = DateTime.parse(v[0]['upWork'].toString()).toString().substring(11,16) + '-' + DateTime.parse(v[0]['downWork'].toString()).toString().substring(11,16);
                }
              }
            }
            if(k == '3'){
              employeeArrange['通班'] = v;
              List list = [];
              for(var x in v){
                list.add(x);
              }
              employeeArrange2['通班'] = list;
              for(var x in widget.typeList){
                if(x['type'] == '通班'){
                  x['select'].text = DateTime.parse(v[0]['upWork'].toString()).toString().substring(11,16) + '-' + DateTime.parse(v[0]['downWork'].toString()).toString().substring(11,16);
                }
              }
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:MyAppBar(
        elevation: 1,
        title: Text('排班'),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Map<String, dynamic> params = {};
              List arrangeDTOList = [];
              for(var v in widget.typeList){
                if(v['select'].text != '请选择' && employeeArrange[v['type']].length != 0){
                  String arrangeType = v['type'] == '早班'?'0':v['type'] == '中班'?'1':v['type'] == '晚班'? '2' :v['type'] == '通班'? '3':'0';
                  String upAndDownTime = v['select'].text;
                  List employeeList = employeeArrange[v['type']];
                  String signDate = widget.dateTimes.first.toString().substring(0,19);
                  String deadDate = widget.dateTimes.last.toString().substring(0,19);
                  List cancelList = [];
                  for(var x in (employeeArrange2[v['type']] as List)){
                    cancelList.add(x);
                  }
                  List employeeList2 = [];
                  for(var x in (employeeArrange2[v['type']] as List)){
                    employeeList2.add(x);
                  }
                  for(var x in employeeList){
                    for(var y in employeeList2){
                      if(x['id'] == y['id']){
                        cancelList.remove(x);
                      }
                    }
                  }
                  arrangeDTOList.add({
                    'arrangeType':arrangeType,
                    'upAndDownTime':upAndDownTime,
                    'employeeList':employeeList,
                    'signDate':signDate,
                    'cancelList':cancelList,
                    'deadDate':deadDate
                  });
                }
              }
              params['arrangeDTOList'] = arrangeDTOList;
              params['companyId'] = widget.companyId;
              HttpService.post(Api.arrangeSet, context,params: params,showLoading: true).then((res){
                var rs =convert.json.decode(res.toString());
                if(rs['data']){
                  ToastUtil.toast('保存成功');
                  Navigator.pop(context);
                }else{
                  ToastUtil.toast('保存失败,请稍后再试');
                }
              });
            }, 
            child: Text('保存',style: TextStyle(color: Colors.blue),)
          )
        ],
      ),
      body: employeeArrange.length == 0? Container() : ListView(
        physics: BouncingScrollPhysics(),
        children:[
          Container(
            height: 20,
            color: bg,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:widget.typeList.map((res){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(res['type'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                    SizedBox(height: 20),
                    select(title: '请选择上下班时间', selection: res['select']),
                    selectEmployee(res['type']),
                    SizedBox(height: 30)
                  ],
                );
              }).toList()
            )
          )
        ]
      ),
    );
  }

  Widget selectEmployee(String key){
    return GestureDetector(
      child: Column(
        children:[
          Container(
            padding: EdgeInsets.only(top:10,bottom:10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                (employeeArrange[key] as List).length == 0 ? 
                  Text('请选择排班人员') : 
                  Container(
                    child: Row(
                      children: [
                       (employeeArrange[key] as List).length >= 1 ? Container(
                          padding: EdgeInsets.only(left:5,right:5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text((employeeArrange[key] as List)[0]['nickname'],style: TextStyle(color: Colors.white,fontSize: 11)),
                        ):Container(),
                        SizedBox(width: 3),
                        (employeeArrange[key] as List).length >= 2 ? Container(
                          padding: EdgeInsets.only(left:5,right:5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text((employeeArrange[key] as List)[1]['nickname'],style: TextStyle(color: Colors.white,fontSize: 11)),
                        ):Container(),
                        SizedBox(width: 3),
                        (employeeArrange[key] as List).length >= 3 ? Container(
                          padding: EdgeInsets.only(left:5,right:5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text((employeeArrange[key] as List)[2]['nickname'],style: TextStyle(color: Colors.white,fontSize: 11)),
                        ):Container(),
                        SizedBox(width: 3),
                        (employeeArrange[key] as List).length < 4 ?Text('') : Text('...')
                      ]
                    ),
                  ),
                GestureDetector(
                  onTap: (){
                    routePush(SelectEmploy(screen(key),(employeeArrange[key] as List))).then((res){
                      if(res != null){
                        setState(() {
                          employeeArrange[key] = res;
                        });
                      }
                    });
                  },
                  child:Container(
                    color: Colors.transparent,
                    child:Row(
                      children: <Widget>[
                        (employeeArrange[key] as List).length == 0 ?Text('请选择') : Text((employeeArrange[key] as List).length.toString()+'人'),
                        Icon(Icons.arrow_drop_down)
                      ],
                    )
                  )
                )
              ],
            ),
          ),
          Divider(color: Color.fromRGBO(0, 0, 0, 0.3), height: 1),
        ]
      ),
    );
  }

  List screen(String key){
    Map eList = {};
    for(var v in widget.employeeList){
      eList[v['id']] = v;
    }
    for(var v in widget.typeList){
      if(v['type'] != key){
        for (var e in (employeeArrange[v['type']] as List)){
           eList.remove(e['id']);
        }
      }
    }
    List res = [];
    eList.forEach((k,v){
      res.add(v);
    });
    return res;
  }

  Widget select({@required String title,@required TextEditingController selection}){
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top:5,bottom:10),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title),
              GestureDetector(
                onTap: (){
                  showSelect(selection, hoursData,minuteData,context,'请选择上班时间');
                },
                child:Container(
                  color: Colors.transparent,
                  child:Row(
                    children: <Widget>[
                      Text(selection.text),
                      Icon(Icons.arrow_drop_down)
                    ],
                  )
                )
              )
            ],
          ),
        ),
        Divider(color: Color.fromRGBO(0, 0, 0, 0.3), height: 1),
      ],
    );
  }

  void showSelect(TextEditingController controller,list,list2,context,leftName){
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CheckOne(
        name: 'name',
        data: list,
        leftName: leftName,
        data2: list2,
        onConfirm: (i) {
          controller.text = list[i.index1]['name'].toString()+':'+list[i.index2]['name'];
          setState(() {});
        },
      )
    ).then((res){
      print(res.toString()+'--------');
      if(res != null && res != '1'){
        showCupertinoModalPopup(
          context: context,
          builder: (_) => CheckOne(
            name: 'name',
            data: list,
            leftName: '请选择下班时间',
            data2: list2,
            onConfirm: (i) {
              controller.text = controller.text + '-' + list2[i.index1]['name'].toString()+':'+list2[i.index2]['name'];
              setState(() {});
            },
          )
        );
      }
    });
  }
}
class IndexBean{
  int index1;
  int index2;
  IndexBean(index1,index2){
    this.index1 = index1;
    this.index2 = index2;
  }

}
class CheckOne extends StatefulWidget {
  final List data;
  final List data2;
  final String leftName;
  final String name;
  final ValueChanged<IndexBean> onConfirm;

  const CheckOne(
      {Key key, @required this.data, @required this.data2, @required this.name, @required this.onConfirm,this.leftName})
      : super(key: key);

  @override
  _CheckOneState createState() => _CheckOneState();
}

class _CheckOneState extends State<CheckOne> {
  int now = 0;

  int now2= 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context,'1');
                      },
                      child: Text(widget.leftName ?? '取消',style: TextStyle(color: Colors.blue))),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context,'2');
                        widget.onConfirm(IndexBean(now, now2));
                      },
                      child: Text(
                        '确定',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
            Expanded(
              // height: 200,
              child: Row(
                children:[
                  Expanded(child: CupertinoPicker.builder(
                      itemExtent: 40,
                      backgroundColor: Colors.transparent,
                      onSelectedItemChanged: (int i) {
                        setState(() {
                          now = i;
                        });
                      },
                      itemBuilder: (_, i) => Container(
                            child:now==i?ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Color.fromRGBO(43, 116, 228, 1),
                                  Color.fromRGBO(25, 29, 134, 1),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              ),
                              child: Text(
                                '${widget.data[i][widget.name]}',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16,color: Colors.white),
                              )
                            ):Text(
                              widget.data[i][widget.name],
                              style: TextStyle(fontSize: 16),
                            ),
                            alignment: Alignment.center,
                          ),
                      childCount: widget.data.length,
                    )),
                    Expanded(child: CupertinoPicker.builder(
                      itemExtent: 40,
                      backgroundColor: Colors.transparent,
                      onSelectedItemChanged: (int i) {
                        setState(() {
                          now2 = i;
                        });
                      },
                      itemBuilder: (_, i) => Container(
                            child:now2==i?ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Color.fromRGBO(43, 116, 228, 1),
                                  Color.fromRGBO(25, 29, 134, 1),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              ),
                              child: Text(
                                '${widget.data2[i][widget.name]}',
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16,color: Colors.white),
                              )
                            ):Text(
                              widget.data2[i][widget.name],
                              style: TextStyle(fontSize: 16),
                            ),
                            alignment: Alignment.center,
                          ),
                      childCount: widget.data2.length,
                    ))
                ]
              ),
            )
          ],
        ),
        color: Colors.transparent,
      )
    );
  }
}

