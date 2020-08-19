import 'add_comment_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crafted/models/comment.dart';
import 'package:crafted/services/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'comment_widget.dart';

class CommentSection extends StatelessWidget {
  final DataBase dataBase = DataBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Write all your reviews and suggestions here!!', style: GoogleFonts.varelaRound(fontSize: 25,),),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                stream:dataBase.instance.collection('Comments').snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    List<DocumentSnapshot> docs = snapshot.data.documents;
                    List<Comment> comments = docs.map((e) => Comment.fromMap(e.data)).toList();
                    if(comments.isEmpty){
                      return Center(child: Text('No comments Yet!!'),);
                    }
                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index){
                        return CommentWidget(comment: comments.elementAt(index),);
                      },
                    );
                  }
                  else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error),);
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add Comment'),
        onPressed: (){
          showModalBottomSheet(context: context, builder:(context) => AddComment());
        },
      ),
    );
  }
}





