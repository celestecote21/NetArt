import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:netart/Services/ApiConnectService.dart';
import 'package:netart/View/Post/PostListView.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isConnect = false;

  @override
  Widget build(BuildContext context) {
    if (isConnect == false) {
      Provider.of<ApiConnect>(context, listen: false)
          .isNotConnect()
          .then((notC) {
        if (notC) {
          Navigator.pushNamed(context, '/login').then((connec) {
            setState(() => isConnect = connec);
          });
        } else {
          setState(() => isConnect = true);
        }
      });
    }
    return Scaffold(
      body: PostListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/newPost'),
        tooltip: 'Create a post',
        child: Icon(Icons.add),
        mini: true,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 30.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
