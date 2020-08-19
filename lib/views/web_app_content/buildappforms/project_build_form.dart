import 'package:crafted/models/project_class.dart';
import 'package:crafted/views/web_app_content/buildappforms/project_build_form_2.dart';
import 'package:flutter/material.dart';
import 'package:crafted/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crafted/services/read_model_from_json.dart';
import 'package:responsive_builder/responsive_builder.dart';


class BuildProjectForm extends StatefulWidget {

  @override
  _BuildProjectFormState createState() => _BuildProjectFormState();
}

class _BuildProjectFormState extends State<BuildProjectForm> {

  ProjectFromJson projectFromJson = ProjectFromJson();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _purposeController = TextEditingController();

  final TextEditingController _projectNameController = TextEditingController();

  final TextEditingController _projectDescriptionController = TextEditingController();

  User user;

  int _groupValue = -1;

  List<Widget> _radioBuilder({Project project}){
    List<Widget> _domains = [];
    for(int i=0; i<project.domains.length; i++){
      _domains.add(
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width*3/4,
          child: ListTile(
            leading: Radio(
              value: i,
              groupValue: _groupValue,
              onChanged: (int value) {
                setState(() {
                  _groupValue = value;
                });
              },
            ),
            title: Text('${project.domains.elementAt(i).text}'),
          ),
        )
      );
    }
    return _domains;
  }


  @override
  Widget build(BuildContext context) {
    Project _project = Project.fromJson(projectFromJson.baseClass);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Crafted', style: GoogleFonts.pacifico(fontSize: 30, color: Colors.white),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (context, screenConstraints){
            if(screenConstraints.deviceScreenType == DeviceScreenType.desktop){
              return Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                        ),
                        padding: EdgeInsets.only(bottom: 0, top: 50, left: 20, right: 20),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              Text('Hello, there!!',
                                style: GoogleFonts.droidSerif(fontSize: 30),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                                child: TextFormField(
                                  controller: _projectNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Project Name',
                                  ),
                                  validator: (String value){
                                    if(value.isEmpty){
                                      return 'this field is required';
                                    }return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                                child: TextFormField(
                                  controller: _projectDescriptionController,
                                  decoration: InputDecoration(
                                      labelText: 'Project Description'
                                  ),
                                  validator: (String value){
                                    if(value.isEmpty){
                                      return 'this field is required';
                                    }return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                                child: TextFormField(
                                  controller: _purposeController,
                                  decoration: InputDecoration(
                                      labelText: 'Purpose of creating the app'
                                  ),
                                  validator: (String value){
                                    if(value.isEmpty){
                                      return 'this field is required';
                                    }return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Choose a domain that your app fits in'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: _radioBuilder(project: _project),
                              ),
                              ButtonBar(
                                children: [
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  CustomRaisedButton(
                                    title: 'Next',
                                    onPressed: (){
                                      if(_formKey.currentState.validate() && _groupValue != -1){
                                        _project.projectName = _projectNameController.text;
                                        _project.projectDescription = _projectDescriptionController.text;
                                        _project.purpose = _purposeController.text;
                                        _project.domains.elementAt(_groupValue).value = true;
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => ProjectForm(project: _project,)
                                            )
                                        );
                                      }else if(_groupValue == -1){
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          duration: Duration(seconds: 3),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Choose a domain'),
                                          ),
                                        ));
                                      }
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                  Expanded(
                      child: Container(
                        color: Colors.amber,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Craft your apps!!',
                                style: GoogleFonts.droidSerif(fontSize: 20),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height*4/5,
                              width: MediaQuery.of(context).size.width/2,
                              padding: EdgeInsets.all(30),
                              child: Image.network('https://blush.ly/AF0b7Br_E/p', fit: BoxFit.contain,),
                            ),
                          ],
                        ),
                      )
                  )
                ],
              );
            }else{
              return Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                    ),
                    padding: EdgeInsets.only(bottom: 0, top: 50, left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          Text('Hello, there!!', style: GoogleFonts.droidSerif(fontSize: 30),),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                            child: TextFormField(
                              controller: _projectNameController,
                              decoration: InputDecoration(
                                labelText: 'Project Name',
                              ),
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'this field is required';
                                }return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                            child: TextFormField(
                              controller: _projectDescriptionController,
                              decoration: InputDecoration(
                                  labelText: 'Project Description'
                              ),
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'this field is required';
                                }return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                            child: TextFormField(
                              controller: _purposeController,
                              decoration: InputDecoration(
                                  labelText: 'Purpose of creating the app'
                              ),
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'this field is required';
                                }return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Choose a domain that your app fits in'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: _radioBuilder(project: _project),
                          ),
                          ButtonBar(
                            children: [
                              FlatButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              CustomRaisedButton(
                                title: 'Next',
                                onPressed: (){
                                  if(_formKey.currentState.validate() && _groupValue != -1){
                                    _project.projectName = _projectNameController.text;
                                    _project.projectDescription = _projectDescriptionController.text;
                                    _project.purpose = _purposeController.text;
                                    _project.domains.elementAt(_groupValue).value = true;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ProjectForm(project: _project,)
                                        )
                                    );
                                  }else if(_groupValue == -1){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 3),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Choose a domain'),
                                      ),
                                    ));
                                  }
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )
                ),
              );
            }
          },
        )
      ),
    );
  }
}

class CustomRaisedButton extends StatelessWidget {
  String title;
  Function onPressed;
  CustomRaisedButton({this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('$title'),
      color: Colors.blue,
      onPressed: onPressed,
    );
  }
}
