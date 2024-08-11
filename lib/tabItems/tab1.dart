import 'dart:convert';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pasadena_mobile_client/main.dart';
import '../data/reservations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/orderBlock.dart';
import '../data/user.dart';
import '../pages/authenticationPage.dart';
import '../pages/changeProfileInfoPage.dart';
import 'package:http/http.dart' as http;

import '../pages/homePage.dart';

class Tab1Page extends StatefulWidget {
  final Function() logoutCallback;
  bool isLoggedIn;
  String locale;

  Tab1Page({
    super.key,
    required this.logoutCallback,
    required this.isLoggedIn,
    required this.locale,
  });

  @override
  _Tab1Page createState() => _Tab1Page();
}

class _Tab1Page extends State<Tab1Page> {
  late Future<User> _userFuture;
  DateTime _selectedDateTime = DateTime.now();
  DateTime _nowDateTime = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  DateTime _focusDate = DateTime(2024);
  List<Reservation> filteredOrders = [];
  List<DateTime> _focusDates = [];
  int userId = 1337;
  bool isFirstDateSelected = false;

  void firstFocusDate(User user) {
    DateTime initialFocusDate = _focusDates.isNotEmpty
        ? DateTime(
            _focusDates[0].year, _focusDates[0].month, _focusDates[0].day)
        : DateTime.now();
    _focusDate = initialFocusDate;
    filteredOrders = filterOrdersByDate(user.reservations, _focusDate);
    _selectedDateTime = _focusDate;
    isFirstDateSelected = true;
  }

