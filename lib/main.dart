import 'package:crafted/models/app_data.dart';
import 'package:crafted/services/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crafted/views/root_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppData>(
      create: (context) => AppData(),
      child: StartingPage()
    );
  }
}

class StartingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Root()
      ),
    );
  }
}


