import 'package:employee_tracker/models/app_error.dart';
import 'package:employee_tracker/models/employee.dart';

abstract class AddEmployeeDetailsScreenState {}

class AddEmployeeDetailsScreenInitialState
    extends AddEmployeeDetailsScreenState {}

class AddEmployeeDetailsScreenErrorState extends AddEmployeeDetailsScreenState {
  final AppError error;

  AddEmployeeDetailsScreenErrorState({required this.error});
}

class AddEmployeeDetailsScreenInsertedState
    extends AddEmployeeDetailsScreenState {
  final Employee employee;

  AddEmployeeDetailsScreenInsertedState({required this.employee});
}

class AddEmployeeDetailsScreenUpdatedState
    extends AddEmployeeDetailsScreenState {
  final Employee employee;

  AddEmployeeDetailsScreenUpdatedState({required this.employee});
}
