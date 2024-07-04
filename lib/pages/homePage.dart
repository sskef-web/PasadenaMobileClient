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
      appBar: AppBar(
        title: Center(child: Text(appTitle)),
        leading: SizedBox(
          width: 48.0,
          height: 48.0,
          child: IconButton(
            iconSize: 32.0,
            icon: Transform.rotate(
              angle: 3.14,
              child: const Icon(Icons.logout),
            ),
            onPressed: widget.logoutCallback,
          ),
        ),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
          _currentIndex = index;
          switch (_currentIndex) {
            case 0:
            appTitle = AppLocalizations.of(context)!.tabTitle1;
            break;
            case 1:
            appTitle = AppLocalizations.of(context)!.tabTitle2;
            break;
            case 2:
            appTitle = AppLocalizations.of(context)!.tabTitle3;
            break;
          }
        });
      },
      items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.tabTitle1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group),
            label: AppLocalizations.of(context)!.tabTitle2,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.attach_money),
            label: AppLocalizations.of(context)!.tabTitle3,
          ),
        ],
      )
    );
  }
}
