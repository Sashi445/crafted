import 'package:crafted/models/project_class.dart';
import 'package:crafted/models/user.dart';
import 'package:crafted/services/firebase_auth.dart';
import 'package:crafted/services/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProjectForm extends StatelessWidget {
  Project project;
  ProjectForm({this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Crafted', style: GoogleFonts.pacifico(fontSize: 30, color: Colors.white),),
        ),
      body: ResponsiveBuilder(
        builder: (context, screenConstraints){
          if(screenConstraints.deviceScreenType == DeviceScreenType.desktop){
            return Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height,
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height,
                    child: Column1(project: project))
              ],
            );
          }else{
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column1(project: project,),
            );
          }
        },
      )
    );
  }
}


class Column1 extends StatefulWidget {
  Project project;
  Column1({this.project});
  @override
  _Column1State createState() => _Column1State();
}

class _Column1State extends State<Column1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _describeMoreController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height/7,
              width: MediaQuery.of(context).size.width > 700 ? MediaQuery.of(context).size.width/3 : MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  validator: (String val){
                    if(val.isEmpty){
                      return "This field is required";
                    }return null;
                  },
                  controller: _describeMoreController,
                  decoration: InputDecoration(
                    labelText: '(optional if the domain was chosen earlier)'
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Choose the target platforms', style: GoogleFonts.roboto(fontSize: 20),),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.project.platforms.map((e) => SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width/3,
                child: ListTile(
                  leading: Checkbox(
                    tristate: true,
                    value: e.value,
                    onChanged: (bool val){
                      setState(() {
                        e.value = !e.value;
                        print('${widget.project.projectDescription}');
                      });
                    },
                  ),
                  title: Text('${e.text}'),
                )
            )).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('How many days do you think we will complete this project ?', style: GoogleFonts.roboto(fontSize: 20),),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.project.timeForCompletion.map((e) => SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width/3,
              child: ListTile(
                leading: Checkbox(
                  tristate: true,
                  value: e.value,
                  onChanged: (bool val){
                    setState(() {
                      e.value = !e.value;
                    });
                  },
                ),
                title: Text('${e.text}'),
              ),
            )).toList(),
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text('Submit'),
            onPressed: () async{
              for(int i=0; i<widget.project.domains.length; i++){
                if(widget.project.domains.elementAt(i).value == true){
                  DataBase _database =  DataBase();
                  User user = await Provider.of<Auth>(context, listen: false).getCurrentUser();
                  await _database.addProjectToUserClass(user: user, project: widget.project);

                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Your Project has been submitted'),
                      ),
                    )
                  );
                  Future.delayed(Duration(seconds: 3)).then((value){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    return null;
                  });
                }else{
                  _formKey.currentState.validate();
                }
              }
            },
          )
        ],
      ),
    );
  }
}
