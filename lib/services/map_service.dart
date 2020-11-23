import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import '../configs/configure_url.dart';
import 'dart:async';
import '../configs/configure_dio.dart';

Future<Response> getMapList({page: 1, pageSize: 23, param: 1, name: ""}) async {
  var url = ApiUrl.MAP_LIST;

  Response response = await (await MyDio.dio).get(url, queryParameters: {
    "page": page,
    "pageSize": pageSize,
    "param": param,
    "name": name
  });

  return response;
}

Future<Response> getMapImg(String imgName) async {
  var url = daluImgUrl;

  Response response = await (await MyDio.dio).get(url + imgName);

  return response;
}