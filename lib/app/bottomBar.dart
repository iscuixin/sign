import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myh_shop/app/main/come_shop.dart';
import 'package:myh_shop/app/main/count.dart';
import 'package:myh_shop/app/main/goods.dart';
import 'package:myh_shop/app/main/index.dart';
import 'package:myh_shop/app/main/my.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/util/intel_util.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int now = 0;

  @override
  void initState() {
    super.initState();
    myContext = context;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: now,
        children: <Widget>[
          Index(),
          Goods(),
          ComeShop(),
          Count(),
          My(),
        ],
      ),
      bottomNavigationBar: Container(
        child: CupertinoTabBar(
            backgroundColor: Colors.white,
            activeColor: c1,
            currentIndex: now,
            onTap: (i) {
              setState(() {
                now = i;
              });
              if(i==3){
                getCountData();
              }
              if(i==0){
                getWare();
                getManage();
              }
            },
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'img/1_003.png',
                    width: 25.0,
                  ),
                  activeIcon: Image.asset(
                    'img/1_49.png',
                    width: 25.0,
                  ),
                  title: Text('首页')),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'img/1_51_02.png',
                    width: 25.0,
                  ),
                  activeIcon: Image.asset(
                    'img/1_005.png',
                    width: 25.0,
                  ),
                  title: Text('商品')),
              BottomNavigationBarItem(
                  icon: Offstage(
                    offstage: true,
                  ),
                  title: Text('到店管理')),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'img/1_54.png',
                    width: 25.0,
                  ),
                  activeIcon: Image.asset(
                    'img/1_007.png',
                    width: 25.0,
                  ),
                  title: Text('统计')),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'img/1_56.png',
                    width: 25.0,
                  ),
                  activeIcon: Image.asset(
                    'img/1_009.png',
                    width: 25.0,
                  ),
                  title: Text('我的')),
            ]),
        height: 50.0 + MediaQuery.of(context).padding.bottom,
        color: Colors.black,
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              now = 2;
            });
            getComeShop();
          },
          backgroundColor: Colors.white,
          elevation: 6,
          child: Image.asset(
            'img/1_46.png',
            width: 50.0,
          ),
        ),
        width: 60.0,
        height: 60.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
