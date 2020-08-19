import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crafted/models/comment.dart';
import 'package:crafted/services/firebase_auth.dart';
import 'package:crafted/services/firebase_cloud_firestore.dart';
import 'package:crafted/models/user.dart';


class AddComment extends StatelessWidget {
  final DataBase  dataBase = DataBase();
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Auth>(context, listen: false).getCurrentUser(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3
                  )
                ]
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width:MediaQuery.of(context).size.width/2,
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                        labelText: 'Enter your Comment'
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    User user = snapshot.data;
                    String comment = _commentController.text;
                    Comment _comment = Comment(
                      user: user,
                      comment: comment,
                      likes: 0,
                      dislikes: 0,
                    );
                    _comment.genDocId();
                    dataBase.addComment(comment: _comment);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        }else if(snapshot.hasError){
          return Center(child: Text('${snapshot.error}'),);
        }return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
