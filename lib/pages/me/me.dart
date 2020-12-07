import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:roslib/roslib.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'robot_control.dart';

class MePage extends StatefulWidget {
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  Ros ros = Ros(url: 'ws://140.143.140.121:9191');
  Topic cmdVel;
  String batteryPercentage = "0.0";
  var image;
  bool isImage = false;
  Timer _timer;

  getBatteryState() {
    Topic topic = Topic(
      ros: this.ros,
      name: '/robot_battery_state',
      type: 'sensor_msgs/BatteryState',
    );
    topic.subscribe();
    var _this = this;
    ros.stream.listen((event) {
      if (event["topic"] == '/robot_battery_state') {
        setState(() {
          _this.batteryPercentage = event["msg"]["percentage"].toString();
        });
      }
    });
  }

  @override
  void initState() {
    ros.connect();
    getBatteryState();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<Object>(
          stream: ros.statusStream,
          builder: (context, snapshot) {
            return SafeArea(child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: ActionChip(
                      label: Text(snapshot.data == Status.CONNECTED
                          ? 'DISCONNECT'
                          : 'CONNECT'),
                      backgroundColor: snapshot.data == Status.CONNECTED
                          ? Colors.green
                          : Colors.grey,
                      onPressed: () {
                        if (snapshot.data == Status.CONNECTED)
                          ros.close();
                        else
                          ros.connect();
                      },
                    ),
                  ),
                  Text("电池电量: $batteryPercentage"),
                  RaisedButton(
                    child: Text("订阅操控话题"),
                    onPressed: () {
                      setState(() {
                        this.cmdVel = Topic(
                            ros: this.ros,
                            name: '/cmd_vel',
                            type: 'geometry_msgs/Twist',
                            reconnectOnClose: true);
                        Fluttertoast.showToast(
                            msg: "操控你的机器人吧",
                            textColor: Colors.white,
                            backgroundColor: Colors.black);
                      });
                    },
                  ),
                  RaisedButton(
                      child: Text("获取zed图像"),
                      onPressed: () {
                        Topic topic = Topic(
                          ros: this.ros,
                          name: '/zed/rgb/image_raw_color/compressed',
                          type: 'sensor_msgs/CompressedImage',
                          queueSize: 1,
                          reconnectOnClose: false,
                        );

                        var _this = this;

                        _timer =
                            Timer.periodic(Duration(milliseconds: 500), (timer) {
                              topic.subscribe();
                              ros.stream.listen((event) {
                                if (event["topic"] ==
                                    '/zed/rgb/image_raw_color/compressed') {
                                  Uint8List image = Base64Decoder().convert(event["msg"]["data"]);
                                  setState(() {
                                    _this.image = image;
                                    _this.isImage = true;
                                  });
                                  topic.unsubscribe();
                                }
                              });
                            });
                      }),
                  Image(
                    image: this.isImage
                        ? MemoryImage(this.image)
                        : NetworkImage(
                        "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3122841051,1709320166&fm=26&gp=0.jpg"),
                    fit: BoxFit.cover,
                    width: 300,
                    height: 200,
                    gaplessPlayback: true,
                  ),
                  RobotControlWidget(
                    onRobotControlListener: (rad, len){
                      // print("角度: ${-rad*180/pi+180}, 位移: $len");
                      _gogogo(len, rad, this.cmdVel);
                    } ,
                  ),
                ],
              ),
            ));
          },
        ));
  }
}

_gogogo (axisX, axisY, cmdVel) async {

  var axisYY;
  var axisXX;

  if ((-axisY*180/pi+180) < 90 || (-axisY*180/pi+180) > 270){
    axisXX = axisX;
  }else if((-axisY*180/pi+180) == 90 || (-axisY*180/pi+180) == -270){
    axisXX = 0;
  }else {
    axisXX = -axisX;
  }

  if((-axisY*180/pi+180) >= 0 && (-axisY*180/pi+180) <= 90){
    axisYY = -(-axisY*180/pi+180)/180;
  }else if((-axisY*180/pi+180)>90 && (-axisY*180/pi+180) <=270){
    axisYY = -(-axisY*180/pi)/180;
  }else{
    axisYY = (axisY*180/pi+180)/180;
  }

  // print("角度: ${(-axisY*180/pi+180)}, 线: $axisXX");
  print(axisYY);

  Map message = {
    "linear": {
      "x": axisXX/10,
      "y": 0.0,
      "z": 0.0,
    },
    "angular": {
      "x": 0.0,
      "y": 0.0,
      "z": axisYY,
    }
  };

  await cmdVel.publish(message);
}
