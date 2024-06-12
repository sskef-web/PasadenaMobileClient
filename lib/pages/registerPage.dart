import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {

  RegisterPage({
    super.key
  });

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
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
        child: Text('Register'),
      ),
    );
  }


}