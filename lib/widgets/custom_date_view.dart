import 'package:employee_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDateView extends StatelessWidget {
  final String selectedDate;
  final Function() onTap;

  const CustomDateView(
      {super.key, required this.selectedDate, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: Icon(
                Icons.calendar_today_outlined,
                color: AppColors.primaryColor,
                size: 22.0,
              ),
            ),
            Text(
              selectedDate,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