  void fillFocusDates(List<DateTime> focusDates, User user) {
    user.reservations.forEach((order) {
      focusDates
          .add(DateTime(order.date.year, order.date.month, order.date.day));
      debugPrint('==== ordersDateTime - ${order.date} ==== _focusDates - ${focusDates.last}');
    });
  }

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUser();
    _nowDateTime = DateTime.now();
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    widget.logoutCallback();
  }

  void editProfile(String firstname, String lastName, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeProfileInfoPage(
          logout: widget.logoutCallback,
          firstName: firstname,
          lastName: lastName,
          email: email,
        ),
      ),
    );
  }

  void updateFilteredOrders(User user, DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      filteredOrders = filterOrdersByDate(user.reservations, selectedDate);
    });
  }

  List<Reservation> filterOrdersByDate(
      List<Reservation> orders, DateTime date) {
    return orders
        .where((order) =>
            order.date.year == date.year &&
            order.date.month == date.month &&
            order.date.day == date.day)
        .toList();
  }

  Future<void> saveCookies(String cookies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cookies', cookies);
  }

  Future<String?> loadCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cookies');
  }

  Future<void> refreshToken() async {
    var refreshUrl = Uri.parse('${baseURL}auth/refresh');
    var cookies = await loadCookies();

    debugPrint('COOKIES - $cookies');

    var response = await http.get(refreshUrl, headers: {
      'Cookie': cookies!,
    });

    if (response.statusCode == 200) {
      var newCookies = response.headers['set-cookie'];
      if (newCookies != null) {
        await saveCookies(newCookies);
      }
      debugPrint('REFRESH TOKEN SUCCESS. Status code: ${response.statusCode}');
    } else {
      widget.logoutCallback();
      navigateToAuthPage();
      debugPrint('REFRESH TOKEN ERROR. Status code: ${response.statusCode}');
      throw Exception(
          '${AppLocalizations.of(context)!.refreshTokenError} (code: ${response.statusCode}');
    }
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

  int? extractUserIdFromCookies(String cookies) {
    var cookieList = cookies.split(';');
    for (var cookie in cookieList) {
      if (cookie.contains('X-User-Id')) {
        var userId = cookie.split('=')[1];
        return int.parse(userId);
      }
    }
    return null;
  }

  void navigateToAuthPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => AuthenticationPage()),
    );
  }

  Future<User> fetchUser() async {
    var cookies = await loadCookies();
    userId = extractUserIdFromCookies(cookies!)!;
    var url = Uri.parse('${baseURL}profile');

    var response = await http.get(url,
        headers: {'Cookie': cookies, 'Accept-Language': widget.locale});

    if (response.statusCode == 200) {
      debugPrint('USER INFO FETCH SUCCESS. Status code: ${response.statusCode}');
      var jsonData = jsonDecode(response.body);
      var user = User.fromJson(jsonData);
      return user;
    } else if (response.statusCode == 401) {
      debugPrint('USER INFO FETCH ERROR. Status code: ${response.statusCode}');
      await refreshToken();
      _updatePage();
      return fetchUser();
    } else {
      debugPrint('USER INFO FETCH ERROR. tatus code: ${response.statusCode}');
      throw Exception(AppLocalizations.of(context)!.error);
    }
  }

  void _updatePage() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => HomePage(
                logoutCallback: widget.logoutCallback,
                isLoggedIn: widget.isLoggedIn,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    AsyncSnapshot<List<dynamic>>? currentSnapshot;
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
          child: FutureBuilder(
            future: Future.wait([_userFuture]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              currentSnapshot = snapshot;
              if (snapshot.hasData) {
                final user = snapshot.data![0] as User;
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    filteredOrders = user.reservations
                        .where((order) =>
                            isSameDate(order.date, _selectedDateTime))
                        .toList();
                    fillFocusDates(_focusDates, user);
                    if (!isFirstDateSelected) {
                      firstFocusDate(user);
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.2,
                          padding: const EdgeInsets.all(32),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.userProfile,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${user.firstName} ${user.lastName}',
                                    style: const TextStyle(
                                        fontSize: 26.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0)),
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 2.0,
                                          style: BorderStyle.solid,
                                          strokeAlign:
                                              BorderSide.strokeAlignInside),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.white, size: 22),
                                      onPressed: () {
                                        editProfile(user.firstName,
                                            user.lastName, user.email);
                                      },
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
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                EasyInfiniteDateTimeLine(
                                  headerBuilder:
                                      (BuildContext context, DateTime date) {
                                    final dateFormat = DateFormat.yMMMM(
                                        Localizations.localeOf(context)
                                            .languageCode);
                                    return Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                                Icons.arrow_back_ios),
                                            color: const Color.fromRGBO(
                                                136, 136, 136, 1),
                                            onPressed: () {
                                              setState(() {
                                                _selectedDateTime = DateTime(
                                                    _selectedDateTime.year,
                                                    _selectedDateTime.month -
                                                        1);
                                                debugPrint('Selected date time - ${_selectedDateTime
                                                    .toString()}');
                                              });
                                            },
                                          ),
                                          Text(
                                            dateFormat
                                                .format(_selectedDateTime),
                                            style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    136, 136, 136, 1)),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.arrow_forward_ios),
                                            color: const Color.fromRGBO(
                                                136, 136, 136, 1),
                                            onPressed: () {
                                              setState(() {
                                                _selectedDateTime = DateTime(
                                                    _selectedDateTime.year,
                                                    _selectedDateTime.month +
                                                        1);
                                                debugPrint(
                                                    'Selected date time - ${_selectedDateTime.toString()}');
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  selectionMode:
                                      const SelectionMode.autoCenter(),
                                  firstDate: DateTime(_selectedDateTime.year,
                                      _selectedDateTime.month, 1),
                                  focusDate: _focusDate,
                                  lastDate: DateTime(_selectedDateTime.year,
                                      _selectedDateTime.month, 31),
                                  onDateChange: (selectedDate) {
                                    setState(() {
                                      _focusDate = selectedDate;
                                      _selectedDate = selectedDate;
                                      _selectedDateTime = DateTime(
                                          _selectedDate.year,
                                          _selectedDate.month,
                                          _selectedDate.day);
                                      updateFilteredOrders(user, _focusDate);
                                      filteredOrders = filterOrdersByDate(
                                          user.reservations, _focusDate);
                                    });
                                  },
                                  dayProps: const EasyDayProps(
                                    width: 64.0,
                                    height: 96.0,
                                  ),
                                  itemBuilder: (BuildContext context,
                                      DateTime date,
                                      bool isSelected,
                                      VoidCallback onTap) {
                                    return InkResponse(
                                      onTap: onTap,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              232, 232, 232, 1),
                                          border: isSelected
                                              ? Border.all(
                                                  color: const Color.fromRGBO(
                                                      204, 204, 204, 1),
                                                  width: 4.0,
                                                  style: BorderStyle.solid,
                                                  strokeAlign: BorderSide
                                                      .strokeAlignInside)
                                              : _focusDates.contains(date)
                                                  ? Border.all(
                                                      color: Colors.transparent,
                                                      width: 0.0)
                                                  : Border.all(
                                                      color:
                                                          const Color.fromRGBO(
                                                              204, 204, 204, 1),
                                                      width: 2.0,
                                                      style: BorderStyle.solid,
                                                      strokeAlign: BorderSide
                                                          .strokeAlignInside),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          gradient: _focusDates.contains(date)
                                              ? const LinearGradient(
                                                  colors: [
                                                    Color.fromRGBO(
                                                        17, 45, 48, 1),
                                                    Color.fromRGBO(
                                                        1, 86, 81, 1),
                                                  ],
                                                  stops: [0.0, 0.5],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                )
                                              : null,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                EasyDateFormatter.shortDayName(
                                                        date,
                                                        Localizations.localeOf(
                                                                context)
                                                            .languageCode)
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  color: _focusDates
                                                          .contains(date)
                                                      ? Colors.white
                                                      : const Color.fromRGBO(
                                                          136, 136, 136, 1),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                date.day.toString(),
                                                style: TextStyle(
                                                  color: _focusDates
                                                          .contains(date)
                                                      ? Colors.white
                                                      : const Color.fromRGBO(
                                                          1, 86, 81, 1),
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
                                const SizedBox(height: 16.0),
                                const Text(
                                  'СПИСОК БРОНИРОВАНИЯ',
                                  style: TextStyle(
                                      color: Color.fromRGBO(1, 86, 81, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 16.0),
                                if (filteredOrders == null)
                                  const Text(
                                    'СПИСОК БРОНИРОВАНИЯ',
                                    style: TextStyle(
                                        color: Color.fromRGBO(1, 86, 81, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  )
                                else
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: filteredOrders.length,
                                    itemBuilder: (context, index) {
                                      Reservation order = filteredOrders[index];
                                      return OrderBlock(
                                        headImageUrl: order.pictureUrl,
                                        employeeImageUrl:
                                            order.employeeAvatarUrl,
                                        title: order.title,
                                        employeeName: order.employeeName,
                                        selectedDateTime: order.date,
                                        reservationStatus: order.statusCode,
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                      '${AppLocalizations.of(context)!.error} (Snapshot error) ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
