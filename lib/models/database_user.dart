import 'package:crafted/models/project_class.dart';
import 'user.dart';

class DataBaseUser{
  final User user;
  List<Project> projects;

  DataBaseUser({this.user, this.projects});

  factory DataBaseUser.fromJson(Map<String, dynamic> jsonData){
    List _projectMaps = jsonData['projects'];
    List<Project> _projects = _projectMaps.map((e) => Project.fromJson(e)).toList();
    return DataBaseUser(
      user: User.fromMap(jsonData['user']),
      projects: _projects
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'user' : user.toMap(),
      'projects' : projects.map((e) => e.toMap()).toList()
    };
  }
}