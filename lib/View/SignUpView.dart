import 'package:flutter/material.dart';
import 'package:netart/Services/ApiConnectService.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpViewIntern(),
    );
  }
}

class SignUpViewIntern extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpViewIntern> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  FocusNode passwordFocus;
  FocusNode lastNameFocus;
  FocusNode userNameFocus;
  FocusNode emailFocus;

  @override
  void initState() {
    super.initState();
    passwordFocus = FocusNode();
    lastNameFocus = FocusNode();
    userNameFocus = FocusNode();
    emailFocus = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    userNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      var postJson = {
        "username": userNameController.text, // put the mail all in lower case
        "password": passwordController.text,
        "email": emailController.text.toLowerCase(),
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
      };
      print(postJson.toString());
      try {
        Provider.of<ApiConnect>(context, listen: false)
            .post("home/signUp", body: postJson)
            .then((jsonResponse) {
          print(jsonResponse);
          if (jsonResponse["token"] != null) {
            print("sign_up ok");
            Provider.of<ApiConnect>(context, listen: false).addToken(jsonResponse["token"]);
            Navigator.pop(context, true);
          } else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(jsonResponse["message"]),
              )
            );
          }
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  'Sign-Up',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            nameWidget(),
            userNameWidget(),
            emailWidget(),
            passwordWidget(),
            buttonWidget(),
          ], // children
        ), //column
      ), //SafeArea
    ); // Form
  }

  /*
        to have somthing a little more readable each line in the column is the widget return by
        his corresponding fonction
    */
  Widget nameWidget() {
    return Expanded(
      child: Center(
        child: Row(
          children: <Widget>[
            //FIRST NAME
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: firstNameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please enter your first name';
                    }
                    return null;
                  },
                  onEditingComplete: () => lastNameFocus.requestFocus(),
                ), //textFormField
              ), //padding
            ), //expanded

            // LAST NAME
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: lastNameController,
                  focusNode: lastNameFocus,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please enter your first name';
                    }
                    return null;
                  },
                  onEditingComplete: () => userNameFocus.requestFocus(),
                ), //textFormField
              ), //padding
            ), //expanded
          ], //children
        ), //row
      ), // center
    ); //expanded
  }

  Widget userNameWidget() {
    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: userNameController,
            focusNode: userNameFocus,
            autocorrect: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Username'),
            validator: (value) {
              if (value.isEmpty) {
                return 'please enter your username';
              }
              //TODO: test on the server is there is the same username
              return null;
            },
            onEditingComplete: () => emailFocus.requestFocus(),
          ), //TextFormField
        ), //padding
      ), //center
    ); //expanded
  }

  Widget emailWidget() {
    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: emailController,
            focusNode: emailFocus,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
            validator: (value) {
              //test if there is really somthing in the field
              if (value.isEmpty) {
                return 'please enter your email';
              }
              // test if it's a valide e-mail
              if (!value.contains('@')) {
                return 'please enter a valide e-mail';
              }
              return null;
            },
            onEditingComplete: () => passwordFocus.requestFocus(),
          ), //TextFormField
        ), //padding
      ), //center
    ); //expanded
  }

  Widget passwordWidget() {
    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: passwordController,
            focusNode: passwordFocus,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'please enter your password';
              }
              return null;
            },
            onEditingComplete: () => submit(),
          ), // formTextField
        ), //padding
      ), //center
    ); //expanded
  }

  Widget buttonWidget() {
    return Expanded(
      child: Center(
        child: Row(
          children: <Widget>[
            //login button
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: RaisedButton(
                  onPressed: () => submit(),
                  child: Text('Sign-up'),
                ), // RaisedButton
              ), // padding
            ), // expanded
            // sign-up button
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: RaisedButton(
                  onPressed: () => Navigator.pushNamed(context, "/signUp"),
                  color: Colors.grey,
                  child: Text('Login'),
                ), //RaisedButton
              ), //Padding
            ), //Expanded
          ], //children
        ), //Row
      ), //Center
    ); //expanded
  }
}