import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:netart/Services/ApiConnectService.dart';
import 'package:netart/Services/LoginService.dart';
import 'package:netart/View/SignUpView.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Login Text
            Expanded(
                child: Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 50),
              ),
            )),
            EmailInput(
              controller: this.userNameController,
              nextFocus: this.passwordFocus
            ),
            PasswordInput(
              usernameController: this.userNameController,
              passwordController : this.passwordController,
              formKey: this._formKey,
              focusNode: this.passwordFocus
            ),
            FinalButton(
              usernameController: this.userNameController,
              passwordController : this.passwordController,
              formKey: this._formKey,
            ),
          ],
        ),
      ),
    );
  }

}

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key key,
    this.controller,
    this.nextFocus,
  }) : super(key: key);
  final controller;
  final nextFocus;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: controller,
            autofocus: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
            validator: (value) {
              //test if there is really somthing in the field
              if (value.isEmpty) {
                return 'please enter your username';
              }
              // test if it's a valide e-mail
              return null;
            },
            onEditingComplete: () => nextFocus.requestFocus(),
          ),
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {

  const PasswordInput({
    Key key,
    this.usernameController,
    this.passwordController,
    this.formKey,
    this.focusNode,
  }) : super(key: key);
  final usernameController;
  final passwordController;
  final formKey;
  final focusNode;

  void goRestore(BuildContext context) {
    Navigator.pushNamed(context, '/restore').then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: Column(
              children: <Widget>[
                //password field
                TextFormField(
                  controller: passwordController,
                  focusNode: focusNode,
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
                  onEditingComplete: () => Login.login(context, formKey, usernameController, passwordController),
                ),
                // Password Restore
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'recover your password',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  onTap: () => this.goRestore(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class FinalButton extends StatelessWidget {

  const FinalButton({
    Key key,
    this.usernameController,
    this.passwordController,
    this.formKey,
  }) : super(key: key);
  final usernameController;
  final passwordController;
  final formKey;

  void goSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/signup').then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Row(
          children: <Widget>[
            //login button
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: RaisedButton(
                  onPressed: () => Login.login(context, formKey, usernameController, passwordController),
                  child: Text('Login'),
                ),
              ),
            ),
            // sign-up button
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: RaisedButton(
                  onPressed: () => this.goSignUp(context),
                  color: Colors.grey,
                  child: Text('Sign-up'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}