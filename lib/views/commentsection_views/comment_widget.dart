import 'package:crafted/models/comment.dart';
import 'package:crafted/services/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatefulWidget {
  Comment comment;
  CommentWidget({this.comment});

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    DataBase _dataBase = Provider.of<DataBase>(context);
    return Card(
      child: Column(
        children: [
           ListTile(
              leading: CircleAvatar(
              backgroundImage: NetworkImage('${widget.comment.user.photoUrl}'),
               ),
              title: Text('${widget.comment.user.displayName}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
              subtitle: Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/4),
                  child: Text('${widget.comment.comment}', style: TextStyle(fontSize: 14, color: Colors.black87),)),
           ),
          ButtonBar(
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up),
                onPressed: (){
                  setState(() {
                    widget.comment.likes++;
                    _dataBase.updateComment(comment: widget.comment);
                  });
                },
              ),
              Text('${widget.comment.likes}'),
              IconButton(
                icon: Icon(Icons.thumb_down),
                onPressed: (){
                  setState(() {
                    widget.comment.dislikes++;
                    _dataBase.updateComment(comment: widget.comment);
                  });
                },
              ),
              Text('${widget.comment.dislikes}'),
              SizedBox(width: 10,)
            ],
          )
        ],
      ),
    );
  }
}