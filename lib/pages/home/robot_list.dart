import 'package:flutter/material.dart';
import 'dart:convert';
import '../../widgets/common_card.dart';
import '../../routers/application.dart';
import '../../services/session_service.dart';

class RobotList extends StatefulWidget {
  _RobotListState createState() => _RobotListState();
}

class _RobotListState extends State<RobotList> {
  List robotList = [];

  _getRobotInfo() async {
    getRobotsList().then((value) {
      List response = json.decode(value.data)["result"];
      this.setState(() {
        robotList = response;
      });
    });
  }

  @override
  void initState() {
    _getRobotInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return this.robotList.length > 0
        ? MyCard(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            children: this.robotList.map((e) {
              return ListTile(
                leading: Icon(Icons.android),
                title: Text(e["Nickname"].toString()),
                subtitle: Text(e["Online"] ? "在线" : "离线"),
                onTap: () {
                  Application.router.navigateTo(context,
                      "/robot?nickname=${Uri.encodeQueryComponent(e["Nickname"].toString())}&robotSn=${e["Robotsn"].toString()}");
                },
              );
            }).toList(),
          ),
        ))
        : Text("loading...");
  }
}