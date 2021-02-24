import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:netart/Services/ApiConnectService.dart';

class PostSender {
  static send(context, formKey, titleController, contentController) {
    if (formKey.currentState.validate()) {
      var username = Provider.of<ApiConnect>(context, listen: false).getUser();
      var postJson = {
        "username": username,
        "title": titleController.text,
        "content": contentController.text,
        "fileType": "none",
      };
      Provider.of<ApiConnect>(context, listen: false)
          .post("post/newPost", body: postJson)
          .then((jsonResponse) {
        if (jsonResponse["message"] != null) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(jsonResponse["message"])));
          // Navigator.pushNamed(context, "/");
          Navigator.pop(context, true);
        }
        Navigator.pop(context, true);
        //Navigator.pushNamed(context, "/");
      });
    }
  }
}
