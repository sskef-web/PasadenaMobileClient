import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function() login;
  final Function(String) updateEmail;
  final Function(String) updatePassword;

  const LoginPage(
      {super.key,
      required this.login,
      required this.updateEmail,
      required this.updatePassword});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toRegister() {}

  void forgotPass() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: constraints.maxWidth * 0.4,
                  height: constraints.maxHeight * 0.2,
                  padding: const EdgeInsets.all(32),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Witaj, zaloguj się!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'E-mail',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(17, 45, 48, 1),
                          ),
                        ),
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Color.fromRGBO(17, 45, 48, 1),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Poczta@gmail.com',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(17, 45, 48, 1),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(17, 45, 48, 1),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(17, 45, 48, 1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text('Hasło',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(17, 45, 48, 1),
                            )),
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Color.fromRGBO(17, 45, 48, 1),
                        ),
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: '••••••',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(17, 45, 48, 1),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(17, 45, 48, 1),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(17, 45, 48, 1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Zapomniałeś hasła?',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(17, 45, 48, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity,80.0),
                          ),
                          child: const Text(
                            'Zaloguj się',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              'Nie masz konta?',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Zarejestruj się',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(17, 45, 48, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
