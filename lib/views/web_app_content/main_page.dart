import 'package:crafted/services/firebase_auth.dart';
import 'package:crafted/services/firebase_cloud_firestore.dart';
import 'package:crafted/views/web_app_content/home/home_page_desktop.dart';
import 'package:crafted/views/web_app_content/home/home_page_mobile.dart';
import 'package:flutter/material.dart';
import 'package:crafted/models/user.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyCraftedLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    Auth _auth = Provider.of<Auth>(context, listen: false);
    return Provider<DataBase>(
      create: (context) => DataBase(),
      child: FutureBuilder(
        future: _auth.getCurrentUser(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            User _user = snapshot.data;
            return ResponsiveBuilder(
              builder: (context, screenLayout){
                if(screenLayout.deviceScreenType == DeviceScreenType.mobile){
                  return HomePageMobile(user: _user,);
                }else{
                  return HomePageDesktop(user: _user,);
                }
              },
            );
          }else if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}



