import 'package:flutter/material.dart';
import '../data/employee.dart';

class EmployeeCard extends StatefulWidget {
  final Employee employee;
  final bool isFavorite;
  final Function onTap;

  EmployeeCard({
    required this.employee,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  _EmployeeCardState createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('${widget.employee.photoUrl}'),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.employee.firstName} ${widget.employee.lastName}',
                  style: TextStyle(color: Color.fromRGBO(1, 86, 81, 1), fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      '${widget.employee.positiveReviews.toStringAsFixed(0)}% ',
                      style: TextStyle(color: Color.fromRGBO(1, 86, 81, 1),  fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${widget.employee.status}',
                      style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1), fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.star,
              color: widget.isFavorite ? Colors.yellow : Color.fromRGBO(233, 233, 233, 1),
            ),
            onPressed: () {
              setState(() {
                _isTapped = !_isTapped;
              });
              widget.onTap();
            },
          ),
        ],
      ),
    );
  }
}