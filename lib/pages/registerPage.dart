import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  final Function() register;
  final Function(String) updateEmail;
  final Function(String) updatePassword;
  final Function(String) updateFirstname;
  final Function(String) updateLastname;
  final Function(BuildContext) navigateToLoginPage;

  const RegisterPage(
      {super.key,
      required this.register,
      required this.updateEmail,
      required this.updatePassword,
      required this.updateFirstname,
      required this.updateLastname,
      required this.navigateToLoginPage});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                  height: constraints.maxHeight * 0.2,
                  padding: const EdgeInsets.all(32),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.registerTitle,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          AppLocalizations.of(context)!.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
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
                          hintText: 'Grzegorz',
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(AppLocalizations.of(context)!.surname,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(17, 45, 48, 1),
                            )),
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Color.fromRGBO(17, 45, 48, 1),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Brzęczyszczykiewicz',
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
                        child: Text('E-mail',
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(AppLocalizations.of(context)!.password,
                            style: const TextStyle(
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
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child:
                            Text(AppLocalizations.of(context)!.confirmPassword,
                                style: const TextStyle(
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
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.register();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 80.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.registerButton,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.haveAccount,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
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
                            onPressed: () {
                              widget.navigateToLoginPage(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.loginButton,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
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
