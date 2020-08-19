import 'package:crafted/models/project_class.dart';
import 'package:crafted/models/user.dart';
import 'package:crafted/services/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'project_build_form.dart';


class BuildAppStartPage extends StatefulWidget {
  final User user;
  BuildAppStartPage({this.user});
  @override
  _BuildAppStartPageState createState() => _BuildAppStartPageState();
}

class _BuildAppStartPageState extends State<BuildAppStartPage> {

  bool shouldSwitch = false;

  @override
  void initState(){
    Future.delayed(Duration(seconds: 3)).then((value){
      setState(() {
        shouldSwitch = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: AnimatedCrossFade(
          crossFadeState: shouldSwitch ? CrossFadeState.showSecond : CrossFadeState.showFirst ,
          duration: Duration(seconds: 2),
          firstChild: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.amber,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Start Building Your Projects Here\n'
                      'Getting Your Console Ready!!...',
                    style: GoogleFonts.varelaRound(fontSize: MediaQuery.of(context).size.width < 700 ? 20 : 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width < 700 ?
                          50 : 100,
                        vertical: MediaQuery.of(context).size.width < 700 ? 100 : 100
                      ),
                      child: Image.network('https://blush.ly/5Mqt4qqVA/p', fit: BoxFit.fill,),
                    )
                )
              ],
            ),
          ),
      secondChild:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Colors.amber,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child:
                  Text('Your Projects', style: GoogleFonts.roboto(fontSize: 40),),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<DataBase>(context, listen: false).getProjectsOfUser(user: widget.user),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      List<Project> _projects = snapshot.data;
                      print(_projects);
                      return Container(
                        width: MediaQuery.of(context).size.width,
                          color: Colors.grey[100],
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          child: GridView.builder(
                              itemCount: _projects.length + 1,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: MediaQuery.of(context).size.width < 700 ? 2 : 4
                              ),
                              itemBuilder: (context, index){
                                if(index == 0){
                                  return InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => BuildProjectForm())
                                      );
                                    },
                                    child: Card(
                                        margin: EdgeInsets.all(13),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('Add Project', style: GoogleFonts.varelaRound(fontSize: 20, color: Colors.blue),),
                                            ),
                                            Icon(Icons.add, size: 30, color: Colors.blue,)
                                          ],
                                        )
                                    ),
                                  );
                                }
                                return Card(
                                  margin: EdgeInsets.all(13),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: ListTile(
                                      title: Text('${_projects.elementAt(index - 1).projectName}', style: GoogleFonts.varelaRound(fontSize: 20),),
                                      subtitle: Text('${_projects.elementAt(index - 1).purpose}'),
                                    ),
                                  ),
                                );
                              }
                          )
                      );
                    }else if(snapshot.hasError){
                      return Center(child: Text('${snapshot.error}'),);
                    }return Center(child: CircularProgressIndicator(),);
                  },
                )
              )
            ],
          ),
        ),
      )
        ),
      ),
    );
  }
}