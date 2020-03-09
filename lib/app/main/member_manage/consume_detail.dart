import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class ConsumeDetail extends StatefulWidget {
  final int id;

  ConsumeDetail(this.id);

  @override
  _ConsumeDetailState createState() => _ConsumeDetailState();
}

class _ConsumeDetailState extends State<ConsumeDetail> {
  List box;
  List card;
  List product;
  List programme;
  List project;
  List underwear;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            leading: backButton(context),
            title: Text('消费明细'),
            elevation: 0,
            bottom: PreferredSize(
                child: TabBar(
                  tabs: [
                    Tab(
                      text: '项目',
                    ),
                    Tab(
                      text: '产品',
                    ),
                    Tab(
                      text: '套盒',
                    ),
                    Tab(
                      text: '充值',
                    ),
                    Tab(
                      text: '方案',
                    ),
                    Tab(
                      text: '内衣',
                    ),
                  ],
                  unselectedLabelColor: Colors.black,
                  labelColor: c1,
                  indicatorColor: c1,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
                preferredSize: Size(getRange(context), 40)),
          ),
          body: TabBarView(children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: project != null
                  ? ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          _item(context, index, 1),
                      itemCount: project.length,
                    )
                  : Center(
                      child: loading(),
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: product != null
                  ? ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          _item(context, index, 2),
                      itemCount: product.length,
                    )
                  : Center(
                      child: loading(),
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: box != null
                  ? ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          _item(context, index, 3),
                      itemCount: box.length,
                    )
                  : Center(
                      child: loading(),
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: card != null
                  ? ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          _item(context, index, 4),
                      itemCount: card.length,
                    )
                  : Center(
                      child: loading(),
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: programme != null
                  ? ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    _item(context, index, 5),
                itemCount: programme.length,
              )
                  : Center(
                child: loading(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: underwear != null
                  ? ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    _item(context, index, 6),
                itemCount: underwear.length,
              )
                  : Center(
                child: loading(),
              ),
            ),
          ]),
        ));
  }

  Widget _item(BuildContext context, int i, int t) {
    String name = '';
    String type = '';
    String time = '';
    Map data;
    if (t == 1) {
      data = project[i];
      name = project[i]['name'];
      type = project[i]['status'] == 1 ? '消费-(买入)' : '消耗-(使用)';
      time = project[i]['time'];
    } else if (t == 2) {
      data = product[i];
      name = product[i]['name'];
      type = product[i]['status'] == 1 ? '消费-(买入)' : '消耗-(使用)';
      time = product[i]['time'];
    } else if (t == 3) {
      data = box[i];
      name = box[i]['name'];
      type = box[i]['status'] == 1 ? '消费-(买入)' : '消耗-(使用)';
      time = box[i]['time'];
    } else if (t == 4) {
      data = card[i];
      name = card[i]['name'];
      type = card[i]['status'] == 1 ? '消费-(买入)' : '消耗-(使用)';
      time = card[i]['time'];
    } else if (t == 5) {
      data = programme[i];
      name = programme[i]['name'];
      type = programme[i]['status'] == 1 ? '消费-(买入)' : '消耗-(使用)';
      time = programme[i]['time'];
    } else if (t == 6) {
      data = underwear[i];
      name = underwear[i]['name'];
      type = underwear[i]['status'] == 1 ? '消费-(买入)' : '消耗-(使用)';
      time = underwear[i]['time'];
    }
    return GestureDetector(
      onTap: (){
        showModel(data);
      },
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(time),
            trailing: Container(
              width: getRange(context) / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    type,
                    style: TextStyle(color: Colors.orange),
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          Divider(
            height: 0,
          )
        ],
      ),
    );
  }

  void showModel(Map data) {
    //print(data);
    showDialog(
        context: context,
        builder: (_) => Container(
          margin: EdgeInsets.only(
              top: getRange(context, type: 2) / 4,
              bottom: getRange(context, type: 2) / 4,
              left: 15,
              right: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Scaffold(
              backgroundColor: bg2,
              appBar: MyAppBar(
                title: Text('支付详情'),
                leading: Offstage(),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        back(context);
                      })
                ],
              ),
              body: Container(
                padding: EdgeInsets.all(15),
                color: bg2,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child: _item2('卡扣支付', '${data['card_pay']??0}')),
                        Expanded(child: _item2('余额支付', '${data['account_pay']??0}')),
                        Expanded(child: _item2('现金支付', '${data['cash_pay']??0}')),
                        Expanded(child: _item2('微信', '${data['wx_pay']??0}')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child: _item2('支付宝', '${data['zfb_pay']??0}')),
                        Expanded(child: _item2('美团', '${data['mt']??0}')),
                        Expanded(child: _item2('大众点评', '${data['dzdp']??0}')),
                        Expanded(child: _item2('收钱吧', '${data['sqb']??0}')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child: _item2('银行卡', '${data['bank']??0}')),
                        Expanded(child: _item2('优惠券', '${data['counpon']??0}')),
                        Expanded(child: _item2('合计消费', '${data['money']??0}')),
                        Expanded(child: _item2('亚索', '25.25')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _item2(String name, p) => Padding(
    padding: EdgeInsets.all(8),
    child: Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
              color: name == '亚索' ? Colors.transparent : textColor),
        ),
        Text(
          p,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: name == '亚索' ? Colors.transparent : Colors.black),
        ),
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_consumption', data: {'mid': widget.id});
    if (rs != null) {
      setState(() {
        box = rs['res']['box'];
        card = rs['res']['card'];
        product = rs['res']['product'];
        programme = rs['res']['programme'];
        project = rs['res']['project'];
        underwear = rs['res']['underwear'];
      });
    }
    //print(rs);
  }
}
