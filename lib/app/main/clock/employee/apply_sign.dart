import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myh_shop/util/api.dart';
import 'package:myh_shop/util/http_service.dart';
import 'package:myh_shop/util/toast_util.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:image_picker/image_picker.dart';

class ApplySign extends StatefulWidget {
  final String applySignDate;
  final String signTime;
  final int signSection;
  final int applyId;
  ApplySign(this.applySignDate,this.signTime,this.signSection,this.applyId);
  @override
  _ApplySignState createState() => _ApplySignState();
}

class _ApplySignState extends State<ApplySign> {

  DateTime date;

  List img = [
    null,
  ];

  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        date = DateTime.parse(widget.applySignDate+widget.signTime.substring(11,19));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('补卡申请'),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left:15,bottom:8,top:8,right:15),
        color: Colors.white,
        height:60,
        child: GestureDetector(
          onTap: (){
            List list = [];
            for(var i in img){
              if(i != null){
                list.add(i);
              }
            }
            HttpService.post(Api.applySign, context,params: {
              'applyId':widget.applyId,
              'applyDate':widget.applySignDate+'00:00:00',
              'signSection':widget.signSection,
              'applyPics':list,
              'reason':_textEditingController.text != null && _textEditingController.text.length != 0 ? _textEditingController.text:'未填写'
            },showLoading: true).then((res){
              var rs = json.decode(res.toString());
              if(rs['data']){
                ToastUtil.toast('提交成功');
                Navigator.pop(context);
              }else{
                ToastUtil.toast('提交失败');
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8)
            ),
            alignment: Alignment.center,
            child: Text('提交',style: TextStyle(color: Colors.white),),
          ),
        )
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top:10,bottom: 10),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:15,right:15,bottom: 5),
            child: Text(
              widget.applySignDate +','+getWeekDay(DateTime.parse(widget.applySignDate+'00:00:00'))+','+(widget.signSection == 0? '上班时间' : '下班时间')+widget.signTime.substring(11,16),
              style: TextStyle(color: Colors.black54,fontSize: 13),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left:15,right:15,top: 10,bottom: 10),
            color: Colors.white,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text('补卡时间',style: TextStyle(color: Colors.black54)),
                date != null ? Text(date.toString().substring(0,16)) : Container()
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
                  child: TextField(
                    autofocus: false,
                    controller: _textEditingController,
                    cursorWidth: 1,
                    cursorColor: Colors.black54,
                    keyboardType:TextInputType.text,
                    maxLines: 3,
                    style: TextStyle(fontSize: 14,textBaseline: TextBaseline.alphabetic),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 3),
                      border: InputBorder.none,
                      hintText: "请输入"
                    ),
                  ),
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
                  children: img.map((v) => _item(v)).toList(),
                )
              ]
            )
          ),
        ],
      ),
    );
  }

  //选取图片
  Future<File> getImage({int t = 1}) async {
    File file = await ImagePicker.pickImage(
        source: t == 1 ? ImageSource.gallery : ImageSource.camera);
    if (file != null) {
      return file;
    }
    return null;
  }

  Widget _item(dynamic v) {
    if (v == null) {
      return GestureDetector(
        onTap: (){
          if(img.length < 4){
            getImage().then((res){
              uploadImg(res);
            });
          }else{
            ToastUtil.toast('最多上传三张图片哦');
          }
        },
        child: Container(
          width: 70,
          height: 70,
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(158, 159, 160, 1)),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(
            Icons.add,
            color: Color.fromRGBO(158, 159, 160, 1),
          ),
        ),
      );
    }
    if(v is File){
      return Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Stack(
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              child: Image.file(
                v,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
                right: 0,
                child: CircleAvatar(
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                  backgroundColor: Colors.red,
                  radius: 10,
                ))
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(v, width:70, height:70,fit: BoxFit.cover,),
          ),
          Positioned(
              right: 0,
              child: GestureDetector(
                onTap: (){
                  int i = 0;
                  for(var x in img) {
                    if(x==v){
                      img.removeAt(i);
                      break;
                    }
                    i++;
                  }
                  setState(() {

                  });
                },
                child: CircleAvatar(
                  child: Icon(
                    Icons.close,
                    size: 15,
                  ),
                  backgroundColor: Colors.red,
                  radius: 10,
                ),
              ))
        ],
      ),
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

  void uploadImg(File file) async {
    HttpService.uploadImg(file,context).then((rs){
      if(rs!=null){
        setState(() {
          img.add(rs['data']);
        });
      }
    });
  }
}