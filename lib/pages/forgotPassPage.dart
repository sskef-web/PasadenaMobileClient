import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import '../components/fourDigitCodeInput.dart';
import '../main.dart';
import 'loginPage.dart';
import 'resetPasswordPage.dart';

class ForgotPassPage extends StatefulWidget {
  final Function() login;
  final Function() logout;
  final Function(String) updateEmail;
  final Function(String) updatePassword;
  final Function(String) updateProofCode;
  final Function(BuildContext) navigateToRegisterPage;
  String proofCode;

  ForgotPassPage(
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
  _ForgotPassPage createState() => _ForgotPassPage();
}

class _ForgotPassPage extends State<ForgotPassPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isPasswordVisible = false;
  String email = "";
  String proofCode = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  void updateProofCode(String code) {
    setState(() {
      proofCode = code;
      widget.updateProofCode(proofCode);
      debugPrint('NEW PROOFCODE(NOT WIDGET) = ${proofCode}');
    });
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          key: widget.key,
          login: widget.login,
          logout: widget.logout,
          updateEmail: widget.updateEmail,
          updateProofCode: widget.updateProofCode,
          updatePassword: widget.updatePassword,
          proofCode: widget.proofCode,
          navigateToRegisterPage: widget.navigateToRegisterPage,
        ),
      ),
    );
  }

  void navigateToResetPasswordPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordPage(
          key: widget.key,
          login: widget.login,
          logout: widget.logout,
          updateEmail: widget.updateEmail,
          updateProofCode: widget.updateProofCode,
          updatePassword: widget.updatePassword,
          proofCode: proofCode,
          navigateToRegisterPage: widget.navigateToRegisterPage,
          email: email,
        ),
      ),
    );
  }

  bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  void ProofCode() {
    sendProofCode(email);
    showProofCodeDialog(context);
  }

  Future<void> sendProofCodeAndEmail(String email, String proofCode) async {
    var url = Uri.parse('${baseURL}auth/validate_proof_code');

    var body = jsonEncode({
      'email': email,
      'proofCode': int.parse(proofCode),
    });

    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      navigateToResetPasswordPage(context);
    }
    else {
      throw response.body;
    }
  }

  Future<void> sendProofCode(String email) async {
    var url = Uri.parse('${baseURL}auth/send_proof_code');

    var body = jsonEncode(
      email,
    );

    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      debugPrint('code send to $email');
    }
    else {
      throw response.body;
    }
  }

  void showProofCodeDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff112d30),
                  Color(0xff112d30),
                  Color(0xff044f4b),
                  Color(0xff015651),
                ],
                stops: [0.03, 0.27, 0.86, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ), borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text (AppLocalizations.of(context)!.emailConfirm, textAlign: TextAlign.center, textScaler: const TextScaler.linear(1.2)),
                Text ('${AppLocalizations.of(context)!.codeSent} - \n$email', textAlign: TextAlign.center,),
                const SizedBox(height: 16.0),
                FourDigitCodeInput(updateProofCode: updateProofCode),
                const SizedBox(height: 16.0,),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (proofCode.length == 4)
                      {
                        sendProofCodeAndEmail(email, proofCode);
                        debugPrint("true ==========!");
                      }
                      else
                      {
                        Navigator.of(dialogContext).pop();
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Text(AppLocalizations.of(context)!.errorCode),
                        );
                        debugPrint("false ==========!");
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(1, 86, 81, 1),
                    foregroundColor: Colors.white
                  ),
                  child: Text(AppLocalizations.of(context)!.send),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Text (
                            AppLocalizations.of(context)!.codeAbout,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                              color: Color.fromRGBO(168, 168, 168, 1)
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      const SizedBox(height: 64.0),
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
                              email = value;
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
                        const SizedBox(height: 128.0),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ElevatedButton(
                            onPressed:() {
                              isEmailValid ? ProofCode() : null;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isEmailValid
                                  ? const Color.fromRGBO(1, 86, 81, 1)
                                  : const Color.fromRGBO(
                                  127, 127, 127, 0.5),
                              minimumSize: const Size(double.infinity, 70.0),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.sendCode,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: isEmailValid ? Colors.white : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.haveAccount,
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
                                navigateToLoginPage(context);
                              },
                              child: Text(
                                "${AppLocalizations.of(context)!.loginButton}!",
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
