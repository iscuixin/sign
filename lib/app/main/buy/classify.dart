import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/buy/buy.dart';
import 'package:myh_shop/app/main/recharge/manage.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class Classify extends StatelessWidget {
  final int id;

  Classify(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('消费类型'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Image.asset(
                getImg('2.0.2_03'),
                width: 20,
                height: 20,
              ),
            ),
            title: Text('产品'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(context, Buy(id));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Image.asset(
                getImg('2.0.2_06'),
                width: 20,
                height: 20,
              ),
            ),
            title: Text('套盒'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(
                  context,
                  Buy(
                    id,
                    type: 2,
                  ));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Image.asset(
                getImg('2.0.2_08'),
                width: 20,
                height: 20,
              ),
            ),
            title: Text('项目'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(
                  context,
                  Buy(
                    id,
                    type: 3,
                  ));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Image.asset(
                getImg('ny'),
                width: 20,
                height: 20,
              ),
            ),
            title: Text('内衣'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(
                  context,
                  Buy(
                    id,
                    type: 4,
                  ));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Image.asset(
                getImg('2.0.2_10'),
                width: 20,
                height: 20,
              ),
            ),
            title: Text('卡项'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(
                  context,
                  Buy(
                    id,
                    type: 5,
                  ));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Image.asset(
                getImg('2.0.2_12'),
                width: 20,
                height: 20,
              ),
            ),
            title: Text('方案'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(
                  context,
                  Buy(
                    id,
                    type: 6,
                  ));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Image.asset(
                getImg('2.0.2_14'),
                width: 20,
                height: 20,
              ),
            ),
            title: Text('充值'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              jump2(context, RechargeManage(id));
            },
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
