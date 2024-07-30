import 'package:pasadena_mobile_client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../tabItems/tab1.dart';
import '../tabItems/tab2.dart';
import '../tabItems/tab3.dart';

class HomePage extends StatefulWidget {
  final Function() logoutCallback;
  bool isLoggedIn;

  HomePage(
      {
        super.key,
        required this.logoutCallback,
        required this.isLoggedIn,
      });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  String locale = "";

  late List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      Tab1Page(
        logoutCallback: widget.logoutCallback,
        isLoggedIn: widget.isLoggedIn,
        locale: locale,
      ),
      const Tab2Page(),
      const Tab3Page(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    locale = Localizations.localeOf(context).languageCode;
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: _currentIndex,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: _tabs,
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: TabBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            indicatorColor: Color.fromRGBO(255, 215, 0, 1),
            labelColor: const Color.fromRGBO(255, 215, 0, 1),
            unselectedLabelColor: const Color.fromRGBO(17, 45, 48, 1),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person,
                  color: _currentIndex == 0
                      ? Color.fromRGBO(255, 215, 0, 1)
                      : Color.fromRGBO(17, 45, 48, 1),
                ),
                text: AppLocalizations.of(context)!.tabTitle1,
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                  color: _currentIndex == 1
                      ? Color.fromRGBO(255, 215, 0, 1)
                      : Color.fromRGBO(17, 45, 48, 1),
                ),
                text: AppLocalizations.of(context)!.tabTitle2,
              ),
              Tab(
                icon: Icon(
                Icons.group,
                color: _currentIndex == 2
                    ? Color.fromRGBO(255, 215, 0, 1)
                    : Color.fromRGBO(17, 45, 48, 1),
                ),
                text: AppLocalizations.of(context)!.tabTitle3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}