import 'package:flutter/material.dart';
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class SelectEmploy extends StatefulWidget {

  List list;

  List select;

  SelectEmploy(this.list,this.select);
  @override
  _SelectEmployState createState() => _SelectEmployState();
}

class _SelectEmployState extends State<SelectEmploy> {
  var role = {};
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
              Navigator.pop(context,widget.select);
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
              if(!check(widget.select,res)){
                setState(() {
                  widget.select.add(res);
                });
              }else{
                for(var x in widget.select){
                  if(x['id'] == res['id']){
                     setState(() {
                       widget.select.remove(x);
                    });
                  }
                } 
               
              }
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
                    check(widget.select,res) ? Icons.check_circle:Icons.check_circle_outline,
                    color:check(widget.select,res) ? Colors.blue:Colors.black26,
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

  bool check(List list,var data){
    bool res = false;
    for(var v in list){
      if(v['id'] == data['id']){
        res = true;
      }
    }
    return res;
  }
}