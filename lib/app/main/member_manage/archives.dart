import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/member_manage/add_archives.dart';
import 'package:myh_shop/app/main/member_manage/add_archives2.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';
import 'package:flutter/cupertino.dart';

class Archives extends StatefulWidget {
  final int id;

  const Archives(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  List list;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_healthy_detail', data: {
      'mid': widget.id,
    });
    if (rs != null) {
      if (rs['code'] == 1) {
        setState(() {
          list = rs['list'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('档案列表'),
        actions: <Widget>[
          CupertinoButton(
              child: Text('新建档案'),
              onPressed: () async {
                await jump2(context, AddArchives(widget.id));
                getSj();
              }),
        ],
      ),
      body: list != null
          ? ListView.separated(
              itemBuilder: (_, i) => _item(i),
              itemCount: list.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                    height: 0,
                  ),
            )
          : Center(
              child: loading(),
            ),
    );
  }

  Widget _item(int i) {
    return Container(
      color: bg2,
      child: ListTile(
        onTap: ()async{
          await jump2(context, AddArchives2(list[i]['id'], widget.id, type: 'edit',));
          getSj();
        },
        title: Text('${list[i]['create_time']}'),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
