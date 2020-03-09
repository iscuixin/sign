import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart' as prefix0;

class DialogUtil{
  static Future showEnterDialog(BuildContext context,
  {String content,String leftButton ='确定',String rightButton = '取消',Function leftFunc,Function rightFunc}) async {
    var select = await showDialog(
      context:context,
      builder: (context){
        return GestureDetector(
          onTap: () => Navigator.pop(context,false),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                height: 150,
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: prefix0.bg,width: 1)),
                      ),
                      padding: EdgeInsets.only(left: 10,right:10),
                      height: 110,
                      child: Center(child: Text(content),),
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(color: prefix0.bg,width: 1)),
                              color: Colors.transparent,
                            ),
                            width: MediaQuery.of(context).size.width * 0.39,
                            height: 40,
                            child: Center(child: Text(leftButton)),
                          ),
                          onTap: leftFunc ?? () => Navigator.pop(context,true)
                        ),
                        GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.39,
                            color: Colors.transparent,
                            height:40,
                            child: Center(child: Text(rightButton,style: TextStyle(color: Colors.red))),
                          ),
                          onTap: rightFunc ?? () => Navigator.pop(context,false)
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
    if(select != null){
      return select;
    }
  }
}