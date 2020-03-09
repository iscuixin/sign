import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:myh_shop/widget/MyInput.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: Text('test'),),
      body: ListView(
        children: <Widget>[
          Container(
            child: MyInput(),
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          ),
          Container(
            child: MyInput(),
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          ),
        ],
      ),
    );
  }
}

