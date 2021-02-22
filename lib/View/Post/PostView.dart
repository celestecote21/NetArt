import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netart/Models/Post.dart';

class PostView extends StatelessWidget {
  final Post post;

  PostView(this.post);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              tooltip: "back",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: BodyPostView(post)),
    );
  }
}

class BodyPostView extends StatefulWidget {
  final Post post;

  BodyPostView(this.post);

  @override
  _BodyPostView createState() => _BodyPostView(post);
}

class _BodyPostView extends State<BodyPostView> {
  final Post post;

  _BodyPostView(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all((10)),
      child: ListView(
        children: <Widget>[
          Header(),
          Text(
            post.title,
            textScaleFactor: 2,
            textAlign: TextAlign.center,
          ),
          Divider(),
          Text(
            post.body,
          ),
          Divider(),
          ShareBarePost(post),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'https://picsum.photos/250?image=9',
            imageBuilder: (context, imageProvider) => Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
          ),
          SizedBox(
            width: 16,
          ),
          Text("categorie"),
          SizedBox(
            width: 16,
          ),
          Text("username"),
        ],
      ),
    );
  }
}

class ShareBarePost extends StatefulWidget {
  final Post post;

  ShareBarePost(this.post);

  @override
  _ShareBarePost createState() => _ShareBarePost(post);
}

class _ShareBarePost extends State<ShareBarePost> {
  final Post post;

  _ShareBarePost(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Icon(Icons.share),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
            child: Icon(Icons.home),
          ),
        ],
      ),
    );
  }
}
