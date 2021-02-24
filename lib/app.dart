import 'package:netart/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:netart/Services/ApiConnectService.dart';
import 'package:netart/View/HomeScreen.dart';
import 'package:netart/View/LoginView.dart';
import 'package:netart/View/SignUpView.dart';
import 'package:netart/View/Post/NewPostView.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ApiConnect(storage),
        child: MaterialApp(
          routes: {
            '/': (BuildContext context) => HomeScreen(),
            '/login': (BuildContext context) => LoginPage(),
            '/signUp': (BuildContext context) => SignUpView(),
            '/newPost': (BuildContext context) => NewPostView(),
          },
        ));
  }
}
