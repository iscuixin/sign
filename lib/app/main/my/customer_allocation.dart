import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton.dart';

class CustomerAllocation extends StatefulWidget {
  final int id;

  const CustomerAllocation(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _CustomerAllocationState createState() => _CustomerAllocationState();
}

class _CustomerAllocationState extends State<CustomerAllocation> {
  List list = [1, 1, 1, 1, 1, 1, 1, 1];
  List my;
  List no;
  String name = '';
  String role = '';

  @override
  void initState() {
    super.initState();
    getSj();
  }

  void getSj() async {
    var rs = await get('get_distribution_member', data: {'staff': widget.id});
    if (rs != null) {
      //print(rs);
      setState(() {
        my = rs['res']['staff_member'];
        no = rs['res']['not_member'];
        role = rs['res']['staff_info']['role'];
        name = rs['res']['staff_info']['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg2,
      child: DefaultTabController(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              title: Text(
                '客户分配',
                style: TextStyle(color: Colors.white),
              ),
              leading: backButton(context, color: Colors.white),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        getImg('5.21_01'),
                        fit: BoxFit.fill,
                      ),
                      height: 200,
                      width: getRange(context),
                    ),
                    Positioned(
                      top: 120,
                      left: 15,
                      right: 15,
                      child: Container(
                        height: getRange(context, type: 3) > 0 ? 120 : 100,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: circularImg(
                                      'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                                      80, t: 2),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        /*Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Image.asset(
                                                getImg('3_14'),
                                                width: 18,
                                                height: 18,
                                              ),
                                            ),
                                            Text(
                                              '美约会总店',
                                              style:
                                                  TextStyle(color: textColor),
                                            )
                                          ],
                                        ),*/
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Image.asset(
                                                  getImg('5.2_05'),
                                                  width: 18,
                                                  height: 18,
                                                ),
                                              ),
                                              Text(
                                                role,
                                                style:
                                                    TextStyle(color: textColor),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TabBar(
                      tabs: [
                        Tab(
                          text: '现有客户',
                        ),
                        Tab(
                          text: '分配',
                        ),
                      ],
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
                  ),
                  preferredSize: Size(getRange(context), 50)),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: getRange(context, type: 2) -
                    300 -
                    getRange(context, type: 4),
                child: TabBarView(children: [
                  my != null
                      ? ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemBuilder: (_, i) => _item2(i),
                          itemCount: my.length,
                        )
                      : Center(
                          child: loading(),
                        ),
                  no != null
                      ? ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemBuilder: (_, i) => _item(i),
                          itemCount: no.length,
                        )
                      : Center(
                          child: loading(),
                        )
                ]),
              ),
            )
          ],
        ),
        length: 2,
      ),
    );
  }

  Widget _item(int i) => Column(
        children: <Widget>[
          ListTile(
            leading: circularImg(
                'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                55, t: 2),
            title: Text('${no[i]['name']}'),
            subtitle: Text('${no[i]['tel']}'),
            trailing: MyButton(
              onPressed: () {
                cancel(no[i]['id'], 'add');
              },
              title: '分配',
              width: getRange(context) / 4,
              height: 35,
            ),
          ),
          Divider()
        ],
      );

  Widget _item2(int i) => Column(
        children: <Widget>[
          ListTile(
            leading: circularImg(
                'http://www.caisheng.net/UploadFiles/img_0_3534166376_2649719102_27.jpg',
                55, t: 2),
            title: Text('${my[i]['name']}'),
            subtitle: Text('${my[i]['tel']}'),
            trailing: MyButton(
              onPressed: () {
                cancel(my[i]['id'], 'cancel');
              },
              title: '移除',
              color: Colors.red,
              width: getRange(context) / 4,
              height: 35,
            ),
          ),
          Divider()
        ],
      );

  void cancel(int id, type) async {
    var rs = await post('get_distribution_member',
        data: {'id': id, 'type': type, 'staff': widget.id});
    if (rs != null) {
      if(rs['code']==1){
        getSj();
      }else{
        tip(context, rs['error']);
      }
      //print(rs);
    }
  }
}
