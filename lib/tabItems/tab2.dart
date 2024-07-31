import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Tab2Page extends StatefulWidget {

  const Tab2Page({super.key});

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
    AsyncSnapshot<List<dynamic>>? currentSnapshot;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          child: FutureBuilder (
            future: Future.wait([]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              currentSnapshot = snapshot;
              return const Center(
                child: Text('Menu'),
              );
              /*if (snapshot.hasData) {
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${AppLocalizations.of(context)!.error} (Snapshot error) ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                );
              }*/
            },
          ),
        ),
      ),
    );
  }
}
