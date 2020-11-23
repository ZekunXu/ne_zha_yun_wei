import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'routes.dart';
import '../pages/session/login.dart';
import '../pages/session/new_login.dart';
import '../pages/robot/robot_main.dart';



Handler loginPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    return LoginPage();
  }
);

Handler newLoginPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return NewLoginPage();
  }
);

Handler robotMainPageHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    String nickname = params["nickname"].first;
    String robotSn = params["robotSn"].first;

    return RobotMainPage(nickname, robotSn);
  }
);