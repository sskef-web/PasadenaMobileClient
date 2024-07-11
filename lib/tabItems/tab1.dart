import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/orderBlock.dart';
import '../data/order.dart';

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
  DateTime _selectedDate = DateTime.now();
  DateTime _focusDate = DateTime(2024);
  List<DateTime> _focusDates = [];

  List<Order> orders = [
    Order(
      headImageUrl: 'https://manikyurdizajn.ru/wp-content/uploads/2021/06/4.jpg',
      employeeImageUrl: 'https://static9.depositphotos.com/1605416/1081/i/450/depositphotos_10819690-stock-photo-portrait-of-a-young-capybara.jpg',
      title: 'Маникюр гибридный',
      employeeName: 'КАПИБАРА',
      dateTime: DateTime(2024, 07, 14, 10, 00),
      reservationStatus: 1,
    ),
    Order(
      headImageUrl: 'https://ash2o.ru/upload/iblock/319/319dddc459df2258ba456fd4d2ef7399.jpeg',
      employeeImageUrl: 'https://i.pinimg.com/originals/3f/19/34/3f1934bd60a5726f31ca1930e392bb0f.jpg',
      title: 'Маникюр гель-лак',
      employeeName: 'ЕНОТ',
      dateTime: DateTime(2024, 07, 14, 12, 00),
      reservationStatus: 2,
    ),
    Order(
      headImageUrl: 'https://s13.stc.all.kpcdn.net/woman/wp-content/uploads/2022/01/tild6231-3734-4637-b530-373964336131___71-960x540.jpg',
      employeeImageUrl: 'https://sotni.ru/wp-content/uploads/2023/08/kudiabliki-belka-2.webp',
      title: 'Маникюр с укреплением',
      employeeName: 'БЕЛКА',
      dateTime: DateTime(2024, 07, 15, 14, 00),
      reservationStatus: 3,
    ),
  ];

  void fillFocusDates() {
    orders.forEach((order) {
      _focusDates.add(DateTime(order.dateTime.year, order.dateTime.month, order.dateTime.day));
      debugPrint('\n\n ==== ordersDateTime - ${order.dateTime} ==== _focusDates - ${_focusDates.last}');
    });

  }

  @override
  void initState() {
    super.initState();
    _nowDateTime = DateTime.now();
    fillFocusDates();
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    widget.logoutCallback();
  }

  void editProfile() {}

  List<Order> filterOrdersByDate(DateTime selectedDate) {
    return orders.where((order) =>
    order.dateTime.year == selectedDate.year &&
        order.dateTime.month == selectedDate.month &&
        order.dateTime.day == selectedDate.day).toList();
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
              List<Order> filteredOrders = orders.where((order) => isSameDate(order.dateTime, _selectedDateTime)).toList();
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
                          selectionMode: const SelectionMode.alwaysFirst(),
                          firstDate: DateTime(_selectedDateTime.year, _selectedDateTime.month, 1),
                          focusDate: _focusDate,
                          lastDate: DateTime(_selectedDateTime.year, _selectedDateTime.month, 31),
                          onDateChange: (selectedDate) {
                            setState(() {
                              _focusDate = selectedDate;
                              _selectedDate = selectedDate;
                              _selectedDateTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
                              filteredOrders = filterOrdersByDate(selectedDate);
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
                            //debugPrint('\n\n\n ======================= builder ${date} ||| now ${_nowDateTime}  |||| focus ${_focusDates[1]} ================\n\n\n');
                            return InkResponse(
                              onTap: onTap,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(232, 232, 232, 1),
                                  border:
                                  isSelected
                                      ? Border.all(
                                      color: const Color.fromRGBO(204, 204, 204, 1),
                                      width: 4.0,
                                      style: BorderStyle.solid,
                                      strokeAlign: BorderSide.strokeAlignInside
                                  ) : _focusDates.contains(date)
                                      ? Border.all(color: Colors.transparent, width: 0.0,)
                                      : Border.all(
                                      color: const Color.fromRGBO(204, 204, 204, 1),
                                      width: 2.0,
                                      style: BorderStyle.solid,
                                      strokeAlign: BorderSide.strokeAlignInside
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  gradient: _focusDates.contains(date)
                                      ? const LinearGradient(
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
                                        EasyDateFormatter.shortDayName(
                                            date, Localizations
                                            .localeOf(context)
                                            .languageCode)
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: _focusDates.contains(date)
                                              ? Colors.white
                                              : const Color.fromRGBO(136, 136, 136, 1),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        date.day.toString(),
                                        style: TextStyle(
                                          color: _focusDates.contains(date)
                                              ? Colors.white
                                              : const Color.fromRGBO(1, 86, 81, 1),
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
                        Text(
                          'СПИСОК БРОНИРОВАНИЯ',
                          style: TextStyle(
                            color: Color.fromRGBO(1, 86, 81, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        filteredOrders == null ? Text(
                            'СПИСОК БРОНИРОВАНИЯ',
                            style: TextStyle(
                                color: Color.fromRGBO(1, 86, 81, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ))
                        : Expanded(
                          child: ListView.builder(
                            itemCount: filteredOrders.length,
                            itemBuilder: (context, index) {
                              Order order = filteredOrders[index];
                              return OrderBlock(
                                headImageUrl: order.headImageUrl,
                                employeeImageUrl: order.employeeImageUrl,
                                title: order.title,
                                employeeName: order.employeeName,
                                selectedDateTime: order.dateTime,
                                reservationStatus: order.reservationStatus,
                              );
                            },
                          ),
                        )
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
}
