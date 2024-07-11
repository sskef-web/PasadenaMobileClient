import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tab1Page extends StatefulWidget {
  void Function() logoutCallback;
  bool isLoggedIn;

  Tab1Page({super.key, required this.logoutCallback, required this.isLoggedIn});

  @override
  _Tab1Page createState() => _Tab1Page();
}

class _Tab1Page extends State<Tab1Page> {
  DateTime _selectedDateTime = DateTime.now();
  DateTime _nowDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nowDateTime = DateTime.now();
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    widget.logoutCallback();
  }
  DateTime _focusDate = DateTime(2024);

  void editProfile() {}

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
            onPressed: _logout,
          ),
        ),
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
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Профиль пользователя',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'ИРИНА ИВАНОВА',
                              style: TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                    style: BorderStyle.solid,
                                    strokeAlign: BorderSide.strokeAlignInside),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white, size: 22),
                                onPressed: editProfile,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(232, 232, 232, 1),
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
                        EasyInfiniteDateTimeLine(
                          headerBuilder: (
                              BuildContext context,
                              DateTime date
                              )
                          {
                            final dateFormat = DateFormat.yMMMM(Localizations.localeOf(context).languageCode);

                            return Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_ios),
                                    color: const Color.fromRGBO(136, 136, 136, 1),
                                    onPressed: () {
                                      setState(() {
                                        _selectedDateTime = DateTime(_selectedDateTime.year, _selectedDateTime.month - 1);
                                        debugPrint(_selectedDateTime.toString());
                                      });
                                    },
                                  ),
                                  Text(
                                    dateFormat.format(_selectedDateTime),
                                    style: const TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios),
                                    color: const Color.fromRGBO(136, 136, 136, 1),
                                    onPressed: () {
                                      setState(() {
                                        _selectedDateTime = DateTime(_selectedDateTime.year, _selectedDateTime.month + 1);
                                        debugPrint('${_selectedDateTime.toString()} =================================');
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          selectionMode: const SelectionMode.autoCenter(),
                          firstDate: DateTime(_selectedDateTime.year, _selectedDateTime.month, 1),
                          focusDate: _focusDate,
                          lastDate: DateTime(_selectedDateTime.year, _selectedDateTime.month, 31),
                          onDateChange: (selectedDate) {
                            setState(() {
                              _focusDate = selectedDate;
                            });
                          },
                          dayProps: const EasyDayProps(
                            width: 64.0,
                            height: 96.0,
                          ),
                          itemBuilder: (
                              BuildContext context,
                              DateTime date,
                              bool isSelected,
                              VoidCallback onTap,
                              )
                          {
                            debugPrint('\n\n\n ======================= builder ${date} ||| now ${_nowDateTime}  |||| focus ${_focusDates[1]} ================\n\n\n');
                            return InkResponse(
                              onTap: onTap,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(232, 232, 232, 1),
                                  border:
                                  isSelected | _focusDates.contains(date)
                                      ? Border.all(color: Colors.transparent, width: 0.0,)
                                      :
                                  _nowDateTime.year == date.year && _nowDateTime.month == date.month && _nowDateTime.day == date.day
                                      ? Border.all(
                                      color: const Color.fromRGBO(204, 204, 204, 1),
                                      width: 4.0,
                                      style: BorderStyle.solid,
                                      strokeAlign: BorderSide.strokeAlignInside
                                  )
                                      : Border.all(
                                      color: const Color.fromRGBO(204, 204, 204, 1),
                                      width: 2.0,
                                      style: BorderStyle.solid,
                                      strokeAlign: BorderSide.strokeAlignInside
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  gradient: isSelected | _focusDates.contains(date) ? const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(17, 45, 48, 1),
                                      Color.fromRGBO(1, 86, 81, 1),
                                    ],
                                    stops: [0.0, 0.5],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ) : null,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        EasyDateFormatter.shortDayName(date, Localizations.localeOf(context).languageCode).toUpperCase(),
                                        style: TextStyle(
                                          color: isSelected | _focusDates.contains(date) ? Colors.white : const Color.fromRGBO(136, 136, 136, 1),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        date.day.toString(),
                                        style: TextStyle(
                                          color: isSelected | _focusDates.contains(date) ? Colors.white : const Color.fromRGBO(1, 86, 81, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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

  final List<DateTime> _focusDates = [
    DateTime(2024, 7, 12, 0, 0, 0, 0),
    DateTime(2024, 7, 13, 0, 0, 0, 0),
    DateTime(2024, 7, 14, 0, 0, 0, 0),
  ];
}
