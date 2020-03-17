import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/clock/employee/apply_datail.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/route_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class ApplyList extends StatefulWidget {
  String id;
  ApplyList(this.id);
  @override
  _ApplyListState createState() => _ApplyListState();
}

class _ApplyListState extends State<ApplyList> {

  var data = [];
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_){
      getData(DateTime.now());
    });
    super.initState();
  }
  getData(DateTime date){
    HttpService.get(Api.applyList+widget.id, context,params: {
      'date':date.toString().substring(0,19)
    }).then((res){
      setState(() {
        data = res['data'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        elevation: 1,
        title: Text('补卡申请'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: data.map((res){
          print(res.toString());
          return GestureDetector(
            onTap: (){
              routePush(ApplyDetail(res['applySignDate'].toString()+' ',
              res['applySection']==0? res['upTime']:res['downTime'],res['applySection'],res['applyId'],isBoss: true,)).then((res){
                getData(DateTime.now());
              });
            },
            child: Container(
              padding: EdgeInsets.only(top:15,bottom:15,left:15,right:15),
              margin: EdgeInsets.only(top:0.5,bottom: 0.5),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'http://image.biaobaiju.com/uploads/20180803/23/1533308847-sJINRfclxg.jpeg'
                        ),
                      ),
                      SizedBox(width:10),
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children:[
                          Text(res['nickname']),
                          Text(res['applySignDate'].toString()+(res['applySection'] == 0 ? '  上午':'  下午'),style: TextStyle(color: Colors.black45,fontSize: 13),)
                        ]
                      )
                    ]
                  ),
                  Text(res['checkStatus'] == 0 ? '待审核': res['checkStatus'] == 1 ? '审核通过' : '审核失败',
                    style: TextStyle(
                      color: res['checkStatus'] == 0 ? Colors.cyan: res['checkStatus'] == 1 ? Colors.blue : Colors.red
                    ),
                  )
                ]
              )
            ),
          );
        }).toList()
      ),
    );
  }
}