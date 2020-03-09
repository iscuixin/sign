import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';
import 'package:myh_shop/widget/MyButton2.dart';

class PlanItem extends StatefulWidget {
  final Map data;
  final ValueChanged<Map> onChanged;
  final Widget trailing;

  const PlanItem(
    this.data, {
    Key key,
    this.onChanged, this.trailing,
  }) : super(key: key);

  @override
  _PlanState createState() => _PlanState(this.data);
}

class _PlanState extends State<PlanItem> with SingleTickerProviderStateMixin {
  final double height = 50;
  bool zt = false;
  Map d;

  _PlanState(this.d);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 0, right: 10),
            leading: Container(
              width: getRange(context)*3/4,
              child: Row(
                children: <Widget>[
                  AnimatedCrossFade(
                      firstChild: MyButton2(
                        onPress: () {
                          setState(() {
                            zt = !zt;
                          });
                        },
                        icon: Icons.chevron_right,
                        color: disColor,
                      ),
                      secondChild: MyButton2(
                        onPress: () {
                          setState(() {
                            zt = !zt;
                          });
                        },
                        icon: Icons.keyboard_arrow_down,
                        color: myColor(105, 105, 106),
                      ),
                      crossFadeState: zt
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Duration(milliseconds: 200)),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      '${d['name']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    width: 120,
                  ),
                  priceWidget('${d['sale']}'),
                ],
              ),
            ),
            trailing: widget.trailing??Container(
              width: getRange(context) / 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MyButton2(
                    icon: Icons.remove,
                    color: d['sum'] > 0 ? c1 : disColor,
                    onPress: () {
                      if (d['sum'] > 0) {
                        setState(() {
                          d['sum']--;
                        });
                        widget.onChanged(d);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      '${d['sum']}',
                      style: TextStyle(color: textColor, fontSize: 18),
                    ),
                  ),
                  MyButton2(
                    icon: Icons.add,
                    onPress: () {
                      setState(() {
                        d['sum']++;
                      });
                      widget.onChanged(d);
                    },
                  ),
                  //IconButton(icon: Icon(Icons.add), onPressed: (){}),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 200),
          vsync: this,
          child: zt
              ? Table(
                  children: _item(),
                )
              : Offstage(),
        ),
        Divider(
          height: 0,
        )
      ],
    );
  }

  List<TableRow> _item() {
    List<TableRow> rs = [
      TableRow(children: [
        TableCell(
          child: Column(
            children: <Widget>[
              Container(
                height: height,
                alignment: Alignment.center,
                color: tableBg,
                child: Text('类别'),
              ),
              Divider(
                height: 0,
                color: textColor,
              )
            ],
          ),
        ),
        TableCell(
          child: Column(
            children: <Widget>[
              Container(
                height: height,
                alignment: Alignment.center,
                color: tableBg,
                child: Text('名称'),
              ),
              Divider(
                height: 0,
                color: textColor,
              )
            ],
          ),
        ),
        TableCell(
          child: Column(
            children: <Widget>[
              Container(
                height: height,
                alignment: Alignment.center,
                color: tableBg,
                child: Text('售价'),
              ),
              Divider(
                height: 0,
                color: textColor,
              )
            ],
          ),
        ),
        TableCell(
          child: Column(
            children: <Widget>[
              Container(
                height: height,
                alignment: Alignment.center,
                color: tableBg,
                child: Text('次数'),
              ),
              Divider(
                height: 0,
                color: textColor,
              )
            ],
          ),
        ),
      ])
    ];
    for (var v in d['detail']) {
      rs.add(TableRow(children: [
        TableCell(
          child: Column(
            children: <Widget>[
              Container(
                height: height,
                alignment: Alignment.center,
                color: tableBg,
                child: Text('${v['type']}'),
              ),
              Divider(
                height: 0,
                color: textColor,
              )
            ],
          ),
        ),
        TableCell(
          child: Column(
            children: <Widget>[
              Container(
                height: height,
                alignment: Alignment.center,
                color: tableBg,
                child: Text(
                  '${v['name']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(
                height: 0,
                color: textColor,
              )
            ],
          ),
        ),
        TableCell(
          child: Column(
            children: <Widget>[
              Container(
                height: height,
                alignment: Alignment.center,
                color: tableBg,
                child: Text(
                  '${v['price']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Divider(
                height: 0,
                color: textColor,
              )
            ],
          ),
        ),
        TableCell(
          child: Column(
            children: <Widget>[
              Container(
                height: height,
                alignment: Alignment.center,
                color: tableBg,
                child: Text('${v['times']}'),
              ),
              Divider(
                height: 0,
                color: textColor,
              )
            ],
          ),
        ),
      ]));
    }
    return rs;
  }
}
