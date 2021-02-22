import 'package:flutter/material.dart';
import 'package:netart/Models/Post.dart';
import 'package:netart/View/Post/PostView.dart';

class PostPreview extends StatefulWidget {
  final Post post;

  PostPreview(this.post);

  @override
  _PostPreviewState createState() => _PostPreviewState(post);
}

class _PostPreviewState extends State<PostPreview> {
  Post post;
  _PostPreviewState(this.post);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostView(post)));
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.black54,
        ),
        padding: EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Text(
                "${post.username}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  "${post.title}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            text:
                TextSpan(text: post.body, style: TextStyle(color: Colors.grey)),
            maxLines: 5,
            overflow: TextOverflow.fade,
          ),
          // Text("${post.body}"),
        ]),
      ),
    );
  }
}
