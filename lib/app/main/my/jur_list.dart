import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/my/jur_edit.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class JurList extends StatefulWidget {
  @override
  _JurListState createState() => _JurListState();
}

class _JurListState extends State<JurList> {
  List list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg2,
      appBar: MyAppBar(
        title: Text('权限管理'),
      ),
      body: list != null
          ? ListView.builder(
              itemBuilder: (_, i) => _item(i),
              itemCount: list.length,
            )
          : Center(
              child: loading(),
            ),
    );
  }

  Widget _item(int i) {
    String img = '';
    if (i == 0) {
      img = '5.1_03';
    } else if (i == 1) {
      img = '5.1_06';
    } else if (i == 2) {
      img = '5.1_08';
    } else if (i == 3) {
      img = '5.1_10';
    } else if (i == 4) {
      img = '5.1_12';
    } else if (i == 5) {
      img = '5.1_14';
    }
    return GestureDetector(
      child: Column(
        children: <Widget>[
          ListTile(
            //leading: Image.asset(getImg(img), width: 20, height: 20,),
            title: Text('${list[i]['role_name']}'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
        ],
      ),
      onTap: () {
        jump2(context, JurEdit(list[i]['id']));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_role');
    if (rs != null) {
      //print(rs);
      setState(() {
        list = rs['list'];
      });
    }
  }
}
