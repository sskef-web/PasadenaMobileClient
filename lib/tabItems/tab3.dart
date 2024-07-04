import 'package:flutter/material.dart';


class Tab3Page extends StatefulWidget {
  final Function() logoutCallback;

  const Tab3Page({super.key, required this.logoutCallback});

  @override
  _Tab3Page createState() => _Tab3Page();
}

class _Tab3Page extends State<Tab3Page> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tab3'),
      ),
    );
  }
}
