class Employee {
  final int?
      id; // Explicitly assigning a value of NULL to id, it will get the next auto-increment value.
  final String name;
  final String role;
  final String fromDate;
  final String toDate;

  Employee(
      {required this.id,
      required this.name,
      required this.role,
      required this.fromDate,
      required this.toDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      role: map['role'],
      fromDate: map['fromDate'],
      toDate: map['toDate'],
    );
  }
}
