import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:myh_shop/model/come_shop.dart';
import 'package:myh_shop/model/count.dart';
import 'package:myh_shop/model/index.dart';
import 'package:myh_shop/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

final c1 = myColor(71, 104, 243);
final c2 = Colors.blue[600];
final bg = myColor(241, 242, 243);
final bg2 = Colors.white;
final tableBg = myColor(246, 247, 248);
final Color c3 = myColor(113, 204, 137);
final textColor = Colors.grey;
final hintColor = Colors.grey[400];
final disColor = myColor(203, 204, 205);
final double op = 0.5; //按钮透明度
final String kg = '       ';
const int begin = 1960;
const int min = 1900;
const double defRadius = 11;
const double loadPosition = 300;
SharedPreferences prefs;
final Dio dio = Dio();
//const ym = "http://localhost/backend/";
const ym = "https://myh.myhkj.cn/backend/";
const Map<String, String> methods = {
  'login': 'login/login',
  'get_count': 'Bespeak/get_count',
  'warning_detail': 'Ware/warning_detail',
  'manager': 'Member/manager',
  'get_member_list': 'Member/get_member_list',
  'guest': 'member/guest',
  'AddNew': 'member/AddNew',
  'get_advister': 'Member/get_advister',
  'viplevel': 'member/viplevel',
  'addvip': 'Member/addvip',
  'vipDetails': 'Member/vipDetails',
  'AddArrive': 'Arrive/AddArrive',
  'leave': 'Arrive/leave',
  'get_consumption': 'vipdetails/get_consumption',
  'basicinformation': 'vipdetails/basicinformation',
  'vipdetails_edit': 'vipdetails/edit',
  'ArrearsList': 'Arrears/ArrearsList',
  'DailyIncomeDetail': 'store/DailyIncomeDetail',
  'check_popularity_rate_category':
      'achievement/check_popularity_rate_category',
  'get_popularity_detail': 'Achievement/get_popularity_detail',
  'ArriveList': 'arrive/ArriveList',
  'get_role': 'authority/get_role',
  'get_access': 'authority/get_access',
  'set_jur': 'authority/Set',
  'get_staff': 'staff/get_staff',
  'get_distribution_member': 'staff/get_distribution_member',
  'print_set': 'center/print_set',
  'staff_analysis': 'Analysis/staff_analysis',
  'leaveShop': 'Arrive/leave',
  'get_goods_list': 'goods/get_goods_list',
  'goods_search': 'goods/search',
  'get_box_cate': 'goods/get_box_cate',
  'addGoods': 'goods/addGoods',
  'goodsModify': 'goods/goodsModify',
  'get_box_list': 'goods/get_box_list',
  'addbox': 'goods/addbox',
  'get_box_detail': 'goods/get_box_detail',
  'searchBox': 'goods/searchBox',
  'itemsList': 'items/itemsList',
  'getCategory': 'items/getCategory',
  'NewItem': 'items/NewItem',
  'update_items': 'items/update',
  'delItems': 'items/delItems',
  'plan_list': 'plan/plan_list',
  'del_plan': 'plan/del_plan',
  'add_plan': 'plan/add',
  'get_card': 'card/get_list',
  'addCard': 'card/addCard',
  'removerCard': 'card/removerCard',
  'updateCard': 'card/update',
  'WareList': 'ware/WareList',
  'WareIntoOutDetail': 'Ware/WareIntoOutDetail',
  'ConsumablesList': 'goods/ConsumablesList',
  'get_spec': 'goods/get_spec',
  'con_operation': 'goods/con_operation',
  'getGoods': 'commodity/getGoods',
  'change': 'commodity/change',
  'trashData': 'Commodity/trashData',
  'backData': 'Commodity/backData',
  'delData': 'Commodity/delData',
  'getDetails': 'Consume/getDetails',
  'index_detail': 'analysis/index_detail',
  'buy_detail_list': 'analysis/buy_detail_list',
  'consumed_detail_list': 'analysis/consumed_detail_list',
  'get_member_wages': 'staff/get_member_wages',
  'get_order': 'member/get_order',
  'get_debt_detail': 'analysis/get_debt_detail',
  'get_category': 'Analysis/get_category',
  'get_one_debt': 'Analysis/get_one_debt',
  'addInit': 'staff/addInit',
  'addstaff': 'staff/addstaff',
  'staffDetail': 'Staff/staffDetail',
  'StaffLeave': 'Staff/leave',
  'staffWages': 'staff/wages',
  'getWagesInfo': 'staff/getWagesInfo',
  'updatePageDetail': 'staff/updatePageDetail',
  'raise_edit_details': 'staff/raise_edit_details',
  'StaffRaise': 'Staff/raise',
  'get_order_detail': 'member/get_order_detail',
  'CancelOrder': 'member/CancelOrder',
  'refund_order': 'member/refund_order',
  'edit_time': 'staff/edit_time',
  'ModifyPassword': 'center/ModifyPassword',
  'ConsumeEntry': 'Consume/entry',
  'buygoods': 'buy/buygoods',
  'buyth': 'buy/buyth',
  'buyitems': 'buy/buyitems',
  'buyWear': 'buy/buyWear',
  'wear_purchase': 'buy/wear_purchase',
  'buycard': 'buy/buycard',
  'buyplan': 'buy/buyplan',
  'BirthdayDetail': 'member/BirthdayDetail',
  'memberTotal': 'member/total',
  'getConsume': 'store/getConsume',
  'consumeDetail': 'store/consumeDetail',
  'consumeRefund': 'store/consumeRefund',
  'toStoreDetail': 'member/toStoreDetail',
  'LostDetail': 'member/LostDetail',
  'UnTimeDetail': 'member/UnTimeDetail',
  'BespeakDetail': 'Bespeak/BespeakDetail',
  'not_raise_operation': 'achievement/not_raise_operation',
  'get_day_achievement': 'achievement/get_day_achievement',
  'raise_detail_operation': 'achievement/raise_detail_operation',
  'get_per_detail': 'Achievement/get_per_detail',
  'performance_fei_details': 'Achievement/performance_fei_details',
  'get_branch': 'Center/get_branch',
  'switch_store': 'Center/switch_store',
  'get_underwear': 'goods/get_underwear',
  'underwear_operation': 'Goods/underwear_operation',
  'get_under_detail': 'goods/get_under_detail',
  'goods_manager': 'Ware/goods_manager',
  'StockOperation': 'Ware/StockOperation',
  'get_record_detail': 'Ware/get_record_detail',
  'get_transfer_goods': 'Ware/get_transfer_goods',
  'couponGetList': 'coupon/getList',
  'CouponOperation': 'coupon/CouponOperation',
  'couponDetails': 'coupon/details',
  'modify_send_balance': 'Member/modify_send_balance',
  'AloneArrears': 'member/AloneArrears',
  'HaveCoupon': 'member/HaveCoupon',
  'send_coupon': 'Member/send_coupon',
  'MemberBoxItemsM': 'Member/MemberBoxItemsM',
  'memberBoxItemsList': 'Member/memberBoxItemsList',
  'MemberBoxItemsDel': 'Member/MemberBoxItemsDel',
  'HaveProductList': 'Member/HaveProductList',
  'memberCardList': 'Member/memberCardList',
  'modify_member_card_details': 'Member/modify_member_card_details',
  'del_card': 'Member/del_card',
  'MemberGetNeed': 'Member/getNeed',
  'addNeed': 'member/addNeed',
  'delNeed': 'member/delNeed',
  'IntegralRecord': 'member/IntegralRecord',
  'ware_allot': 'Ware/ware_allot',
  'transfer_operation': 'Ware/transfer_operation',
  'getUn': 'goods/getUn',
  'getTh': 'goods/getTh',
  'getHc': 'goods/getHc',
  'getCp': 'goods/getCp',
  'pd': 'goods/pd',
  'pdLogs': 'goods/pdLogs',
  'get_ranking': 'goods/get_ranking',
  'OldEntry': 'Member/OldEntry',
  'get_cate': 'Member/get_cate',
  'check_entry_name': 'Member/check_entry_name',
  'get_healthy_detail': 'Healthy/get_healthy_detail',
  'HealthyAdd': 'Healthy/add',
  'HealthSearch': 'Healthy/HealthSearch',
  'RechargeAccount': 'buy/RechargeAccount',
  'RechargeRecord': 'Member/RechargeRecord',
  'RechargeCard': 'buy/RechargeCard',
  'saveCard': 'buy/saveCard',
  'get_pay_detail': 'buy/get_pay_detail',
  'save_commission': 'buy/save_commission',
  'change_percentage': 'buy/change_percentage',
  'consume_print': 'buy/consume_print',
  'prescrip_detail': 'Healthy/prescrip_detail',
  'prescription_detail': 'Healthy/prescription_detail',
  'HealthyModify': 'Healthy/modify',
  'HealthyDel': 'Healthy/del',
  'guest_operation': 'member/guest_operation',
  'get_arrival_member': 'member/get_arrival_member',
  'get_member_surplus': 'member/get_member_surplus',
  'DelMember': 'Member/DelMember',
  'check_arrears': 'Member/check_arrears',
  'supp_detail': 'arrears/supp_detail',
};
final UserModel userModel = UserModel();
final ComeShopModel comeShopModel = ComeShopModel();
final CountModel countModel = CountModel();
final IndexModel indexModel = IndexModel();
BuildContext myContext;

