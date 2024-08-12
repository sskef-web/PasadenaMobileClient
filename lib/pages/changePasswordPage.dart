import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pasadena_mobile_client/pages/authenticationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class ChangePasswordPage extends StatefulWidget {
  final Function() logout;
  String proofCode;
  String email;

  ChangePasswordPage(
      {
        super.key,
        required this.logout,
        required this.proofCode,
        required this.email
      });

  @override
  _ChangePasswordPage createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordValid = false;
  bool isConfirmedPasswordValid = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isPasswordConfirmed = false;
  String password = '';

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool validatePassword(String password) {
    if (password.length >= 6) {
      return true;
    }
    return false;
  }

  void changePassword() {
    navigateBackPage(context);
  }

  void navigateBackPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthenticationPage(),
      ),
    );
  }

  Future<void> _changePassword(String email, String password) async {
    var url = Uri.parse('${baseURL}auth/change_password');

    var body = jsonEncode({
      'emailAndProof': {
        'email': email,
        'proofCode': widget.proofCode
      },
      'password': password
    });
    var response = await http.patch(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      debugPrint('${response.body}\n ${response.statusCode}');
      // LOGOUT ----
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //await prefs.setBool('isLoggedIn', false);
      navigateBackPage(context);
    }
    else {
      debugPrint('${response.body}\n ${response.statusCode}');
    }
  }

  bool validateEmail(String email) {
    return EmailValidator.validate(email);
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
                      AppLocalizations.of(context)!.recoveryPass,
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
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Text (
                            AppLocalizations.of(context)!.recoveryPassAbout,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w100,
                                color: Color.fromRGBO(168, 168, 168, 1)
                            ),
                            textAlign: TextAlign.center,
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
                            bool isValid = validatePassword(value);
                            setState(() {
                              password = value;
                              isPasswordValid = isValid;
                              //isPasswordConfirmed = password != value
                              if (password == value) {
                                isPasswordConfirmed = true;
                              }
                              else {
                                isPasswordConfirmed = false;
                              }
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                              AppLocalizations.of(context)!.confirmPassword,
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
                          obscureText: !isConfirmPasswordVisible,
                          onChanged: (value) {
                            setState(() {
                              isConfirmedPasswordValid = password == value && validatePassword(value) && password != value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: '••••••',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                            ),
                            enabledBorder: isConfirmedPasswordValid && isPasswordConfirmed ? const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(1, 86, 81, 1),
                              ),
                            ) : const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(173, 0, 0, 1),
                              ),
                            ),
                            focusedBorder: isConfirmedPasswordValid && isPasswordConfirmed ? const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(1, 86, 81, 1),
                              ),
                            ) : const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(173, 0, 0, 1),
                              ),
                            ),
                            suffixIcon: isConfirmedPasswordValid && isPasswordConfirmed
                                ? IconButton(
                              icon: Icon(
                                isConfirmPasswordVisible && isPasswordConfirmed ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                color: const Color.fromRGBO(1, 86, 81, 1),
                              ),
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                                });
                              },
                            )
                                : const Icon(
                              Icons.clear,
                              color: Color.fromRGBO(173, 0, 0, 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ElevatedButton(
                            onPressed:() {
                              isPasswordValid && isConfirmedPasswordValid ? _changePassword(widget.email, password) : null;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isPasswordValid && isConfirmedPasswordValid
                                  ? const Color.fromRGBO(1, 86, 81, 1)
                                  : const Color.fromRGBO(
                                  127, 127, 127, 0.5),
                              minimumSize: const Size(double.infinity, 70.0),
                            ),
                            child: Text(
                                AppLocalizations.of(context)!.continued,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: isPasswordValid && isConfirmedPasswordValid ? Colors.white : Colors.white,
                                )
                            ),
                          ),
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
