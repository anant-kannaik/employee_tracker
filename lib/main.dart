import 'package:employee_tracker/routes.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: employeeListScreenRouteName,
      title: appNameText,
    );
  }
}
