import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../main_state.dart';
import '../../services/get_navigation_info.dart';
import '../../services/navigation_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'get_voice_command.dart';
import 'robot_list.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<MainState, _viewModel>(
      converter: (store) => _viewModel.create(store),
      builder: (context, viewModel) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    children: [
                      RobotList(),
                      GetVoiceCommand(),
                      Test(),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}



class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List myList = List();
  String myMap;
  String myPath;
  List myPathList = List();
  String current_state = "无导航任务";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton(
            value: this.myMap,
            hint: Text("选择地图"),
            onTap: () async {
              var response = await getMaps();
              setState(() {
                this.myList = response;
              });
              print("aaa");
            },
            items: this.myList.length > 0
                ? this.myList.map((e) {
                    return DropdownMenuItem(
                        child: Text(e["Name"]), value: e["Name"]);
                  }).toList()
                : [DropdownMenuItem(child: Text("点击获取地图"))],
            onChanged: (value) async {
              setState(() {
                this.myPath = null;
                this.myMap = value;
              });
              int mapId = this
                  .myList
                  .where((map) => map["Name"] == this.myMap)
                  .toList()[0]["MapId"];
              var response = await getPaths(mapId);
              setState(() {
                this.myPathList = response["Paths"].length > 0
                    ? response["Paths"]
                    : [
                        {"Name": "无路径"}
                      ];
              });
            },
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            value: this.myPath,
            items: this.myPathList.length > 0
                ? this.myPathList.map((e) {
                    return DropdownMenuItem(
                      child: Text(e["Name"]),
                      value: e["Name"],
                    );
                  }).toList()
                : [DropdownMenuItem(child: Text("点击选择路径"))],
            onChanged: (value) {
              setState(() {
                this.myPath = value;
              });
            },
          ),
        ),
        RaisedButton(
            child: Text("开始导航"),
            onPressed: () {
              getNavigation("nav_start");
              setState(() {
                this.current_state = "正在导航";
              });
            }),
        RaisedButton(
            child: Text("暂停导航"),
            onPressed: () {
              getNavigation("pause_navi");
              setState(() {
                this.current_state = "暂停导航";
              });
            }),
        RaisedButton(
            child: Text("继续导航"),
            onPressed: () {
              getNavigation("continue_navi");
              setState(() {
                this.current_state = "正在导航";
              });
            }),
        RaisedButton(
            child: Text("停止导航"),
            onPressed: () {
              getNavigation("nav_stop");
              setState(() {
                this.current_state = "无导航任务";
              });
            }),
        Text(this.current_state),
      ],
    );
  }

  getNavigation(String order) async {
    int mapId = this
        .myList
        .where((map) => map["Name"] == this.myMap)
        .toList()[0]["MapId"];
    int pathId = this
        .myPathList
        .where((path) => path["Name"] == this.myPath)
        .toList()[0]["PathId"];

    Map param = {
      "action": order,
      "mapid": mapId,
      "pathid": pathId,
      "robotsn": "robot-201910001:28cc026b-95cc-5bb6-80f9-f6f4dfe2fac5",
      "navitasklist": [
        {
          "taskname": this.myPath,
          "timeparam": {
            "istime": false,
            "starttime": {"hour": 1, "minute": 1},
            "stoptime": {"hour": 1, "minute": 1}
          },
          "loopparam": {"isloop": true, "loopnum": 20},
          "chargeparam": {
            "chargeonce": false,
            "ischarge": true,
            "chargetime": 1
          }
        }
      ]
    };

    String robotsn = "robot-201910001:28cc026b-95cc-5bb6-80f9-f6f4dfe2fac5";

    handleNavigation(param, robotsn).then((value) {
      Fluttertoast.showToast(
          msg: "success: $value",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }).catchError((err) {
      Fluttertoast.showToast(
          msg: "fail: $err",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    });
  }
}

class _viewModel {
  String username;

  _viewModel({this.username});

  factory _viewModel.create(Store<MainState> store) {
    return _viewModel(
      username: store.state.sessionState.username,
    );
  }
}
