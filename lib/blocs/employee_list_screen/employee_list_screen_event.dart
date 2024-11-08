import 'package:employee_tracker/models/employee.dart';

abstract class EmployeeListScreenEvent {}

class FetchEmployeesEvent extends EmployeeListScreenEvent {}

class DeleteEmployeeEvent extends EmployeeListScreenEvent {
  final bool isCurrentEmployee;
  final Employee employee;

  DeleteEmployeeEvent(
      {required this.isCurrentEmployee, required this.employee});
}
