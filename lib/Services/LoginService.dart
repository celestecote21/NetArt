import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:netart/Services/ApiConnectService.dart';

class Login {
  static login (context, formKey, usernameController, passwordController) {
    if (formKey.currentState.validate()) {
      var postJson = {
        "Username": usernameController.text, // put the mail all in lower case
        "Password": passwordController.text
      };
      Provider.of<ApiConnect>(context, listen: false)
          .post("home/login", body: postJson)
          .then((jsonResponse) {
        if (jsonResponse["token"] != null) {
          Provider.of<ApiConnect>(context, listen: false).addToken(jsonResponse["token"]);
          Navigator.pushNamed(context, '/');
        } else {
          var errorMess = jsonResponse["message"] != null ? jsonResponse["message"] : "Invalid connection";
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMess)
            )
          );
        }
      });
    }
  }
}