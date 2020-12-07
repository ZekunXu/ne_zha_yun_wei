import 'package:flutter/material.dart';

class MyButtonWithIcon extends StatefulWidget {

  final IconData icon;
  final String text;
  final Function onPressed;

  
  MyButtonWithIcon({Key key, this.icon, this.text, this.onPressed}) : super(key: key);
  _MyButtonWithIconState createState ()=> _MyButtonWithIconState();
}

class _MyButtonWithIconState extends State<MyButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: FlatButton.icon(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0)),
        label: Text(widget.text),
        icon: Icon(widget.icon ?? Icons.check),
        onPressed: widget.onPressed,
      ),
    );
  }
  
}