import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final Color foregroundColor;
  final Color backgroundColor;
  final Function() onPressed;

  const CustomTextButton(
      {super.key,
      required this.title,
      required this.foregroundColor,
      required this.backgroundColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