void launcherTel(String tel) async {
  String url = 'tel:+' + tel;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    tip(myContext, '未知错误');
  }
}

Color myColor(r, g, b, {o = 1.0}) {
  return Color.fromRGBO(r, g, b, o);
}

void back(BuildContext context) async {
  Navigator.pop(context);
}

Future<dynamic> jump(BuildContext context, String name) async {
  return Navigator.pushNamed(context, name);
}

Future<dynamic> jump2(BuildContext context, Widget w) async {
  return Navigator.push(context, MaterialPageRoute(builder: (_) => w));
}

double getRange(BuildContext context, {type = 1}) {
  if (type == 1) {
    return MediaQuery.of(context).size.width;
  }
  if (type == 2) {
    return MediaQuery.of(context).size.height;
  }
  if (type == 3) {
    return MediaQuery.of(context).padding.top;
  }
  if (type == 4) {
    return MediaQuery.of(context).padding.bottom;
  }
  return 0;
}

String getImg(String name, {String e = 'png'}) {
  return 'img/' + name + '.' + e;
}

Widget circularImg(String url, double w, {t = 1}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(w / 2),
    child: t == 1
        ? CachedNetworkImage(
            imageUrl: url,
            height: w,
            width: w,
          )
        : Image.asset(
            getImg(
              'people',
            ),
            width: w,
          ),
  );
}

