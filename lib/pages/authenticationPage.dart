import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pasadena_mobile_client/data/loginresponse.dart';
import 'package:pasadena_mobile_client/pages/homePage.dart';
import 'package:pasadena_mobile_client/main.dart';
import 'package:flutter/material.dart';
import 'package:pasadena_mobile_client/pages/languageSelectionPage.dart';
import 'package:pasadena_mobile_client/pages/loginPage.dart';
import 'package:pasadena_mobile_client/pages/registerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  String firstName = '';
  String lastName = '';
  String avatarPath =
      'StaticFiles/avatars/38c7301d-b794-44b4-935b-aeb70527b1a5.jpeg';
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

  Future<void> saveCookies(String cookies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookies', cookies);
  }

  Future<String?> loadCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cookies');
  }

  Future<void> _changePassword(String email, String password) async {}

  Future<LoginResponse> login(String email, String password) async {
    return LoginResponse('31242423sgsd', '142', '1241', 'Test');
  }

  Future<LoginResponse> registrate(
      String email,
      String password,
      String firstName,
      String lastName,
      String proofCode) async {
    return LoginResponse('31242423sgsd', '142', '1241', 'Test');
  }

  void changePassword() async {
    debugPrint('EMAIL: $email | PASSWORD: $password');
    _changePassword(email, password);
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
                child: const Text('ОК'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    else {
      await login(email, password);
      savedCookies = await loadCookies();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.of(context).pop();
      setState(() {
        appTitle = AppLocalizations.of(context)!.tabTitle1;
        _isLoggedIn = true;
      });
    }
  }

  void _register() async {
      await registrate(
          email, password, firstName, lastName, avatarPath);
      savedCookies = await loadCookies();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.pop(context, true);
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
    setState(() {
      appTitle = AppLocalizations.of(context)!.defaultTitle;
    });
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

  void _updateFirstName(String value) {
    setState(() {
      firstName = value;
      debugPrint('NEW FIRSTNAME: $firstName');
    });
  }

  void _updateProofCode(String value) {
    setState(() {
      proofCode = value;
      debugPrint('NEW PROOFCODE: $proofCode');
    });
  }

  void _updateLastName(String value) {
    setState(() {
      lastName = value;
      debugPrint('NEW LASTNAME: $lastName');
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
          navigateToRegisterPage: navigateToRegisterPage,
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
          updateFirstname: _updateFirstName,
          updateLastname: _updateLastName,
          navigateToLoginPage: navigateToLoginPage,
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
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: Transform.scale(
                    scale: 0.8,
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
                        child: Text(
                          AppLocalizations.of(context)!.welcome,
                          textAlign: TextAlign.center,
                          textScaler: const TextScaler.linear(2.5),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            navigateToLoginPage(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.loginButton,
                            style:
                                const TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            foregroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            navigateToRegisterPage(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.registerButton,
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LanguageSelectionPage()),
                          );
                        },
                        child: Text(
                            AppLocalizations.of(context)!.selectLanguage),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: Text(
                          AppLocalizations.of(context)!.socialText,
                          textAlign: TextAlign.center,
                          textScaler: const TextScaler.linear(1.2),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              // Добавьте здесь код для обработки нажатия на иконку Facebook
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.facebook_outlined,
                                color: Color.fromRGBO(17, 45, 48, 1),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          InkWell(
                            onTap: () {
                              // Добавьте здесь код для обработки нажатия на иконку Instagram
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(FontAwesomeIcons.instagram,
                                  color: Color.fromRGBO(17, 45, 48, 1)),
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
      );
    }
  }
}