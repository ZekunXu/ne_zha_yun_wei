import 'package:flutter/material.dart';

class MyButtonWithIcon extends StatefulWidget {

  final Icon icon;
  final String text;
  final Function onPressed;

  
  MyButtonWithIcon({Key key, this.icon, this.text, this.onPressed}) : super(key: key);
  _MyButtonWithIconState createState ()=> _MyButtonWithIconState();
}

class _MyButtonWithIconState extends State<MyButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon ?? Icons.check,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          ),
          Text(
            widget.text,
            style: TextStyle(
                fontSize: 16),
          ),
        ],
      ),
      onPressed: widget.onPressed,
    );
  }
  
}