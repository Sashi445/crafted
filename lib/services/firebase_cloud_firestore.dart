import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crafted/models/comment.dart';
import 'package:crafted/models/database_user.dart';
import 'package:crafted/models/downloadable_apps.dart';
import 'package:crafted/models/project_class.dart';
import 'package:crafted/models/user.dart';


class DataBase{

  final Firestore instance = Firestore.instance;

  Future<void>  addComment({Comment comment}) async {
    try {
      final CollectionReference reference = instance.collection('Comments');
      await reference.document('${comment.docId}').setData(comment.toMap(comment));
    } catch (e) {
      print(e.toString());
      throw Exception('$e');
    }
  }

  Future<void> updateComment({Comment comment}) async{
    try{
      final CollectionReference reference = instance.collection('Comments');
      await reference.document('${comment.docId}').updateData(comment.toMap(comment));
    }catch(e){
      throw Exception("${e.toString()}");
    }
  }

  Future getDownloadableApps() async{
    try{
      final CollectionReference reference = instance.collection('Apps');
      List<Map<String, dynamic>> snapshots = await reference.getDocuments().then((value) => value.documents.map((e) => e.data).toList());
      List<App> apps = snapshots.map((e) => App.fromJson(e)).toList();
      return apps;
    }catch(e){
      throw Exception('$e');
    }
  }

  Future addUser({User user}) async{
    try{
      final CollectionReference reference = instance.collection('users');
      DataBaseUser _userToDatabase = DataBaseUser(user: user, projects: []);
      await reference.document('${user.uid}').setData(_userToDatabase.user.toMap());
    }catch(e){
      throw Exception('$e');
    }
  }

  Future addProjectToUserClass({Project project, User user}) async{
    try{
      CollectionReference reference = instance.collection('users').document('${user.uid}').collection('projects');
      await reference.add(project.toMap());
    }catch(e){
      throw Exception('$e');
    }
  }

  Future getProjectsOfUser({User user}) async{
    try{
      CollectionReference reference = instance.collection('users').document('${user.uid}').collection('projects');
      QuerySnapshot snapshot = await reference.getDocuments();
      List<DocumentSnapshot> _documentSnapshots = snapshot.documents;
      List<Project> projects = _documentSnapshots.map((e) => Project.fromJson(e.data)).toList();
      return projects;
    }catch(e){
      throw Exception('$e');
    }
  }
}