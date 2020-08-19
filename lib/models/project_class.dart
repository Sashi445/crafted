import 'package:crafted/models/options_class.dart';

import 'user.dart';

class Project{
  String projectName;
  String projectDescription;
  String purpose;
  String describeMore;
  List<Option> platforms;
  List<Option> domains;
  List<Option> timeForCompletion;

  Project({this.platforms, this.purpose, this.projectDescription, this.projectName, this.domains, this.timeForCompletion, this.describeMore});

  factory Project.fromJson(Map<String, dynamic> jsonData){
    List _domainMap = jsonData['domains'];
    List<Option> _domains = _domainMap.map((e) => Option.fromJson(e)).toList();
    List _platformMap = jsonData['platforms'];
    List<Option> _platforms = _platformMap.map((e) => Option.fromJson(e)).toList();
    List _timeMap = jsonData['timeForCompletion'];
    List<Option> _timeForCompletion = _timeMap.map((e) => Option.fromJson(e)).toList();
    return Project(
      projectName: jsonData['projectName'],
      projectDescription: jsonData['Project Description'],
      domains: _domains,
      describeMore: jsonData['describeMore'],
      purpose: jsonData['purpose'],
      platforms: _platforms,
      timeForCompletion: _timeForCompletion
    );
  }

  Map<String, dynamic> toMap(){
   return {
     'describeMore' : describeMore,
     'purpose' : purpose,
     'projectName' : projectName,
     'projectDescription' : projectDescription,
     'domains' : domains.map((e) => e.toMap()).toList(),
     'platforms' : platforms.map((e) => e.toMap()).toList(),
     'timeForCompletion' : timeForCompletion.map((e) => e.toMap()).toList()
   };
  }
}