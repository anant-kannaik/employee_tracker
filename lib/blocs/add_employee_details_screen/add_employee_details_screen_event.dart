abstract class AddEmployeeDetailsScreenEvent {}

class InsertEmployeeEvent extends AddEmployeeDetailsScreenEvent {
  final String name;
  final String role;
  final String fromDate;
  final String toDate;

  InsertEmployeeEvent(
      {required this.name,
      required this.role,
      required this.fromDate,
      required this.toDate});
}

class UpdateEmployeeEvent extends AddEmployeeDetailsScreenEvent {
  final int id;
  final String name;
  final String role;
  final String fromDate;
  final String toDate;

  UpdateEmployeeEvent(
      {required this.id,
      required this.name,
      required this.role,
      required this.fromDate,
      required this.toDate});
}
