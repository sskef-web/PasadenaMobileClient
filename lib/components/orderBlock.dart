import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderBlock extends StatelessWidget {
  final String headImageUrl;
  final String employeeImageUrl;
  final String title;
  final String employeeName;
  final DateTime selectedDateTime;
  final int reservationStatus;

  const OrderBlock({
    required this.headImageUrl,
    required this.employeeImageUrl,
    required this.title,
    required this.employeeName,
    required this.selectedDateTime,
    required this.reservationStatus
  });

  Icon getReservationStatusIcon(int value) {
    switch (value) {
      case 1:
        return const Icon(
            Icons.history_toggle_off,
            color: Color.fromRGBO(35, 149, 255, 1),
            size: 28.0
        );
      case 2:
        return const Icon(
            Icons.event_available,
            color: Color.fromRGBO(1, 86, 81, 1),
            size: 28.0
        );
      case 3:
        return const Icon(
            Icons.disabled_by_default_outlined,
            color: Color.fromRGBO(173, 0, 0, 1),
            size: 28.0
        );
      case 4:
        return const Icon(
            Icons.check_circle,
            color: Color.fromRGBO(1, 86, 81, 1),
            size: 28.0
        );
      default:
        return const Icon(Icons.disabled_by_default, color: Colors.transparent,);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMMM yyyy', Localizations.localeOf(context).languageCode);
    final dateFormatTime = DateFormat('HH:mm', Localizations.localeOf(context).languageCode);

    return Container(
      margin: EdgeInsets.only(bottom: 8.0, top: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
            child: Image.network(
              headImageUrl,
              width: double.infinity,
              height: 60.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Color.fromRGBO(1, 86, 81, 1)),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        employeeImageUrl,
                        width: 60.0,
                        height: 60.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employeeName,
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(1, 86, 81, 1)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${dateFormat.format(selectedDateTime)}',
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w100,
                                        color: Color.fromRGBO(136, 136, 136, 1)
                                    ),
                                  ),
                                  Text(
                                    ' ${dateFormatTime.format(selectedDateTime)}',
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(1, 86, 81, 1)
                                    ),
                                  ),
                                ],
                              ),
                              getReservationStatusIcon(reservationStatus),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
