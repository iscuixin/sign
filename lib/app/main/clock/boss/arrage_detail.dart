import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/clock/boss/arrange_type.dart';
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/route_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class ArrageDetail extends StatefulWidget {
  final DateTime dateTime;
  final List typeList;
  final List employeeList;
  ArrageDetail(this.dateTime,this.typeList,this.employeeList);
  @override
  _ArrageDetailState createState() => _ArrageDetailState();
}

class _ArrageDetailState extends State<ArrageDetail> {
  var data;
  getDetail(DateTime date){
    HttpService.get(Api.arrangeDetail+'1', context,params: {
      'date':date.toString().substring(0,19)
    }).then((res){
      setState(() {
        data =res['data'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((res){
      getDetail(widget.dateTime);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        elevation: 1,
        title: Text('${widget.dateTime.month.toString()}月排班详情'),
      ),
      body: data != null ? dataList():Container(),
    );
  }
  Widget dataList(){
    Map map = data as Map;
    List<Widget> widgets = [];
    map.forEach((k,v){
      List<Widget> list = [];
      v.forEach((key,value){
        list.add(
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  padding: EdgeInsets.only(left:10,right:10,top:5,bottom:5),
                  child: Text(key,style: TextStyle(color: Colors.black54),),
                ),
                Padding(
                  padding: EdgeInsets.only(left:10,right:10),
                  child: Wrap(
                    spacing: 10,
                    children:(value as List).map((res){
                      return Container(
                        margin: EdgeInsets.only(bottom:5),
                        padding: EdgeInsets.only(left:5,right:5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(res['nickname'],style: TextStyle(color: Colors.white,fontSize: 12),),
                      );
                    }).toList()
                  ),
                )
              ]
            ),
          )
        );
      });
      widgets.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              routePush(ArrangeType(widget.typeList,widget.employeeList,[DateTime.parse(k.toString()+" 00:00:00"),DateTime.parse(k.toString()+" 00:00:00")])).then((res){
                getDetail(widget.dateTime);
              });
            },
            child:Container(
              padding: EdgeInsets.only(left:10,right:10,top:10,bottom:10),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(k,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold)),
                  Icon(Icons.arrow_forward_ios,size: 10,color: Colors.black,)
                ],
              )
            )
          ),
          Column(
            children: list,
          )
        ],
      ));
    });
    return ListView(
      children: widgets,
    );
  }
}