import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class ApplyDetail extends StatefulWidget {
  final String date;
  final String signTime;
  final int signSection;
  final int applyId;
  final bool isBoss;
  ApplyDetail(this.date,this.signTime,this.signSection,this.applyId,{this.isBoss = false});
  @override
  _ApplyDetailState createState() => _ApplyDetailState();
}

class _ApplyDetailState extends State<ApplyDetail> {

  var data;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((res){
      HttpService.get(Api.applyDetail+widget.applyId.toString(), context,params: {'date':widget.date+'00:00:00','section':widget.signSection}).then((res){
        setState(() {
          data = res['data'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('补卡详情'),
      ),
      bottomNavigationBar: widget.isBoss && data != null && data['checkStatus'] == 0? Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                HttpService.put(Api.checkApply+data['id'].toString(), context,params: {'checkStatus':2}).then((res){
                  var rs = json.decode(res.toString());
                  if(rs['data']){
                    ToastUtil.toast('审核成功');
                    HttpService.get(Api.applyDetail+widget.applyId.toString(), context,params: {'date':widget.date+'00:00:00','section':widget.signSection}).then((res){
                      setState(() {
                        data = res['data'];
                      });
                    });
                  }else{
                    ToastUtil.toast('审核失败');
                  }
                });
              },
              child:Container(
                height: 60,
                width: MediaQuery.of(context).size.width/2,
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.clear,color: Colors.red,),
                    Text('拒绝')
                  ],
                )
              )
            ),
            GestureDetector(
              onTap: (){
                HttpService.put(Api.checkApply+data['id'].toString(), context,params: {'checkStatus':1}).then((res){
                  var rs = json.decode(res.toString());
                  if(rs['data']){
                    ToastUtil.toast('审核成功');
                    HttpService.get(Api.applyDetail+widget.applyId.toString(), context,params: {'date':widget.date+'00:00:00','section':widget.signSection}).then((res){
                      setState(() {
                        data = res['data'];
                      });
                    });
                  }else{
                    ToastUtil.toast('审核失败');
                  }
                });
              },
              child:Container(
                height: 60,
                width: MediaQuery.of(context).size.width/2,
                alignment: Alignment.center,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.check,color: Colors.blue,),
                    Text('通过')
                  ],
                )
              )
            )
          ],
        ),
      ):null,
      body: data != null ?ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top:10,bottom: 10),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:15,right:15,bottom: 5),
            child: Text(
              widget.date +','+getWeekDay(DateTime.parse(widget.date+'00:00:00'))+','+(widget.signSection == 0 ? '上班时间':'下班时间')+widget.signTime.substring(11,16),
              style: TextStyle(color: Colors.black54,fontSize: 13),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left:15,right:15,top: 10,bottom: 10),
            color: Colors.white,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text('审核状态',style: TextStyle(color: Colors.black54)),
                Text(data['checkStatus'] == 0 ? '等待审核': data['checkStatus'] == 1 ? '审核成功':'审核失败')
              ]
            )
          ),
          SizedBox(height:15),
          Container(
            padding: EdgeInsets.only(left:15,right:15,top: 10,bottom: 10),
            color: Colors.white,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text('补卡时间',style: TextStyle(color: Colors.black54)),
                Text(DateTime.parse(widget.date+widget.signTime.substring(11,19)).toString().substring(0,16))
              ]
            )
          ),
          SizedBox(height:15),
          Container(
            padding: EdgeInsets.only(left:15,right:15,top: 10,bottom: 10),
            color: Colors.white,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text('补卡理由',style: TextStyle(color: Colors.black54)),
                SizedBox(height:10),
                Container(
                  height: 100.0,
                  width: MediaQuery.of(context).size.width,
                  child: Text(data['reason'],style: TextStyle(fontSize: 13),maxLines: 5,overflow: TextOverflow.ellipsis,)
                )
              ]
            )
          ),
          SizedBox(height:15),
          Container(
            padding: EdgeInsets.only(left:15,right:15,top: 10,bottom: 10),
            color: Colors.white,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text('图片',style: TextStyle(color: Colors.black54)),
                SizedBox(height:10),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  children: data['applyPic'].toString().replaceAll('"', '').replaceAll('[', '').replaceAll(']', '').split(',').map((v){
                    return Image.network(v,height: 70,width: 70,fit: BoxFit.cover);
                  }).toList(),
                )
              ]
            )
          ),
        ],
      ) : Container(),
    );
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
}