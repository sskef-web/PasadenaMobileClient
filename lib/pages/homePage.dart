import 'package:pasadena_mobile_client/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../tabItems/tab1.dart';
import '../tabItems/tab2.dart';
import '../tabItems/tab3.dart';

class HomePage extends StatefulWidget {
  final Function() logoutCallback;

  const HomePage({super.key, required this.logoutCallback});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  late List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      Tab1Page(logoutCallback: widget.logoutCallback),
      Tab2Page(logoutCallback: widget.logoutCallback),
      Tab3Page(logoutCallback: widget.logoutCallback),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: SizedBox(
          width: 48.0,
          height: 48.0,
          child: IconButton(
            iconSize: 32.0,
            icon: Transform.rotate(
              angle: 3.14,
              child: const Icon(Icons.logout),
            ),
            onPressed: () {
              setState(() {
                widget.logoutCallback();
              });
            },
          ),
        ),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color.fromRGBO(255, 215, 0, 1), // S
        unselectedItemColor: const Color.fromRGBO(17, 45, 48, 1),// et the selected label color
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.person, color: Color.fromRGBO(17, 45, 48, 1)),
            label: AppLocalizations.of(context)!.tabTitle1,
            activeIcon: const Icon(Icons.person, color: Color.fromRGBO(255, 215, 0, 1)),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group, color: Color.fromRGBO(17, 45, 48, 1)),
            label: AppLocalizations.of(context)!.tabTitle2,
            activeIcon: const Icon(Icons.group, color: Color.fromRGBO(255, 215, 0, 1)),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.attach_money, color: Color.fromRGBO(17, 45, 48, 1)),
            label: AppLocalizations.of(context)!.tabTitle3,
            activeIcon: const Icon(Icons.attach_money, color: Color.fromRGBO(255, 215, 0, 1)),
          ),
        ],
      ),
    );
  }
}
