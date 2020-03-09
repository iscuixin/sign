import 'package:flutter/material.dart';
import 'package:myh_shop/common.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({
    @required this.title,
    this.elevation = 0,
    this.backgroundColor,
    this.leading,
    this.bottom,
    this.actions, this.flexibleSpace,
  });

  final Widget title;
  final double elevation;
  final Color backgroundColor;
  final Widget leading;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final List<Widget> actions;

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(
      55.0 + (bottom != null ? bottom.preferredSize.height : 0));
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.leading ?? backButton(context),
      backgroundColor: widget.backgroundColor,
      title: widget.title,
      centerTitle: true,
      elevation: widget.elevation,
      bottom: widget.bottom,
      actions: widget.actions,
      flexibleSpace: widget.flexibleSpace,
      /*flexibleSpace: Container(
        height: 50.0 + MediaQuery.of(context).padding.top,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [c1, c2])),
      ),*/
    );
  }
}
