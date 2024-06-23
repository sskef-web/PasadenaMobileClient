import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function() login;
  final Function(String) updateEmail;
  final Function(String) updatePassword;

  LoginPage({
    super.key,
    required this.login,
    required this.updateEmail,
    required this.updatePassword
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toRegister() {

  }

  void forgotPass() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value)=>widget.updateEmail(value),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
              obscureText: !_showPassword,
              onChanged: (value)=>widget.updatePassword(value),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: widget.login(),
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    forgotPass();
                  },
                  child: Text('Забыли пароль?'),
                ),
                TextButton(
                  onPressed: () {
                    toRegister();
                  },
                  child: Text('Регистрация'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}