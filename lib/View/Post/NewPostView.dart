import 'package:flutter/material.dart';
import 'package:netart/Services/PostService.dart';

class NewPostView extends StatefulWidget {
  @override
  _NewPostViewState createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  FocusNode contentFocus;

  @override
  void initState() {
    super.initState();
    contentFocus = FocusNode();
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SafeArea(
        child: Column(children: <Widget>[
          Text(
            "Create a new post",
            style: TextStyle(fontSize: 50),
          ),
          TitleInput(
            controller: this.titleController,
            nextFocus: this.contentFocus,
          ),
          ContentInput(
            contentController: this.contentController,
            focusNode: this.contentFocus,
            titleController: this.titleController,
            formKey: this._formKey,
          ),
          PostSubmitButton(
              formKey: this._formKey,
              contentController: this.contentController,
              titleController: this.titleController),
        ]), // Column
      ), //safeArea
    ));
  }
}

class TitleInput extends StatelessWidget {
  const TitleInput({
    Key key,
    this.controller,
    this.nextFocus,
  }) : super(key: key);
  final controller;
  final nextFocus;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Title",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter a Title to create your post";
            }
            return null;
          },
          onEditingComplete: () => nextFocus.requestFocus,
        ), // textFormField
      ), // padding
    ); // expanded
  }
}

class ContentInput extends StatelessWidget {
  const ContentInput({
    Key key,
    this.titleController,
    this.contentController,
    this.formKey,
    this.focusNode,
  }) : super(key: key);
  final titleController;
  final contentController;
  final formKey;
  final focusNode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: contentController,
          focusNode: this.focusNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Content",
          ),
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter a Title to create your post";
            }
            return null;
          },
          onEditingComplete: () => PostSender.send(
              context, formKey, titleController, contentController),
        ), // textFormField
      ), // padding
    ); // expanded
  }
}

class PostSubmitButton extends StatelessWidget {
  const PostSubmitButton({
    Key key,
    this.titleController,
    this.contentController,
    this.formKey,
  }) : super(key: key);
  final titleController;
  final contentController;
  final formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            child: RaisedButton(
              onPressed: () => PostSender.send(
                  context, formKey, titleController, contentController),
              color: Colors.grey,
              child: Text('Post'),
            )),
      ),
    );
  }
}
