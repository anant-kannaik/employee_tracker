import 'package:employee_tracker/models/employee.dart';

abstract class EmployeeListScreenState {}

class EmployeeListScreenInitialState extends EmployeeListScreenState {}

class EmployeeListScreenLoadingState extends EmployeeListScreenState {}

class EmployeeListScreenFetchedState extends EmployeeListScreenState {
  final List<Employee> currentEmployees;
  final List<Employee> previousEmployees;

  EmployeeListScreenFetchedState(
      {required this.currentEmployees, required this.previousEmployees});
}

class EmployeeListScreenDeletedState extends EmployeeListScreenState {
  final bool isCurrentEmployee;
  final Employee employee;

  EmployeeListScreenDeletedState(
      {required this.isCurrentEmployee, required this.employee});
}
