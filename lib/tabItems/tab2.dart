import 'package:flutter/material.dart';

import '../data/employee.dart';
import '../items/employeeCard.dart';


class Tab2Page extends StatefulWidget {
  final Function() logoutCallback;

  const Tab2Page({super.key, required this.logoutCallback});

  @override
  _Tab2Page createState() => _Tab2Page();
}

class _Tab2Page extends State<Tab2Page> {

  List<Employee> _employees = [
    Employee(
      photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvFBa3G11OUBYADP7ouSBgwiiRzSYorF4dfg&s',
      firstName: 'Grzegorz',
      lastName: 'Brzęczyszczykiewicz1',
      positiveReviews: 85.0,
      status: 'Работает',
      procedureType: 'Тип процедуры',
      date: DateTime.now(),
    ),
    Employee(
      photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvFBa3G11OUBYADP7ouSBgwiiRzSYorF4dfg&s',
      firstName: 'Grzegorz',
      lastName: 'Brzęczyszczykiewicz2',
      positiveReviews: 85.0,
      status: 'Работает',
      procedureType: 'Тип процедуры',
      date: DateTime.now(),
    ),
    Employee(
      photoUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvFBa3G11OUBYADP7ouSBgwiiRzSYorF4dfg&s',
      firstName: 'Grzegorz',
      lastName: 'Brzęczyszczykiewicz3',
      positiveReviews: 85.0,
      status: 'Работает',
      procedureType: 'Тип процедуры',
      date: DateTime.now(),
    ),
    // Добавьте остальных сотрудников
  ];

  bool _sortByDate = false;
  bool _sortByProcedureType = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Примените сортировку, если требуется
    if (_sortByDate) {
      _employees.sort((a, b) => a.date.compareTo(b.date));
    } else if (_sortByProcedureType) {
      _employees.sort((a, b) => a.procedureType.compareTo(b.procedureType));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Сотрудники'),
      ),
      body: ListView.builder(
        itemCount: _employees.length,
        itemBuilder: (context, index) {
          return EmployeeCard(employee: _employees[index]);
        },
      ),
    );
  }
}
