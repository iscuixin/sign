import 'package:flutter/material.dart';
import 'package:myh_shop/app/main/popularity/popu_info.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyAppBar.dart';

class PopularityIndex extends StatefulWidget {
  @override
  _PopularityIndexState createState() => _PopularityIndexState();
}

class _PopularityIndexState extends State<PopularityIndex> {
  List list = [1, 2, 3, 4, 5, 5, 5, 5, 4];
  List items;
  List box;
  List cp;
  List clothes;

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('check_popularity_rate_category');
    if (rs != null) {
      setState(() {
        items = rs['res']['items_cate'];
        box = rs['res']['box_cate'];
        cp = rs['res']['pro_cate'];
        clothes = rs['res']['underwear_cat'];
      });
    }
    //print(rs);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: MyAppBar(
          title: Text('普及率'),
          bottom: PreferredSize(
              child: TabBar(
                tabs: [
                  Tab(
                    text: '项目',
                  ),
                  Tab(
                    text: '套盒',
                  ),
                  Tab(
                    text: '产品',
                  ),
                  Tab(
                    text: '内衣',
                  ),
                ],
                indicatorSize: TabBarIndicatorSize.label,
              ),
              preferredSize: Size(getRange(context), 50)),
        ),
        body: TabBarView(children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            color: bg2,
            child: items==null?Center(child: loading(),):GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10),
              itemBuilder: (_, i) => _item(i, 1),
              itemCount: items.length,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            color: bg2,
            child: box==null?Center(child: loading(),):GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10),
              itemBuilder: (_, i) => _item(i, 2),
              itemCount: box.length,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            color: bg2,
            child: cp==null?Center(child: loading(),):GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10),
              itemBuilder: (_, i) => _item(i, 3),
              itemCount: cp.length,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            color: bg2,
            child: clothes==null?Center(child: loading(),):GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10),
              itemBuilder: (_, i) => _item(i, 4),
              itemCount: clothes.length,
            ),
          ),
        ]),
      ),
      length: 4,
    );
  }

  Widget _item(int i, t) {
    String name = '';
    Map d;
    int k = 1;
    if(t==1){
      name = items[i]['name'];
      d = items[i];
      k = 3;
    }
    if(t==2){
      name = box[i]['name'];
      d = box[i];
      k = 2;
    }
    if(t==3){
      name = cp[i]['name'];
      d = cp[i];
    }
    if(t==4){
      name = clothes[i]['name'];
      d = clothes[i];
      k = 4;
    }
    String img = '';
    //print(name);
    if(name=='头部'){
      img = '7.0_03';
    }else if(name=='面部'){
      img = '7.0_05';
    }else if(name=='眼部'){
      img = '7.0_07';
    }else if(name=='身体'){
      img = '7.0_09';
    }else if(name=='减肥'){
      img = '7.0_15';
    }else if(name=='私密'){
      img = '7.0_16';
    }else if(name=='仪器类'){
      img = '7.0_17';
    }else if(name=='大项目'){
      img = '7.0_21';
    }else if(name=='修饰美容'){
      img = '7.0_21';
    }else if(name=='其它'){
      img = '7.0_22';
    }else if(name=='保健品'){
      img = 'bjp';
    }else if(name=='保养品'){
      img = 'byp';
    }else if(name=='内衣'){
      img = 'ny3';
    }else if(name=='胸衣'){
      img = 'ny3';
    }
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Image.asset(
            getImg(img),
            height: 60.0,
            width: 60.0,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      onTap: () {
        Map data = {'px': k, 'name': d['name'], 'cate_id': d['id']};
        jump2(context, PopuInfo(data));
      },
    );
  }
}
