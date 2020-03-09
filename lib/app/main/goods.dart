import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class Goods extends StatelessWidget {
  final List list = [
    {'img': '21_04', 'text': '产品管理', 'id': 1},
    {'img': '21_06', 'text': '套盒管理', 'id': 2},
    {'img': '21_08', 'text': '项目管理', 'id': 3},
    {'img': '21_13', 'text': '方案管理', 'id': 4},
    {'img': '21_14', 'text': '卡项管理', 'id': 5},
    {'img': 'ny2', 'text': '内衣管理', 'id': 12},
    {'img': '21_15', 'text': '仓库管理', 'id': 6},
    {'img': '21_19', 'text': '优惠券', 'id': 7},
    {'img': '21_20', 'text': '院装消耗', 'id': 8},
    {'img': '21_21', 'text': '回收站', 'id': 9},
    {'img': '21_25', 'text': '预约推荐', 'id': 10},
    {'img': '21_26', 'text': '排行榜', 'id': 11},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg2,
      child: Column(//brightness
        children: <Widget>[
          Container(
            height: 130 + getRange(context, type: 3),
            color: c1,
            child: Image.asset(
              getImg('2_01', e: 'jpg',),
              height: 130,
              fit: BoxFit.fill,
              width: getRange(context),
            ),
          ),
          Expanded(
              child: GridView.builder(
            primary: false,
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 20),
            itemBuilder: (BuildContext context, int index) =>
                _item(index, context),
            itemCount: list.length,
          ))
        ],
      ),
    );
  }

  Widget _item(int i, BuildContext context) => GestureDetector(
        child: Column(
          children: <Widget>[
            Image.asset(
              getImg(list[i]['img']),
              width: 60,
            ),
            Text(list[i]['text']),
          ],
        ),
        onTap: () {
          switch (list[i]['id']) {
            case 1:
              jump(context, 'cp_manage');
              break;
            case 2:
              jump(context, 'box_manage');
              break;
            case 3:
              jump(context, 'item_manage');
              break;
            case 4:
              jump(context, 'plan_manage');
              break;
            case 5:
              jump(context, 'card_manage');
              break;
            case 6:
              jump(context, 'ware_list');
              break;
            case 7:
              jump(context, 'coupon');
              break;
            case 8:
              jump(context, 'consumables');
              break;
            case 9:
              jump(context, 'recycle_bin');
              break;
            case 10:
              jump(context, 'bespeak');
              break;
            case 11:
              jump(context, 'rank');
              break;
            case 12:
              jump(context, 'clothes_manage');
              break;
          }
        },
      );
}
