import 'package:pasadena_mobile_client/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  LoginPage({
    super.key
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: true,
      ),
      // REMOVE CONST ON PADDING
      // REMOVE CONST ON PADDING
      // REMOVE CONST ON PADDING
      // REMOVE CONST ON PADDING
      // REMOVE CONST ON PADDING
      // REMOVE CONST ON PADDING
      //    -----
      body: const Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login'),
          ],
        ),
      ),
    );
  }
}