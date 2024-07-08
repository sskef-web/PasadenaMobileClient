import 'package:flutter/material.dart';

import '../data/employee.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(employee.photoUrl),
      ),
      title: Text('${employee.firstName} ${employee.lastName}'),
      subtitle: Text('Positive reviews: ${employee.positiveReviews.toStringAsFixed(0)}%'),
      trailing: Icon(
        employee.isFavorite ? Icons.star : Icons.star_border,
        color: Colors.yellow,
      ),
      onTap: () {
        // Обработка нажатия на карточку сотрудника
      },
    );
  }
}