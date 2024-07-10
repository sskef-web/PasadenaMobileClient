import 'package:flutter/material.dart';


class Tab1Page extends StatefulWidget {
  final Function() logoutCallback;

  const Tab1Page({super.key, required this.logoutCallback});

  @override
  _Tab1Page createState() => _Tab1Page();
}

class _Tab1Page extends State<Tab1Page> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff112d30),
              Color(0xff112d30),
              Color(0xff044f4b),
              Color(0xff015651),
            ],
            stops: [0.03, 0.27, 0.86, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Имя',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Фамилия',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  // Блок с информацией о последнем заказе
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green, size: 32.0),
                              SizedBox(width: 8.0),
                              Text(
                                'Статус заказа',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Название услуги',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Дата выполнения',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                'Сидоров П.О',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'История заказов',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ListView.builder(
                  itemCount: orderHistory.length,
                  itemBuilder: (context, index) {
                    final order = orderHistory[index];
                    return ListTile(
                      leading: Icon(order.statusIcon, size: 44.0, color: order.iconColor),
                      title: Text(order.serviceName),
                      subtitle: Text(order.completionDate),
                      trailing: Text(order.masterName),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Order {
  final IconData statusIcon;
  final String serviceName;
  final String completionDate;
  final String masterName;
  final Color iconColor;

  Order({
    required this.statusIcon,
    required this.serviceName,
    required this.completionDate,
    required this.masterName,
    required this.iconColor
  });
}

// Пример массива с тестовыми данными
List<Order> orderHistory = [
  Order(
    statusIcon: Icons.check_circle,
    iconColor: Colors.green,
    serviceName: 'Услуга 1',
    completionDate: '10 июля 2024',
    masterName: 'Иванов И.И.',
  ),
  Order(
    statusIcon: Icons.close,
    iconColor: Colors.red,
    serviceName: 'Услуга 2',
    completionDate: '15 июля 2024',
    masterName: 'Петров П.П.',
  ),
  Order(
    statusIcon: Icons.priority_high,
    iconColor: Colors.yellow,
    serviceName: 'Услуга 3',
    completionDate: '20 июля 2024',
    masterName: 'Сидоров С.С.',
  ),
  Order(
    statusIcon: Icons.question_mark,
    iconColor: Colors.yellow,
    serviceName: 'Услуга 4',
    completionDate: '21 августа 2024',
    masterName: 'Петров С.С.',
  ),
];
