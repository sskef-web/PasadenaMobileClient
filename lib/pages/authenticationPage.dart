import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pasadena_mobile_client/data/loginresponse.dart';
import 'package:pasadena_mobile_client/pages/homePage.dart';
import 'package:pasadena_mobile_client/main.dart';
import 'package:flutter/material.dart';
import 'package:pasadena_mobile_client/pages/loginPage.dart';
import 'package:pasadena_mobile_client/pages/registerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'languageSelectionButton.dart';

class AuthenticationPage extends StatefulWidget {

  const AuthenticationPage({super.key});

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _isLoggedIn = false;
  String email = '';
  String password = '';
  String confirmPassword = '';
  String nameSurname = '';
  var userId;
  var token;
  var refreshToken;
  var savedCookies;
  String proofCode = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  String? extractTokenFromCookies(String cookies) {
    var cookieList = cookies.split(';');
    for (var cookie in cookieList) {
      if (cookie.contains('X-Access-Token')) {
        var token = cookie.split('=')[1];
        return token;
      }
    }
    return null;
  }

  String? extractRefreshTokenFromCookies(String cookies) {
    var cookieList = cookies.split(';');
    for (var cookie in cookieList) {
      if (cookie.contains('X-Refresh-Token')) {
        var token = cookie.split('=')[1];
        return token;
      }
    }
    return null;
  }

  String? extractUserIdFromCookies(String cookies) {
    var cookieList = cookies.split(';');
    for (var cookie in cookieList) {
      if (cookie.contains('X-User-Id')) {
        var userId = cookie.split('=')[1];
        return userId;
      }
    }
    return null;
  }

  Future<void> saveCookies(String cookies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookies', cookies);
  }

  Future<String?> loadCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cookies');
  }

  Future<LoginResponse> login(String email, String password) async {
    var url = Uri.parse('${baseURL}auth/login');
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      var cookies = response.headers['set-cookie'];
      await saveCookies(cookies!);
      token = extractTokenFromCookies(cookies);
      userId = extractUserIdFromCookies(cookies);
      refreshToken = extractRefreshTokenFromCookies(cookies);
      return LoginResponse(token, userId, refreshToken, response.body);
    }
    else
    {
      final responseJson = jsonDecode(response.body);
      if (responseJson['title'] == 'Bad Request') {
        throw showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.error),
              content: Text(AppLocalizations.of(context)!.passwordEmailError),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.continued),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      else
      {
        String emailError = '${responseJson['errors']['Email']}';
        String passError = '${responseJson['errors']['Password']}';
        //throw Exception('Failed to login: ${response.statusCode}');
        debugPrint(responseJson);
        throw showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.error),
              content: Text('${AppLocalizations.of(context)!.errorLogin}:\n$emailError\n$passError'),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.continued),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<LoginResponse> registrate(String email, String password,
      String firstName, String lastName, String proofCode) async {
    var url = Uri.parse('${baseURL}auth/registration');

    var body = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'emailAndProof': {
        'emailAddress': email,
        'proofCode': proofCode
      },
      "phoneAndProof": null,
      "avatarUrl": "https://static-00.iconduck.com/assets.00/user-icon-1024x1024-dtzturco.png"
    });
    debugPrint('====== REG DATA ======\n$firstName\n$lastName\n$email\n$proofCode\n$password\n====== REG DATA ======');
    var response = await http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      var cookies = response.headers['set-cookie'];
      await saveCookies(cookies!);
      var token = extractTokenFromCookies(cookies);
      var userId = extractUserIdFromCookies(cookies);
      var refreshToken = extractRefreshTokenFromCookies(cookies);
      return LoginResponse(token!, userId!, refreshToken!, response.body);
    } else {
      throw response.body;
    }
  }

  void _login() async {
    if (email == '' || password == '') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.error),
            content: Text(AppLocalizations.of(context)!.emptyField),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.continued),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    else
    {
      await login(email, password);
      savedCookies = await loadCookies();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      setState(() {
        _isLoggedIn = true;
      });
      Navigator.of(context).pop();
    }
  }

  void _register() async {
    String name = nameSurname.split(' ')[0];
    String surname = nameSurname.split(' ')[1];
    debugPrint('============ \n NAME = $name\n SURNAME = $surname\n ============');
    Navigator.pop(context, true);
    await registrate(email, password, name, surname, proofCode);
    savedCookies = await loadCookies();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    setState(() {
      _isLoggedIn = true;
    });
  }


  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    _isLoggedIn = false;
    email = '';
    password = '';
  }

  void _updateEmail(String value) {
    setState(() {
      email = value;
      debugPrint('NEW EMAIL: $email');
    });
  }

  void _updatePassword(String value) {
    setState(() {
      password = value;
      debugPrint('NEW PASS: $password');
    });
  }

  void _updateNameSurname(String value) {
    setState(() {
      nameSurname = value;
      debugPrint('NEW NAME_SURNAME: $nameSurname');
    });
  }

  void _updateProofCode(String value) {
    setState(() {
      proofCode = value;
      debugPrint('NEW PROOFCODE: $proofCode');
    });
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          key: widget.key,
          login: _login,
          logout: _logout,
          updateEmail: _updateEmail,
          updatePassword: _updatePassword,
          updateProofCode: _updateProofCode,
          navigateToRegisterPage: navigateToRegisterPage,
          proofCode: proofCode,
        ),
      ),
    );
  }

  void navigateToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(
          key: widget.key,
          register: _register,
          updateEmail: _updateEmail,
          updatePassword: _updatePassword,
          updateNameSurname: _updateNameSurname,
          updateProofCode: _updateProofCode,
          navigateToLoginPage: navigateToLoginPage,
          email: email,
          proofCode: proofCode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return HomePage(logoutCallback: _logout);
    } else {
      return Scaffold(
        body: Container (
          decoration: const BoxDecoration(
            gradient: LinearGradient(
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
          ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 16.0,
              ),
              const LanguageSelectionButton(),
              const SizedBox(
                height: 16.0,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: Transform.scale(
                    scale: 0.6,
                    child: Image.asset(
                      'assets/images/pasadenaLogo.png',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            foregroundColor:
                            const Color.fromRGBO(17, 45, 48, 1),
                          ),
                          onPressed: () {
                            navigateToLoginPage(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.loginButton,
                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(color: Color.fromRGBO(255, 215, 0, 1.0)),
                          ),
                          onPressed: () {
                            navigateToRegisterPage(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.registerButton,
                            style:
                                const TextStyle(fontSize: 20.0, color: Color.fromRGBO(255, 215, 0, 1.0), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: Text(
                          AppLocalizations.of(context)!.socialText,
                          textAlign: TextAlign.center,
                          textScaler: const TextScaler.linear(1.1),
                          style: const TextStyle (fontWeight: FontWeight.w100),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {

                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.facebook_outlined,
                                color: Color.fromRGBO(5, 76, 73, 1.0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          InkWell(
                            onTap: () {

                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(FontAwesomeIcons.instagram,
                                  color: Color.fromRGBO(5, 76, 73, 1.0)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
      );
    }
  }
}