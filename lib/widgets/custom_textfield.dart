import 'package:employee_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool readOnly;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final Function()? onTap;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.readOnly,
      required this.prefixIcon,
      this.suffixIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.primaryColor,
      readOnly: readOnly,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      onTap: onTap,
    );
  }
}
