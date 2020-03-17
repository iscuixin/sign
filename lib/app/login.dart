import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/clock/boss/boss_clock.dart';
import 'package:myh_shop/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/widget/MyButton.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  int now = 1;
  bool zt = false;
  String user = '';
  String pwd = '';
  bool load = false;

  @override
  void initState() {
    super.initState();
    myContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                color: c1,
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'img/logo.png',
                        width: 120.0,
                      ),
                      Text(
                        '美约会店务管理系统',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'img/bl.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                height: MediaQuery.of(context).size.height / 3,
              ),
            ],
          ),
          Container(
            color: bg2,
            height: getRange(context, type: 2) * 2 / 3,
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 2 / 3,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                now = 1;
                              });
                            },
                            child: Column(
                              children: <Widget>[
                                AnimatedDefaultTextStyle(
                                    child: Text(
                                      '主店登录',
                                    ),
                                    style: now == 1
                                        ? TextStyle(
                                            color: c1,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500)
                                        : TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0),
                                    duration: Duration(milliseconds: 200)),
                                Offstage(
                                  offstage: now == 2 ? true : false,
                                  child: Container(
                                    width: 20.0,
                                    height: 3.0,
                                    color: c1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Column(
                              children: <Widget>[
                                AnimatedDefaultTextStyle(
                                    child: Text(
                                      '店员登录',
                                    ),
                                    style: now == 1
                                        ? TextStyle(
                                            color: Colors.black, fontSize: 16.0)
                                        : TextStyle(
                                            color: c1,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500),
                                    duration: Duration(milliseconds: 200)),
                                Offstage(
                                  offstage: now == 1 ? true : false,
                                  child: Container(
                                    width: 20.0,
                                    height: 3.0,
                                    color: c1,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                now = 2;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '账号',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          TextField(
                            onChanged: (v) {
                              setState(() {
                                user = v;
                                changeZt();
                              });
                            },
                            decoration: InputDecoration(
                                hintText: '请输入登录账号',
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: myColor(236, 236, 237))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: myColor(236, 236, 237)))),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '密码',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          TextField(
                            onChanged: (v) {
                              setState(() {
                                pwd = v;
                                changeZt();
                              });
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: '请输入登录密码',
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: myColor(236, 236, 237))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: myColor(236, 236, 237)))),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: MyButton(
                        onPressed: zt
                            ? () {
                                if(!load){
                                  login();
                                }
                              }
                            : null,
                        title: '登录',
                        load: load,
                        width: getRange(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login() async {
    setState(() {
      load = true;
    });
    var rs = await post('login',
        data: {'password': pwd, 'username': user, 'type': now});
//    print(rs);
    setState(() {
      load = false;
    });
    if (rs['code'] == 1) {
      save('loginData', toString(rs['info']));
      userModel.loginData = rs['info'];
      CompanyInfo.getInfo(context);
      jump(context, 'bottom_bar');
    }
  }

  void changeZt() {
    if (pwd.length > 0 && user.length > 0) {
      zt = true;
    } else {
      zt = false;
    }
  }
}

/*class My extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height - 40;
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, h);
    Offset s = Offset(size.width / 2, size.height + 40);
    Offset e = Offset(size.width, h);
    path.quadraticBezierTo(s.dx, s.dy, e.dx, e.dy);
    path.lineTo(size.width, h);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}*/
