import 'package:flutter/cupertino.dart';

class App{
  String appName;
  String description;
  String url;
  App({this.description, this.url, @required this.appName});

  factory App.fromJson(Map<String, dynamic> jsonData){
    return App(
      appName: jsonData['appName'],
      description: jsonData['description'],
      url: jsonData['url']
    );
  }

}