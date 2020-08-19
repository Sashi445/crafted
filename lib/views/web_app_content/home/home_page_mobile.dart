import 'package:crafted/models/app_data.dart';
import 'package:crafted/services/firebase_auth.dart';
import 'package:crafted/views/commentsection_views/CommentSection.dart';
import 'package:crafted/views/web_app_content/buildappforms/build_app_form_start.dart';
import 'package:crafted/views/web_app_content/download_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:crafted/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class HomePageMobile extends StatefulWidget {
  final User user;
  HomePageMobile({this.user});
  @override
  _HomePageMobileState createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {

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
      CommentSection(),
      DownloadPage()
    ];
    AppData _appData = Provider.of<AppData>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('${_appData.appName}', style: GoogleFonts.pacifico(fontSize: 30),),
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
      body: _bodyWidget.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
              iconSize: 24,
              gap: 8,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              activeColor: Colors.white,
              backgroundColor: Colors.white,
              duration: Duration(milliseconds: 500),
              tabBackgroundColor: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.apps,
                  text: 'Apps',
                ),
                GButton(
                  icon: Icons.border_color,
                  text: 'Comments',
                ),
                GButton(
                  icon: Icons.file_download,
                  text: 'Downloads',
                )
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (int value){
                setState(() {
                  _selectedIndex = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}