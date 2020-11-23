import 'package:flutter/material.dart';

import '../configs/configure_dio.dart';
import 'dart:async';
import '../configs/configure_url.dart';
import 'package:dio/dio.dart';


Future<Response> handleNavigation(Map param, String robotSn) async {
  var url = ApiUrl.NAVIGATION_CONTROL + robotSn + "/nav1";

  Response response = await (await NavigationDio.dio).post(url, data: param);

  return response;
}


Future<Response> getMapsAndPaths() async {
  var url = ApiUrl.ALL_MAP_PATH_INFO;

  Response response = await(await MyDio.dio).get(url);

  return response;
}