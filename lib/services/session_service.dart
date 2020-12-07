import 'package:dalu_robot/configs/configure_dio.dart';
import 'package:dio/dio.dart';
import '../configs/configure_cookie.dart';
import '../configs/configure_url.dart';
import 'dart:async';

Future<Response> handleLogin(Map loginInfo) async {
  const url = ApiUrl.LOGIN_REQUEST;

  Response response = await (await MyDio.dio).post(url, data: loginInfo);


  return response;
}

Future<bool> handleLogout() async {

  await deleteSessionCookie();
  bool isSuccess = await getSessionCookie().then((value){
    if(value.length > 0){
      return false;
    }else{
      return true;
    }
  });

  return isSuccess;
}

Future<List> getSessionCookie() async {

  var cookie = (await MyCookie.cookieJar).loadForRequest(Uri.parse(daluApiUrl));

  return cookie;
}

deleteSessionCookie() async {
  (await MyCookie.cookieJar).delete(Uri.parse(daluApiUrl));
}


Future<Response> getRobotsList({pageSize: 15, page: 1, param: 1, robotsn: "", nickname: ""}) async {
  var url = ApiUrl.ROBOTS_LIST;

  Response response = await (await MyDio.dio).get(url, queryParameters: {
    "pageSize": pageSize, "page": page, "param": param, "robotsn": robotsn, "nickname": nickname,
  });

  return response;
}