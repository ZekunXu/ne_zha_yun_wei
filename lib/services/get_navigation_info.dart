import 'package:dio/dio.dart';
import 'navigation_service.dart';
import 'dart:convert';



Future<List> getMaps() async {

  List maps = List();

  await getMapsAndPaths().then((value){
    var data = json.decode(value.data);
    for(var d in data){
      Map info = Map();
      info["MapId"] = d["MapId"];
      info["Name"] = d["Name"];
      maps.add(info);
    }
  });

  return maps;
}

Future<Map> getPaths(int mapId) async {
  Map paths = Map();

  await getMapsAndPaths().then((value){
    List data = json.decode(value.data);
    paths = data.where((map) => map["MapId"] == mapId).toList()[0];
  });

  return paths;
}