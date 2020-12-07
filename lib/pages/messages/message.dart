import 'package:flutter/material.dart';
import '../../widgets/common_text_field.dart';

class MessagePage extends StatefulWidget {

  MessagePage({Key key}) : super(key: key);
  _MessagePageState createState ()=> _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Center(
            child: MyTextField(
              hintText: "hahah",
            ),
          ),
        ),
      ),
    );
  }

}