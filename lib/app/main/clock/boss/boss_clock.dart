import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/clock/boss/arrange.dart';
import 'package:myh_shop/app/main/clock/boss/setting.dart';
import 'package:myh_shop/app/main/clock/boss/statistics.dart';
import 'package:myh_shop/app/main/clock/employee/clock.dart';
import 'package:myh_shop/util/intel_util.dart';

class BossClock extends StatefulWidget {
  @override
  _BossClockState createState() => _BossClockState();
}

class _BossClockState extends State<BossClock> {

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Image.asset('img/1341580887554_.pic_hd.jpg',width: 25),
      activeIcon: Image.asset(
        'img/1291580887374_.pic_hd.jpg',
        width: 25.0,
      ),
      title: Text('打卡'),
    ),
    BottomNavigationBarItem(
      icon: Image.asset('img/1301580887375_.pic_hd.jpg',width: 25),
      activeIcon: Image.asset(
        'img/1281580887373_.pic_hd.jpg',
        width: 25.0,
      ),
      title: Text('统计')
    ),
    BottomNavigationBarItem(
      icon: Image.asset('img/1311580887376_.pic_hd.jpg',width: 25),
      activeIcon: Image.asset(
        'img/1351580887555_.pic_hd.jpg',
        width: 25.0,
      ),
      title: Text('排班')
    ),
    BottomNavigationBarItem(
      icon: Image.asset('img/1321580887377_.pic_hd.jpg',width: 25),
      activeIcon: Image.asset(
        'img/1331580887377_.pic_hd.jpg',
        width: 25.0,
      ),
      title: Text('设置')
    )
  ];

  int currentIndex = 0;

  final List<Widget> tabBodies = [
    Clock(isBoss: true),
    Statistics(),
    Arrange(),
    Setting(),
  ];
  @override
  void initState() {
    super.initState();
    IntelUtil.getWifi();
  }

  @override
  void dispose() {
    super.dispose();
    IntelUtil.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies
      )
    );
  }
}