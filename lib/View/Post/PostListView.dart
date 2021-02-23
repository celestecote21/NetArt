import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:netart/Services/ApiConnectService.dart';
import 'package:netart/View/Post/PostPreviewView.dart';
import 'package:provider/provider.dart';
import 'package:netart/Models/Post.dart';
import 'package:netart/View/Post/PostView.dart';

class PostListView extends StatefulWidget {
  @override
  _PostListViewState createState() => _PostListViewState("post/top");
}

class _PostListViewState extends State<PostListView> {
  int nbrTile = 0;
  final List<Widget> tilesBaseLists = [];
  String url;
  List<Post> listPost = [];
  bool complet = false;

  _PostListViewState(String url) {
    this.url = url;
  }

  @override
  void initState() {
    super.initState();
    try {
      Provider.of<ApiConnect>(context, listen: false).get(this.url + "/100").then((res) {
        res.forEach((json) {
          this.listPost.add(Post.fromJson(json));
          this.nbrTile++;
        });
        setState(() {
          complet = true;
        });
      });
    }
    catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    // in wait of the network we have a nice animation
    if (!complet) {
      return Center(
          child: SpinKitWave(
        color: Colors.red,
        size: 50,
      ));
    }
    //else we return a customScrollView

    const Key centerKey = ValueKey('bottom-sliver-list');

    return CustomScrollView(
      center: centerKey,
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Last Posts'),
        ),
        SliverList(
          key: centerKey,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index % 2 == 0) {
                return Divider();
              } else {
                return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: PostPreview(listPost[index ~/ 2]));
              }
            },
            childCount: nbrTile * 2,
          ),
        ),
      ],
    );
  }
}
