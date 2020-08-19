import 'package:crafted/blocs/welcome_page_bloc.dart';
import 'package:crafted/services/firebase_auth.dart';
import 'package:crafted/views/web_app_content/main_page.dart';
import 'package:crafted/views/login_screen.dart';
import 'package:crafted/models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  WelcomeBloc welcomeBloc = WelcomeBloc();

  @override
  void initState(){
    welcomeBloc.screenChanger();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        initialData: false,
          stream: welcomeBloc.screenController,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: AnimatedCrossFade(
                crossFadeState: snapshot.data ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 1000),
                firstChild: Container(
                  height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: FirstChild()),
                secondChild: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SecondPage(),
                ),
              ),
            );
          }return Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}

class FirstChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text('Crafted', style: GoogleFonts.pacifico(fontSize: 50, color: Colors.white),),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<Auth>(context).isSignedIn,
      builder: (context, snapshot){
        User _user = snapshot.data;
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.amber,),);
        }
        else if(snapshot.connectionState == ConnectionState.active && _user == null){
          return LoginScreen();
        }else if(_user!=null && snapshot.connectionState == ConnectionState.active){
          return MyCraftedLandingPage();
        }
        else if(snapshot.hasError){
          return Center(child: Text('${snapshot.error}'),);
        }return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}


