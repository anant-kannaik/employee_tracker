import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_event.dart';
import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_state.dart';
import 'package:employee_tracker/models/app_error.dart';
import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/repository/employee_repository.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:employee_tracker/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeDetailsScreenBloc
    extends Bloc<AddEmployeeDetailsScreenEvent, AddEmployeeDetailsScreenState> {
  AddEmployeeDetailsScreenBloc()
      : super(AddEmployeeDetailsScreenInitialState()) {
    on<InsertEmployeeEvent>(_handleInsertEmployee);
    on<UpdateEmployeeEvent>(_handleUpdateEmployee);
  }

  void _handleInsertEmployee(InsertEmployeeEvent event,
      Emitter<AddEmployeeDetailsScreenState> emit) async {
    String fromDate = event.fromDate == todayDateHintText
        ? getFormattedDateTime(getDateForSelectedEnum(DateSelection.today))
        : event.fromDate;
    String toDate = event.toDate;

    if (event.name.isEmpty || event.role.isEmpty) {
      emit(AddEmployeeDetailsScreenErrorState(
          error: AppError(
              errorCode: appErrorCode,
              message: enterEmployeeNameAndRoleMessage)));
    } else if (toDate != noDateHintText &&
        !checkIfDatesValid(fromDate, toDate)) {
      emit(AddEmployeeDetailsScreenErrorState(
          error: AppError(
              errorCode: appErrorCode,
              message: leavingDateGreaterThanJoiningDateMessage)));
    } else {
      Employee employee = Employee(
          id: null, // Explicitly assigning a value of NULL to id, it will get the next auto-increment value.
          name: event.name,
          role: event.role,
          fromDate: fromDate,
          toDate: toDate);

      await EmployeeRepository.sharedInstance.insertEmployee(employee);

      emit(AddEmployeeDetailsScreenInsertedState(employee: employee));
    }
  }

  void _handleUpdateEmployee(UpdateEmployeeEvent event,
      Emitter<AddEmployeeDetailsScreenState> emit) async {
    if (event.name.isEmpty || event.role.isEmpty) {
      emit(AddEmployeeDetailsScreenErrorState(
          error: AppError(
              errorCode: appErrorCode,
              message: enterEmployeeNameAndRoleMessage)));
    } else if (event.toDate != noDateHintText &&
        !checkIfDatesValid(event.fromDate, event.toDate)) {
      emit(AddEmployeeDetailsScreenErrorState(
          error: AppError(
              errorCode: appErrorCode,
              message: leavingDateGreaterThanJoiningDateMessage)));
    } else {
      Employee employee = Employee(
          id: event.id,
          name: event.name,
          role: event.role,
          fromDate: event.fromDate,
          toDate: event.toDate);
      await EmployeeRepository.sharedInstance.updateEmployee(employee);

      emit(AddEmployeeDetailsScreenUpdatedState(employee: employee));
    }
  }
}
