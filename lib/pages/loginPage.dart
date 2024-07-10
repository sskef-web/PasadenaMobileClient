import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'forgotPassPage.dart';

class LoginPage extends StatefulWidget {
  final Function() login;
  final Function() logout;
  final Function(String) updateEmail;
  final Function(String) updatePassword;
  final Function(String) updateProofCode;
  final Function(BuildContext) navigateToRegisterPage;
  String proofCode;

  LoginPage(
      {
        super.key,
        required this.login,
        required this.logout,
        required this.updateEmail,
        required this.updatePassword,
        required this.updateProofCode,
        required this.navigateToRegisterPage,
        required this.proofCode
      });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void forgotPass() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPassPage(
            key: widget.key,
            login: widget.login,
            logout: widget.logout,
            updateEmail: widget.updateEmail,
            updatePassword: widget.updatePassword,
            updateProofCode: widget.updateProofCode,
            navigateToRegisterPage: widget.navigateToRegisterPage,
            proofCode: widget.proofCode,
          ),
        ),
      );
  }

  bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  bool validatePassword(String password) {
    if (password.length >= 6) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(17, 45, 48, 1),
              Color.fromRGBO(1, 86, 81, 1),
            ],
            stops: [0.0, 0.5],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
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
                      AppLocalizations.of(context)!.loginTitle,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
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
                          onChanged: (value) {
                            widget.updateEmail(value);
                            bool isValid = validateEmail(value);
                            setState(() {
                              isEmailValid = isValid;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Poczta@gmail.com',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                            ),
                            enabledBorder: isEmailValid ? const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(1, 86, 81, 1),
                              ),
                            ) : const UnderlineInputBorder(
                              borderSide: BorderSide(
                              color: Color.fromRGBO(173, 0, 0, 1),
                              ),
                            ),
                            focusedBorder: isEmailValid ? const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(1, 86, 81, 1),
                              ),
                            ) : const UnderlineInputBorder(
                              borderSide: BorderSide(
                              color: Color.fromRGBO(173, 0, 0, 1),
                              ),
                            ),
                            suffixIcon: isEmailValid
                                ? const Icon(
                              Icons.check,
                              color: Color.fromRGBO(1, 86, 81, 1),
                            )
                                : const Icon(
                              Icons.clear,
                              color: Color.fromRGBO(173, 0, 0, 1),
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
                          obscureText: !isPasswordVisible,
                          onChanged: (value) {
                            widget.updatePassword(value);
                            bool isValid = validatePassword(value);
                            setState(() {
                              isPasswordValid = isValid;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: '••••••',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                            ),
                            enabledBorder: isPasswordValid ? const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(1, 86, 81, 1),
                              ),
                            ) : const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(173, 0, 0, 1),
                              ),
                            ),
                            focusedBorder: isPasswordValid ? const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(1, 86, 81, 1),
                              ),
                            ) : const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(173, 0, 0, 1),
                              ),
                            ),
                            suffixIcon: isPasswordValid
                                ? IconButton(
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                color: const Color.fromRGBO(1, 86, 81, 1),
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            )
                                : const Icon(
                              Icons.clear,
                              color: Color.fromRGBO(173, 0, 0, 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                forgotPass();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w100,
                                  color: Color.fromRGBO(17, 45, 48, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32.0),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ElevatedButton(
                            onPressed:() {
                              isPasswordValid && isEmailValid ? widget.login() : null;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isPasswordValid && isEmailValid
                                  ? const Color.fromRGBO(1, 86, 81, 1)
                                  : const Color.fromRGBO(
                                  127, 127, 127, 0.5),
                              minimumSize: const Size(double.infinity, 70.0),
                            ),
                            child: Text(
                                AppLocalizations.of(context)!.loginButton,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: isPasswordValid && isEmailValid ? Colors.white : Colors.white,
                                )
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.noAccount,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w100,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                                minimumSize: WidgetStateProperty.all<Size>(Size.zero),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                widget.navigateToRegisterPage(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.noAccountText,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
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
      ),
    );
  }
}
