import 'package:flutter/material.dart';
import 'dart:convert';
import '../../widgets/common_card.dart';
import '../../routers/application.dart';
import '../../services/session_service.dart';
import '../../widgets/common_button_with_icon.dart';

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
    return this.robotList.length > 0 ? ListView.builder(
        itemCount: this.robotList.length,
        itemBuilder: (context, index) {

          // 获取机器人的运行状态
          var robotStatus = robotList[index]["Online"];
          var nickname = robotList[index]["Nickname"];

          return Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: MyCard(
              // 机器人在线的话是蓝色边框，离线的话是灰色边框
              border: Border.all(color: robotStatus ? Color.fromRGBO(63, 140, 255, 1.000) : Colors.grey,style: BorderStyle.solid),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20.0,
                          child: Icon(Icons.android),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        title: Text(nickname, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          subtitle: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              children: [
                                Icon(Icons.add_alert, color: Color.fromRGBO(63, 140, 255, 1.000),),
                                Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),),
                                Text(robotStatus ? "在线" : "离线", style: TextStyle(fontSize: 14, color: robotStatus ? Color.fromRGBO(63, 140, 255, 1.000) : Colors.grey),),
                              ],
                            ),
                          ),
                      ),
                      Divider(
                        height: 1,
                        color: Color.fromRGBO(125, 126, 131, 1.000),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyButtonWithIcon(
                              text: "重启",
                              icon: Icons.restore,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            ),
                            MyButtonWithIcon(
                              text: "去导航",
                              icon: Icons.navigation,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
          );
        }
    ) : Text("loading...");
  }
}

// ListTile(
// leading: Icon(Icons.android),
// title: Text(robotList[index]["Nickname"]),
// subtitle: Text(robotList[index]["Online"] ? "在线" : "离线"),
// onTap: (){
// Application.router.navigateTo(context,
// "/robot?nickname=${Uri.encodeQueryComponent(robotList[index]["Nickname"].toString())}&robotSn=${robotList[index]["Robotsn"].toString()}");
// },
// )
