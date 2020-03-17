import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart' as prefix0;
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class SetSignDefault extends StatefulWidget {

  List list;

  Map employee;

  SetSignDefault(this.list,{this.employee});
  @override
  _SelectEmployState createState() => _SelectEmployState();
}

class _SelectEmployState extends State<SetSignDefault> {
  var role = {};
  int id = -1;
  getRoleList(){
    HttpService.get(Api.roleList, context).then((res){
      setState(() {
        role = res['data'];
      });
    });
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      getRoleList();
      if(widget.employee != null){
        setState(() {
          id = widget.employee['id'];
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('选择员工'),
        elevation: 1,
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              if(id == -1){
                ToastUtil.toast('请选择员工');
                return;
              }
              HttpService.put(Api.setDefaulSign+prefix0.userModel.loginData['sid'].toString(), context,params: {
                'signDefault':id
              },showLoading: true).then((val){
                var res = json.decode(val.toString());
                if(res['data']){
                  ToastUtil.toast('保存成功');
                  prefix0.userModel.loginData['id'] = id;
                  Navigator.pop(context);
                }else{
                  ToastUtil.toast('保存失败');
                }
              });
            },
            child: Text('确定',style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: widget.list.length ==0 || role.length == 0?Container(
        child: Center(child: Text('暂无员工可排班'),),
      ) : ListView(
        physics: BouncingScrollPhysics(),
        children: widget.list.map((res){
          return GestureDetector(
            onTap: (){
              setState(() {
                id = res['id'];
              });
            },
            child:Container(
              margin: EdgeInsets.only(bottom:1),
              color: Colors.white,
              padding: EdgeInsets.only(left:20,right:20,top:15,bottom:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'http://image.biaobaiju.com/uploads/20180803/23/1533308847-sJINRfclxg.jpeg'
                        ),
                      ),
                      SizedBox(width:5),
                      Text(res['nickname']),
                      SizedBox(width:5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left:5,right:5,bottom: 1),
                        child:Text(role[res['roleId'].toString()],style: TextStyle(color: Colors.white,fontSize: 10))
                      )
                    ],
                  ),
                  Icon(
                    res['id'] == id? Icons.check_circle:Icons.check_circle_outline,
                    color: res['id'] == id ? Colors.blue:Colors.black26,
                    size: 18,
                  )
                ],
              ),
            )
          );
        }).toList(),
      ),
    );
  }

}