Widget backButton(BuildContext context, {Color color = Colors.black}) {
  return IconButton(
      icon: Icon(
        Icons.keyboard_arrow_left,
        color: color,
      ),
      onPressed: () => back(context));
}

Widget bottom(BuildContext context, {double height, Color color}) {
  return Container(
    color: color ?? Colors.transparent,
    height: height ?? getRange(context, type: 4),
  );
}

Widget priceWidget(String price) {
  return RichText(
      text: TextSpan(
          text: '¥',
          style:
              TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: c1),
          children: [
        TextSpan(text: price, style: TextStyle(fontSize: 15)),
      ]));
}

Future<bool> save(key, String value) async {
  prefs = await SharedPreferences.getInstance();
  return await prefs.setString(key, value);
}

dynamic getData(key) async {
  prefs = await SharedPreferences.getInstance();
  return await prefs.get(key);
}

Future<bool> del(key) async {
  prefs = await SharedPreferences.getInstance();
  return await prefs.remove(key);
}

dynamic post(String m, {Map<String, dynamic> data, int t = 0}) async {
  dio.options.baseUrl = ym;
  if (m == 'login') {
    dio.options.queryParameters = {'source': 'myh_app'};
  } else {
    dio.options.queryParameters = {
      'source': 'myh_app',
      'user': toString(userModel.loginData)
    };
    if (t != 0) {
      dio.options.queryParameters['id'] = t;
    }
  }
  /*Response rs = await dio.post(methods[m], data: data);
  print(rs.data);
  return null;*/
  try {
    Response rs = await dio.post(methods[m], data: data);
    var jg = rs.data;
    if (jg is String) {
      jg = formData(rs.data);
    }
    if (jg is List) {
      return jg;
    } else {
      if (jg['msg'] != null) {
        tip(myContext, jg['msg'], type: jg['code'] == -10 ? 2 : 1);
      } else if (jg['code'] == -1) {
        if (jg['info'] != null) {
          tip(myContext, jg['info'], type: jg['code'] == -10 ? 2 : 1);
        } else {
          if (jg['error'] == null) {
            tip(myContext, jg['errorMsg'], type: jg['code'] == -10 ? 2 : 1);
          } else {
            tip(myContext, jg['error'], type: jg['code'] == -10 ? 2 : 1);
          }
        }
      }
    }
    return jg;
  } catch (e) {
    tip(myContext, '请求出错');
    return null;
  }
}

