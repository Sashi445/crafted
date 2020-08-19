
import 'package:flutter/cupertino.dart';

class User{
  String uid;
  String displayName;
  String email;
  String photoUrl;


  User({@required this.uid, this.displayName, this.email, this.photoUrl});


  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'displayName' : displayName,
      'email' : email,
      'photoUrl' : photoUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> data){
    return User(
        uid: data['uid'],
        displayName: data['displayName'],
        email: data['email'],
        photoUrl: data['photoUrl']
    );
  }
}