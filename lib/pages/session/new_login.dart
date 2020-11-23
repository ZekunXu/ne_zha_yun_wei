import 'package:flutter/material.dart';


class NewLoginPage extends StatefulWidget {
  _NewLoginPage createState ()=> _NewLoginPage();
}

class _NewLoginPage extends State<NewLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 49, 53, 1.000),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(47, 49, 53, 1.000),
        title: Text("Sign In", style: TextStyle(fontSize: 24),),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(26, 100, 26, 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("username", textAlign: TextAlign.left,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  borderSide: BorderSide(
                    color: Color(0xff7d7e83),
                    width: 2.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}