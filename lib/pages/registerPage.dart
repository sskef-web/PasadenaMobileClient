import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/fourDigitCodeInput.dart';
import '../main.dart';

class RegisterPage extends StatefulWidget {
  final Function() register;
  final Function(String) updateEmail;
  final Function(String) updatePassword;
  final Function(String) updateNameSurname;
  final Function(String) updateProofCode;
  final Function(BuildContext) navigateToLoginPage;
  String proofCode = "";
  String email = "";

  RegisterPage(
      {super.key,
      required this.register,
      required this.updateEmail,
      required this.updatePassword,
      required this.updateNameSurname,
      required this.updateProofCode,
      required this.navigateToLoginPage,
      required this.proofCode,
      required this.email});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isConfirmedPasswordValid = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isPasswordConfirmed = false;
  bool isNameSurnameValid = false;
  bool isEmailProofed = false;
  String password = "";
  String email = "";
  String proofCode = "";

  bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  bool validatePassword(String password) {
    if (password.length >= 6) {
      return true;
    }
    return false;
  }

  bool validateNameSurname(String fullName) =>
      fullName.split(' ').length == 2 &&
      fullName.split(' ')[0].length >= 2 &&
      fullName.split(' ')[1].length >= 3;

  void showResultDialog(BuildContext context, bool isValidate) async {
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
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            isValidate != false ?
            Text(AppLocalizations.of(context)!.emailConfirmed, textAlign: TextAlign.center,) : Text (AppLocalizations.of(context)!.errorCode, textAlign: TextAlign.center),
          const SizedBox(height: 16.0,),
          Row (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 8.0,),
              isValidate == false ? ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  showProofCodeDialog(context, widget.email);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(1, 86, 81, 1),
                    foregroundColor: Colors.white),
                child: Center (child: Text(AppLocalizations.of(context)!.retry)),
              ) : ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  if (isValidate == true) {
                    widget.register();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(1, 86, 81, 1),
                    foregroundColor: Colors.white),
                child: Center (child: Text(AppLocalizations.of(context)!.continued)),
              ),
              ],
            ),
        ],
            ),
        ),
        );
      },
    );
  }

  Future<void> sendProofCodeAndEmail(String email, String proofCode) async {
    var url = Uri.parse('${baseURL}auth/validate_proof_code');

    var body = jsonEncode({
      'emailAddress': email,
      'proofCode': proofCode,
    });

    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      setState(() {
        isEmailProofed == true;
      });
      showResultDialog(context, true);
    }
    else {
      showResultDialog(context, false);
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

  void sendingCode() {
    sendProofCode(widget.email);
    showProofCodeDialog(context, widget.email);
  }

  void _updateProofCode(String value) {
    setState(() {
      widget.updateProofCode(value);
      proofCode = value;
    });
  }

  void showProofCodeDialog(BuildContext context, String email) async {
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
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.emailConfirm,
                    textAlign: TextAlign.center,
                    textScaler: const TextScaler.linear(1.2)),
                Text(
                  '${AppLocalizations.of(context)!.codeSent} - \n$email',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                FourDigitCodeInput(updateProofCode: _updateProofCode),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (proofCode.length == 4) {
                        sendProofCodeAndEmail(email, proofCode);
                        debugPrint("true ==========!");
                      } else {
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
                      foregroundColor: Colors.white),
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
                      AppLocalizations.of(context)!.registerTitle,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                          child: Text(AppLocalizations.of(context)!.nameSurname,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(17, 45, 48, 1),
                              )),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            widget.updateNameSurname(value);
                            bool isValid = validateNameSurname(value);
                            setState(() {
                              isNameSurnameValid = isValid;
                            });
                          },
                          style: const TextStyle(
                            color: Color.fromRGBO(17, 45, 48, 1),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Grzegorz Brzęczyszczykiewicz',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                            ),
                            enabledBorder: isNameSurnameValid
                                ? const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(1, 86, 81, 1),
                                    ),
                                  )
                                : const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(173, 0, 0, 1),
                                    ),
                                  ),
                            focusedBorder: isNameSurnameValid
                                ? const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(1, 86, 81, 1),
                                    ),
                                  )
                                : const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(173, 0, 0, 1),
                                    ),
                                  ),
                            suffixIcon: isNameSurnameValid
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
                          onChanged: (value) {
                            bool isValid = validateEmail(value);
                            setState(() {
                              isEmailValid = isValid;
                              widget.updateEmail(value);
                              email = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Poczta@gmail.com',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                            ),
                            enabledBorder: isEmailValid
                                ? const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(1, 86, 81, 1),
                                    ),
                                  )
                                : const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(173, 0, 0, 1),
                                    ),
                                  ),
                            focusedBorder: isEmailValid
                                ? const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(1, 86, 81, 1),
                                    ),
                                  )
                                : const UnderlineInputBorder(
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
                              password = value;
                              isPasswordValid = isValid;
                              //isPasswordConfirmed = password != value
                              if (password == value) {
                                isPasswordConfirmed = true;
                              } else {
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
                            enabledBorder: isPasswordValid
                                ? const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(1, 86, 81, 1),
                                    ),
                                  )
                                : const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(173, 0, 0, 1),
                                    ),
                                  ),
                            focusedBorder: isPasswordValid
                                ? const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(1, 86, 81, 1),
                                    ),
                                  )
                                : const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(173, 0, 0, 1),
                                    ),
                                  ),
                            suffixIcon: isPasswordValid
                                ? IconButton(
                                    icon: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
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
                            widget.updatePassword(value);
                            setState(() {
                              isConfirmedPasswordValid =
                                  password == value && validatePassword(value);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: '••••••',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                            ),
                            enabledBorder:
                                isConfirmedPasswordValid && isPasswordConfirmed
                                    ? const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(1, 86, 81, 1),
                                        ),
                                      )
                                    : const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(173, 0, 0, 1),
                                        ),
                                      ),
                            focusedBorder:
                                isConfirmedPasswordValid && isPasswordConfirmed
                                    ? const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(1, 86, 81, 1),
                                        ),
                                      )
                                    : const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(173, 0, 0, 1),
                                        ),
                                      ),
                            suffixIcon: isConfirmedPasswordValid &&
                                    isPasswordConfirmed
                                ? IconButton(
                                    icon: Icon(
                                      isConfirmPasswordVisible &&
                                              isPasswordConfirmed
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                      color: const Color.fromRGBO(1, 86, 81, 1),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isConfirmPasswordVisible =
                                            !isConfirmPasswordVisible;
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
                            onPressed: () {
                              isEmailValid &&
                                      isPasswordValid &&
                                      isConfirmedPasswordValid &&
                                      isNameSurnameValid
                                  ? sendingCode()
                                  : null;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isEmailValid &&
                                      isPasswordValid &&
                                      isConfirmedPasswordValid &&
                                      isNameSurnameValid
                                  ? const Color.fromRGBO(1, 86, 81, 1)
                                  : const Color.fromRGBO(127, 127, 127, 0.5),
                              minimumSize: const Size(double.infinity, 70.0),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.sendCode,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: isEmailValid &&
                                        isPasswordValid &&
                                        isConfirmedPasswordValid &&
                                        isNameSurnameValid
                                    ? Colors.white
                                    : Colors.white,
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
      ),
    );
  }
}
