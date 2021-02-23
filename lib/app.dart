import 'package:netart/View/LoginView.dart';
import 'package:netart/View/Post/PostView.dart';
import 'package:netart/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:netart/Services/ApiConnectService.dart';
import 'package:netart/View/HomeScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ApiConnect(storage),
        child: MaterialApp(
          routes: {
            '/': (BuildContext context) => HomeScreen(),
            '/login': (BuildContext context) => LoginPage(),
            '/newPost': (BuildContext context) => NewPostView(),
          },
        ));
  }
}
