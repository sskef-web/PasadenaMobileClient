import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pasadena_mobile_client/data/employee.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/employeeCard.dart';

class Tab3Page extends StatefulWidget {

  const Tab3Page({super.key});

  @override
  _Tab3Page createState() => _Tab3Page();
}

class _Tab3Page extends State<Tab3Page> {
  late Future<List<Employee>> _employeeFuture;
  List<String> procedureTypes = ['Маникюр', 'Педикюр', 'Шлифования', 'Полировка'];
  List<String> statuses = ['Работает', 'Занят', 'На перерыве'];
  String selectedProcedureType = '';
  String selectedStatus = '';
  List<Employee> allEmployees = [];
  List<Employee> favoriteEmployees = [];

  Future<List<Employee>> generateRandomEmployees() async {
    List<String> firstNames = ['Елизавета', 'Зоя', 'Софья', 'Ксения', 'Полина', 'Ульяна', 'Ксения', 'София', 'Ксения', 'Маргарита', 'Артём', 'Анна', 'Алиса', 'Анастасия', 'Виктория'];
    List<String> lastNames = ['Зорина', 'Николаева', 'Спиридонова', 'Дмитриева', 'Никитина', 'Матвеева', 'Бородина', 'Смирнова', 'Сорокина', 'Титова', 'Панова', 'Хомякова', 'Андреева', 'Васильева', 'Ефремова'];
    Random random = Random();

    List<Employee> employees = [];
    for (int i = 0; i < 15; i++) {
      Employee employee = Employee(
        id: i,
        photoUrl: 'https://randomfox.ca/images/$i.jpg',
        firstName: firstNames[random.nextInt(firstNames.length)],
        lastName: lastNames[random.nextInt(lastNames.length)],
        positiveReviews: random.nextDouble() * 100,
        status: statuses[random.nextInt(statuses.length)],
        procedureType: procedureTypes[random.nextInt(procedureTypes.length)],
        date: DateTime.now(),
      );
      employees.add(employee);
    }
    return employees;
  }

  Future<void> saveFavoriteEmployees(List<Employee> allEmployees, List<Employee> favoriteEmployees) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteEmployeeIds = favoriteEmployees.map((employee) => employee.id as String).toList();
    await prefs.setStringList('favoriteEmployees', favoriteEmployeeIds);
  }

  Future<void> removeFavoriteEmployees(List<Employee> favoriteEmployees) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteEmployeeIds = prefs.getStringList('favoriteEmployees');

    if (favoriteEmployeeIds != null) {
      List<String> currentFavoriteIds = favoriteEmployees.map((employee) => employee.id as String).toList();
      favoriteEmployeeIds.removeWhere((id) => currentFavoriteIds.contains(id));
      await prefs.setStringList('favoriteEmployees', favoriteEmployeeIds);
    }
  }

  Future<List<Employee>?> loadFavoriteEmployees(List<Employee> allEmployees) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteEmployeeIds = prefs.getStringList('favoriteEmployees');
    if (favoriteEmployeeIds != null) {
      List<Employee> favoriteEmployees = allEmployees.where((employee) => favoriteEmployeeIds.contains(employee.id)).toList();
      return favoriteEmployees;
    }
    return null;
  }

  void updateFavoriteEmployees(Employee employee) {
    setState(() {
      if (favoriteEmployees.contains(employee)) {
        favoriteEmployees.remove(employee);
        removeFavoriteEmployees(favoriteEmployees);
      } else {
        favoriteEmployees.add(employee);
        saveFavoriteEmployees(allEmployees, favoriteEmployees);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _employeeFuture = generateRandomEmployees();
    selectedProcedureType = procedureTypes.first;
    selectedStatus = statuses.first;
    loadFavoriteEmployees(allEmployees).then((loadedFavoriteEmployees) {
      if (loadedFavoriteEmployees != null) {
        setState(() {
          favoriteEmployees = loadedFavoriteEmployees;
        });
      }
    });
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
            future: Future.wait([_employeeFuture]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              currentSnapshot = snapshot;
              if (snapshot.hasData) {
                final employees = snapshot.data![0] as List<Employee>;
                allEmployees = employees;
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.15,
                          padding: const EdgeInsets.all(32),
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.listMasters,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight * 0.85,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DropdownButtonHideUnderline (
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedProcedureType,
                                            hint: Text(AppLocalizations.of(context)!.selectProcedure, style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1))),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedProcedureType = value!;
                                              });
                                            },
                                            items: procedureTypes.map<DropdownMenuItem<String>>((String type) {
                                              return DropdownMenuItem<String>(
                                                value: type,
                                                child: Text(
                                                  type,
                                                  style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
                                                ),
                                              );
                                            }).toList(),
                                            style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
                                            iconSize: 24.0,
                                            dropdownColor: Colors.white,
                                            icon: Icon(Icons.arrow_drop_down, color: Color.fromRGBO(1, 86, 81, 1)),
                                            underline: Container(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedStatus,
                                            hint: Text(AppLocalizations.of(context)!.selectStatus, style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1))),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedStatus = value!;
                                              });
                                            },
                                            items: statuses.map<DropdownMenuItem<String>>((String type) {
                                              return DropdownMenuItem<String>(
                                                value: type,
                                                child: Text(
                                                  type,
                                                  style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1)),
                                                ),
                                              );
                                            }).toList(),
                                            style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),),
                                            iconSize: 24.0,
                                            dropdownColor: Colors.white,
                                            icon: Icon(Icons.arrow_drop_down, color: Color.fromRGBO(1, 86, 81, 1)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0,),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: employees.length,
                                  itemBuilder: (context, index) {
                                    Employee employee = employees[index];
                                    bool isFavorite = favoriteEmployees.contains(employee);

                                    if (isFavorite || (selectedProcedureType.isEmpty || employee.procedureType == selectedProcedureType) &&
                                        (selectedStatus.isEmpty || employee.status == selectedStatus)) {
                                      return EmployeeCard(
                                        employee: employee,
                                        isFavorite: isFavorite,
                                        onTap: () {
                                          setState(() {
                                            updateFavoriteEmployees(employee);
                                          });
                                        },
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
              }
            },
          ),
        ),
      ),
    );
  }
}
