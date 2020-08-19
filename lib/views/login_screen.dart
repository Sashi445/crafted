import 'package:crafted/services/firebase_auth.dart';
import 'package:crafted/services/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crafted/models/user.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: ResponsiveBuilder(
        builder: (context, screenConstraints){
          if(screenConstraints.deviceScreenType == DeviceScreenType.desktop){
            return Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width/2,
                  child: Stack(
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                          child: Text('One stop for all your business ideas',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vidaloka(fontSize: 40),),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: Image.network('https://blush.ly/QWypql8JV/p'),
                        ),
                      )
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                  width: 7,
                  indent: 80,
                  endIndent: 80,
                ),
                Expanded(
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Text('Crafted!!',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.pacifico(fontSize: 70),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 70),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/3,
                              child: Text(
                                'An open source tool to bring all your ideas into applications.\n'
                                    'With crafted you can turn your business ideas into applications to your desired platforms.\n'
                                    'It has a wide range of designs to choose from and'
                                    'you can build one if you want.\n'
                                    'So why late sign up and take your business idea to everyone out there!!',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.montserrat(fontSize: 25),
                              ),
                            ),
                          ),
                          FloatingActionButton.extended(
                            backgroundColor: Colors.black,
                            onPressed: () async{
                              Auth _auth = Provider.of<Auth>(context, listen: false);
                              User _user = await _auth.signInWithGoogle();
                              DataBase _database = DataBase();
                              await _database.addUser(user: _user);
                            },
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  height: 32,
                                  width: 32,
                                  child: Image.network('https://pluspng.com/img-png/google-logo-png-open-2000.png', fit: BoxFit.fill),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Sign in with Google'),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      )
                  ),
                )
              ],
            );
          }else{
            return Scaffold(
              backgroundColor: Colors.amber,
              appBar: AppBar(
                backgroundColor: Colors.black,
                centerTitle: true,
                title: Text('Crafted', style: GoogleFonts.pacifico(fontSize: 30, color: Colors.white),),
              ),
              body: ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*3/4,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                            child: Text('One stop for all your business ideas',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.vidaloka(fontSize: 30),),
                          ),
                          alignment: Alignment.topCenter,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(50),
                            child: Image.network('https://blush.ly/QWypql8JV/p'),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 3,
                    endIndent: MediaQuery.of(context).size.width/8,
                    indent: MediaQuery.of(context).size.width/8,
                  ),
                  Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 70),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width*3/4,
                              child: Text(
                                'An open source tool to bring all your ideas into applications.\n'
                                    'With crafted you can turn your business ideas into applications to your desired platforms.\n'
                                    'It has a wide range of designs to choose from and'
                                    'you can build one if you want.\n'
                                    'So why late sign up and take your business idea to everyone out there!!',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.montserrat(fontSize: 20),
                              ),
                            ),
                          ),
                          FloatingActionButton.extended(
                            backgroundColor: Colors.black,
                            onPressed: () async{
                              Auth _auth = Provider.of<Auth>(context, listen: false);
                              User _user = await _auth.signInWithGoogle();
                              return _user;
                            },
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  height: 32,
                                  width: 32,
                                  child: Image.network('https://pluspng.com/img-png/google-logo-png-open-2000.png', fit: BoxFit.fill),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Sign in with Google'),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      )
                  ),
                ],
              ),
            );
          }
        },
      )
    );
  }
}
