import 'package:flutter/cupertino.dart';
/// 通用的卡片形状。使用圆角矩形的卡片风格，保持了和app设计风格的一直。
/// version: 1.0.0
/// 最后修改时间: 2020年12月5日

import 'package:flutter/material.dart';


class MyCardWidget extends StatefulWidget {

  /// [child] 继承了 [Card] 的相同属性，必填。
  /// [margin] 继承了 [Card] 的内边距，非必填，可以改变内边距。

  final Widget child;
  final EdgeInsets margin;

  MyCardWidget({Key key, @required this.child, this.margin}) : super(key: key);
  _MyCardWidgetState createState ()=> _MyCardWidgetState();
}

class _MyCardWidgetState extends State<MyCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            offset: Offset(0.0, 3.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Card(
        color: Color.fromRGBO(53, 56, 60, 1.000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        margin: widget.margin ?? const EdgeInsets.all(0.0),
        child: widget.child,
      ),
    );
  }
  
}