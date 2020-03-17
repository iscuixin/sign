import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class TimeSet extends StatefulWidget {
  final List list;
  TimeSet({@required this.list});
  @override
  _TimeSetState createState() => _TimeSetState();
}

class _TimeSetState extends State<TimeSet> {

  List list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((res){
      setState(() {
        list = [
          {'title':'星期一','isSet':widget.list.indexOf("1") != -1,'val':'1'},
          {'title':'星期二','isSet':widget.list.indexOf("2") != -1,'val':'2'},
          {'title':'星期三','isSet':widget.list.indexOf("3") != -1,'val':'3'},
          {'title':'星期四','isSet':widget.list.indexOf("4") != -1,'val':'4'},
          {'title':'星期五','isSet':widget.list.indexOf("5") != -1,'val':'5'},
          {'title':'星期六','isSet':widget.list.indexOf("6") != -1,'val':'6'},
          {'title':'星期日','isSet':widget.list.indexOf("7") != -1,'val':'7'},
        ]; 
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MyAppBar(
        elevation: 1,
        title: Text('考勤时间'),  
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              List param = [];
              for(var v in list){
                if(v['isSet']){
                  param.add(v['val']);
                }
              }
              HttpService.post(Api.setWorkDays, context,
              params: {
                'companyId':prefix0.userModel.loginData['sid'],
                'workDays':param
              },showLoading: true
              ).then((val){
                var res = json.decode(val.toString());
                if(res['data']){
                  ToastUtil.toast('保存成功');
                }else{
                  ToastUtil.toast('保存失败,请稍后再试');
                }
              });
            }, 
            child: Text('保存',style: TextStyle(color: Colors.blue))
          )
        ],      
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: list.map((res){
          return GestureDetector(
            onTap: (){
              int index = list.indexOf(res);
              setState(() {
                list[index]['isSet'] = !list[index]['isSet'];
              });
            },
            child: Container(
              margin: EdgeInsets.only(bottom:0.7),
              color: Colors.white,
              padding: EdgeInsets.only(left:20,right:20,top:15,bottom:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text(res['title']),
                  Icon(
                    res['isSet']?Icons.check_circle:Icons.check_circle_outline,
                    color:res['isSet']?Colors.blue:Colors.black26,
                    size: 18,
                  )
                ]
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}