import 'package:flutter/material.dart';
import 'dart:convert';
import '../../services/map_service.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RobotMainPage extends StatefulWidget {

  String robotSn;
  String nickname;

  RobotMainPage(this.nickname, this.robotSn);

  _RobotMainPageState createState ()=> _RobotMainPageState(this.nickname, this.robotSn);
}

class _RobotMainPageState extends State<RobotMainPage> {

  String robotSn;
  String nickname;
  List mapList = [];

  _RobotMainPageState(this.nickname, this.robotSn);

  _load () {
    getMapList().then((value){
      List response = json.decode(value.data)["result"];
      this.setState(() {
        mapList = response;
      });
    }).catchError((err){
      Fluttertoast.showToast(msg: "error: $err", backgroundColor: Colors.black, textColor: Colors.white);
    });
  }

  @override
  void initState() {
    _load();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(nickname != null ? "$nickname": "未获取数据"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: this.mapList.map((e){
            return Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey, width: 0.5)
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    child: Image.network("https://mapimg.dalurobot.com/${e["ImageInfo"]["FileUrl"]}", fit: BoxFit.cover, width: double.maxFinite,),
                  ),
                  ListTile(
                    title: Text("${e["Name"]}"),
                    subtitle: Text("路线：3条"),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}