import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_bloc.dart';
import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_event.dart';
import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_state.dart';
import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/utils/app_colors.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:employee_tracker/utils/utils.dart';
import 'package:employee_tracker/widgets/employee_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final List<Employee> _currentEmployees = [];
  final List<Employee> _previousEmployees = [];
  late EmployeeListScreenBloc _employeeListScreenBloc;

  @override
  void initState() {
    _employeeListScreenBloc = BlocProvider.of<EmployeeListScreenBloc>(context);
    _employeeListScreenBloc.add(FetchEmployeesEvent());
    super.initState();
  }

  @override
  void dispose() {
    _employeeListScreenBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(employeeListScreenTitle),
      ),
      body: BlocListener<EmployeeListScreenBloc, EmployeeListScreenState>(
        listener: (BuildContext context, state) {
          if (state is EmployeeListScreenFetchedState) {
            setState(() {
              _currentEmployees.clear();
              _previousEmployees.clear();
              _currentEmployees.addAll(state.currentEmployees);
              _previousEmployees.addAll(state.previousEmployees);
            });
          } else if (state is EmployeeListScreenDeletedState) {
            setState(() {
              if (state.isCurrentEmployee) {
                _currentEmployees.remove(state.employee);
              } else {
                _previousEmployees.remove(state.employee);
              }
            });
            showSnackBar(context, employeeDataDeletedMessage);
          }
        },
        child: SafeArea(
          child: _getEmployeeListView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            addEmployeeDetailsScreenRouteName,
            arguments: {
              employeeKey: null,
              isCurrentEmployeeKey: false,
              employeeListScreenBlocKey: _employeeListScreenBloc,
            },
          );
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  _getEmployeeListView() {
    return _currentEmployees.isNotEmpty || _previousEmployees.isNotEmpty
        ? Column(
            children: [
              Expanded(
                flex: 1,
                child: _getHeaderView(currentEmployeesText),
              ),
              Expanded(
                flex: 5,
                child: _getCurrentEmployees(),
              ),
              Expanded(
                flex: 1,
                child: _getHeaderView(previousEmployeesText),
              ),
              Expanded(
                flex: 5,
                child: _getPreviousEmployees(),
              ),
              Expanded(
                flex: 1,
                child: _getSwipeToDeleteHeaderView(),
              ),
            ],
          )
        : Center(
            child: Image.asset(
              noEmployeeImageName,
              height: 220.0,
            ),
          );
  }

  _getHeaderView(String title) {
    return Container(
      color: const Color(0xffF2F2F2),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  _getSwipeToDeleteHeaderView() {
    return Container(
      color: const Color(0xffF2F2F2),
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              swipeLeftToDeleteMessage,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: Color(0xff949C9E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getCurrentEmployees() {
    return ListView.separated(
      itemCount: _currentEmployees.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 0.0);
      },
      itemBuilder: (BuildContext context, int index) {
        final item = _currentEmployees[index];
        return Dismissible(
          key: Key(item.id.toString()),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(
              CupertinoIcons.delete,
              color: Colors.white,
              size: 22.0,
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            _employeeListScreenBloc.add(
              DeleteEmployeeEvent(isCurrentEmployee: true, employee: item),
            );
          },
          child: EmployeeListItem(
            employee: _currentEmployees[index],
            onItemTap: (employee) {
              Navigator.pushNamed(
                context,
                addEmployeeDetailsScreenRouteName,
                arguments: {
                  employeeKey: employee,
                  isCurrentEmployeeKey: true,
                  employeeListScreenBlocKey: _employeeListScreenBloc,
                },
              );
            },
          ),
        );
      },
    );
  }

  _getPreviousEmployees() {
    return ListView.separated(
      itemCount: _previousEmployees.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 0.0);
      },
      itemBuilder: (BuildContext context, int index) {
        final item = _previousEmployees[index];
        return Dismissible(
          key: Key(item.id.toString()),
          onDismissed: (direction) {
            _employeeListScreenBloc.add(
              DeleteEmployeeEvent(isCurrentEmployee: false, employee: item),
            );
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(
              CupertinoIcons.delete,
              color: Colors.white,
              size: 22.0,
            ),
          ),
          direction: DismissDirection.endToStart,
          child: EmployeeListItem(
            employee: _previousEmployees[index],
            onItemTap: (employee) {
              Navigator.pushNamed(
                context,
                addEmployeeDetailsScreenRouteName,
                arguments: {
                  employeeKey: employee,
                  isCurrentEmployeeKey: false,
                  employeeListScreenBlocKey: _employeeListScreenBloc,
                },
              );
            },
          ),
        );
      },
    );
  }
}
