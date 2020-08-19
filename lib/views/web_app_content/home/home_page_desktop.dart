import 'package:crafted/views/commentsection_views/CommentSection.dart';
import 'package:crafted/views/web_app_content/buildappforms/build_app_form_start.dart';
import 'package:crafted/views/web_app_content/download_page.dart';
import 'package:flutter/material.dart';
import 'package:crafted/models/user.dart';
import 'package:crafted/services/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageDesktop extends StatefulWidget {
  final User user;
  HomePageDesktop({this.user});
  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _bodyWidget = [
      BuildAppStartPage(user: widget.user,),
      Container(
        child: Center(
          child: Text('This previews page of site is under construction, sorry for the inconvenience!!', style: GoogleFonts.varelaRound(fontSize: 20),),
        ),
      ),
      DownloadPage(),
      CommentSection(),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Crafted', style: GoogleFonts.pacifico(color: Colors.white, fontSize: 30),),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(widget.user.photoUrl, fit: BoxFit.contain,)),
              ),
            ),
            Text('Hello, '
                '${widget.user.displayName}', style: GoogleFonts.varelaRound(fontSize: 30),),
            FlatButton(
              onPressed: (){

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('SETTINGS', style: TextStyle(color: Colors.black), ),
                  SizedBox(width: 10,),
                  Icon(Icons.settings, color: Colors.black,)
                ],
              ),
            ),
            FlatButton(
              onPressed: () async{
                Auth auth =  Provider.of<Auth>(context, listen: false);
                return await auth.signOut();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LOGOUT'),
                  SizedBox(width: 10,),
                  Icon(Icons.power_settings_new, color: Colors.black,)
                ],
              ),
            )
          ],
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.transparent,
            labelType: NavigationRailLabelType.selected,
            selectedIndex: _selectedIndex,
            destinations: [
              NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home', style: TextStyle(color: Colors.black),)
              ),
              NavigationRailDestination(
                  icon: Icon(Icons.apps),
                  label: Text('Apps')
              ),
              NavigationRailDestination(
                  icon: Icon(Icons.file_download),
                  label: Text('Downloads', style: TextStyle(color: Colors.blue),)
              ),
              NavigationRailDestination(
                  icon: Icon(Icons.border_color),
                  label: Text('Comment', style: TextStyle(color: Colors.blue),)
              )
            ],
            onDestinationSelected: (int value){
              setState(() {
                _selectedIndex = value;
              });
            },
          ),
          Expanded(
              child: _bodyWidget.elementAt(_selectedIndex)
          )
        ],
      ),
    );
  }
}