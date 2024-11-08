import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_bloc.dart';
import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_bloc.dart';
import 'package:employee_tracker/screens/add_employee_details_screen.dart';
import 'package:employee_tracker/screens/employee_list_screen.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case employeeListScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => EmployeeListScreenBloc(),
            child: const EmployeeListScreen(),
          ),
        );
      case addEmployeeDetailsScreenRouteName:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AddEmployeeDetailsScreenBloc(),
            child: AddEmployeeDetailsScreen(
              employee: arguments[employeeKey],
              isCurrentEmployee: arguments[isCurrentEmployeeKey],
              employeeListScreenBloc: arguments[employeeListScreenBlocKey],
            ),
          ),
        );
      default:
        return null;
    }
  }
}
