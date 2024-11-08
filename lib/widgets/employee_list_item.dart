import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/utils/utils.dart';
import 'package:flutter/material.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;
  final Function(Employee employee) onItemTap;

  const EmployeeListItem(
      {super.key, required this.employee, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff323238),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  employee.role,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff949C9E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Row(
              children: [
                Text(
                  getDateForEmployee(employee),
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff949C9E),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        onItemTap(employee);
      },
    );
  }
}
