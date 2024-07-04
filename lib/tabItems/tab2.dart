import 'package:flutter/material.dart';


class Tab2Page extends StatefulWidget {
  final Function() logoutCallback;

  const Tab2Page({super.key, required this.logoutCallback});

  @override
  _Tab2Page createState() => _Tab2Page();
}

class _Tab2Page extends State<Tab2Page> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tab2'),
      ),
    );
  }
}
