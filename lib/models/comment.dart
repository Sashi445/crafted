import 'user.dart';
import 'dart:math';

class Comment{
  int docId;
  User user;
  String comment;
  int likes;
  int dislikes;
  Comment({this.docId, this.user, this.comment, this.dislikes, this.likes});

  void genDocId(){
    docId = Random.secure().nextInt(200000).toInt();
  }

  factory Comment.fromMap(Map<String, dynamic> data){
    User _user = User.fromMap(data['user']);
    return Comment(
      docId: data['docId'],
        user: _user,
        comment: data['comment'],
        likes: data['likes'],
        dislikes: data['dislikes']
    );
  }

  Map<String, dynamic>  toMap(Comment comment) {
    Map<String, dynamic> _user = user.toMap();
    return {
      'docId' : comment.docId,
      'user': _user,
      'comment' : comment.comment,
      'likes' : comment.likes,
      'dislikes' : comment.dislikes
    };
  }

}