dynamic get(String m, {Map<String, dynamic> data}) async {
  dio.options.baseUrl = ym;
  if (m == 'login') {
    dio.options.queryParameters = {'source': 'myh_app'};
  } else {
    dio.options.queryParameters = {
      'source': 'myh_app',
      'user': toString(userModel.loginData)
    };
  }
  /*Response rs = await dio.get(methods[m], queryParameters: data);
  print(rs.data);
  return null;*/
  try {
    Response rs = await dio.get(methods[m], queryParameters: data);
    var jg = rs.data;
    if (jg is String) {
      jg = formData(rs.data);
    }
    if (jg['msg'] != null) {
      tip(myContext, jg['msg'], type: jg['code'] == -10 ? 2 : 1);
    } else if (jg['code'] == -1) {
      if (jg['info'] != null) {
        tip(myContext, jg['info'], type: jg['code'] == -10 ? 2 : 1);
      } else {
        if (jg['error'] == null) {
          tip(myContext, jg['errorMsg'], type: jg['code'] == -10 ? 2 : 1);
        } else {
          tip(myContext, jg['error'], type: jg['code'] == -10 ? 2 : 1);
        }
      }
    }
    return jg;
  } catch (e) {
    //print(e.toString() + '前端');
    tip(myContext, '请求出错');
    return null;
  }
}

void tip(BuildContext context, String msg,
    {Widget title, Widget content, int type = 1}) {
  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: title ??
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
            content: content ?? Text(msg ?? ''),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  if (type == 2) {
                    back(context);
                  }
                  if (Navigator.canPop(context)) {
                    back(context);
                  } else {
//                    SystemNavigator.pop();
                  }
                },
              ),
            ],
          ));
}

void ok(BuildContext context, String msg,
    {Widget title, Widget content, int type = 1}) {
  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: title ??
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
            content: content ?? Text(msg ?? ''),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  if (type == 1) {
                    back(context);
                  }
                  back(context);
                },
              ),
            ],
          ));
}

String toString(Map data) {
  return jsonEncode(data);
}

dynamic formData(dynamic data) {
  return jsonDecode(data);
}

Widget loading({double radius = 13}) =>
    CupertinoActivityIndicator(radius: radius);

Future<dynamic> addArrive(mid, room) async {
  var rs = await post('AddArrive', data: {'mid': mid, 'room': room});
  return rs;
}

Widget end(BuildContext context) => Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: getRange(context, type: 4)),
      child: Text(
        '没有数据了',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.center,
    );

Future<bool> showAlert(BuildContext context, content,
    {String title = '提示'}) async {
  return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            content: Text(content),
            title: Text(title),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () async {
                  return Navigator.pop(context, false);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  '确定',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  return Navigator.pop(context, true);
                },
              ),
            ],
          ));
}

void getComeShop() async {
  var rs = await get('ArriveList');
  if (rs != null) {
    if (rs['code'] == 1) {
      comeShopModel.data = rs['list'];
    }
    //print(rs);
  }
}

void getCountData({String start = '', end = ''}) async {
  var rs = await get('index_detail', data: {
    'start': start,
    'end': end,
  });
  //print(rs);
  if (rs != null) {
    if (rs['code'] == 1) {
      countModel.cateData = rs['res']['cate_data'];
      countModel.cateSumData = rs['res']['cate_sum_data'];
      countModel.consumeData = rs['res']['consume_data'];
      countModel.consumeTotal =
          double.parse(rs['res']['consume_total'].toString());
      countModel.payTotal = double.parse(rs['res']['pay_total'].toString());
      countModel.payTypeData = rs['res']['pay_type_data'];
      countModel.sendData = rs['res']['send_data'];
    }
  }
}

void logout(BuildContext context) async {
  del('loginData');
  jump(context, 'login');
}

String getName(int type, Map d) {
  //print(type);
  String name = '';
  if (type == 1) {
    name = d['goods_name'];
  } else if (type == 2) {
    name = d['box_name'];
  } else if (type == 3) {
    name = d['pro_name'];
  } else if (type == 4) {
    name = d['name'];
  } else if (type == 5) {
    name = d['card_name'];
  } else if (type == 6) {
    name = d['name'];
  }
  return name;
}

void getWare() async {
  var rs = await get('warning_detail');
  if (rs != null) {
    if (rs['code'] == 1) {
      indexModel.ware = rs['res']['ware_details'];
      //print(rs);
    } else {
      tip(myContext, rs['error']);
    }
  }
}

void getManage() async {
  var rs = await get('manager');
  if (rs != null) {
    if (rs['code'] == 0) {
      indexModel.data = rs['data'];
    } else {
      tip(myContext, rs['msg']);
    }
  }
}
