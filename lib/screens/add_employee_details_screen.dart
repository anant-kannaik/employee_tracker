import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_bloc.dart';
import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_event.dart';
import 'package:employee_tracker/blocs/add_employee_details_screen/add_employee_details_screen_state.dart';
import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_bloc.dart';
import 'package:employee_tracker/blocs/employee_list_screen/employee_list_screen_event.dart';
import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/utils/app_colors.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:employee_tracker/utils/utils.dart';
import 'package:employee_tracker/widgets/custom_date_view.dart';
import 'package:employee_tracker/widgets/custom_text_button.dart';
import 'package:employee_tracker/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEmployeeDetailsScreen extends StatefulWidget {
  final Employee? employee;
  final bool isCurrentEmployee;
  final EmployeeListScreenBloc employeeListScreenBloc;

  const AddEmployeeDetailsScreen(
      {super.key,
      required this.employee,
      required this.isCurrentEmployee,
      required this.employeeListScreenBloc});

  @override
  State<AddEmployeeDetailsScreen> createState() =>
      _AddEmployeeDetailsScreenState();
}

class _AddEmployeeDetailsScreenState extends State<AddEmployeeDetailsScreen> {
  final _employeeNameController = TextEditingController();
  final _employeeRoleController = TextEditingController();
  late String _selectedFromDate;
  late String _selectedToDate;

  @override
  void initState() {
    _employeeNameController.text =
        widget.employee != null ? widget.employee!.name : '';
    _employeeRoleController.text =
        widget.employee != null ? widget.employee!.role : '';
    _selectedFromDate =
        widget.employee != null ? widget.employee!.fromDate : todayDateHintText;
    _selectedToDate =
        widget.employee != null ? widget.employee!.toDate : noDateHintText;

    super.initState();
  }

  @override
  void dispose() {
    _employeeNameController.dispose();
    _employeeRoleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(widget.employee != null
            ? editEmployeeDetailsScreenTitle
            : addEmployeeDetailsScreenTitle),
        actions: [
          if (widget.employee != null) ...[
            IconButton(
              onPressed: () {
                widget.employeeListScreenBloc.add(DeleteEmployeeEvent(
                    isCurrentEmployee: widget.isCurrentEmployee,
                    employee: widget.employee!));
                Navigator.pop(context);
              },
              icon: const Icon(
                CupertinoIcons.delete,
                size: 22.0,
              ),
            )
          ]
        ],
      ),
      body: BlocListener<AddEmployeeDetailsScreenBloc,
          AddEmployeeDetailsScreenState>(
        listener: (BuildContext context, state) {
          if (state is AddEmployeeDetailsScreenInsertedState) {
            widget.employeeListScreenBloc.add(FetchEmployeesEvent());
            Navigator.pop(context);
          } else if (state is AddEmployeeDetailsScreenUpdatedState) {
            widget.employeeListScreenBloc.add(FetchEmployeesEvent());
            Navigator.pop(context);
          } else if (state is AddEmployeeDetailsScreenErrorState) {
            showSnackBar(context, state.error.message);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomTextField(
                    hintText: employeeNameHintText,
                    controller: _employeeNameController,
                    readOnly: false,
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomTextField(
                    hintText: selectRoleHintText,
                    controller: _employeeRoleController,
                    readOnly: true,
                    prefixIcon: const Icon(
                      CupertinoIcons.bag,
                      color: AppColors.primaryColor,
                    ),
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      showRolesBottomSheet();
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomDateView(
                          selectedDate: _selectedFromDate,
                          onTap: () {
                            _showDateTimePickerDialog(
                                true, DateSelection.today);
                          },
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.arrow_forward,
                          color: AppColors.primaryColor,
                          size: 20.0,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CustomDateView(
                          selectedDate: _selectedToDate,
                          onTap: () {
                            _showDateTimePickerDialog(
                                false, DateSelection.noDate);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.black38,
                            width: 1.0,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          CustomTextButton(
                            title: cancelButtonText,
                            foregroundColor: AppColors.primaryColor,
                            backgroundColor: const Color(0xffEDF8FF),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 16.0),
                          CustomTextButton(
                            title: saveButtonText,
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () {
                              if (widget.employee != null) {
                                BlocProvider.of<AddEmployeeDetailsScreenBloc>(
                                        context)
                                    .add(
                                  UpdateEmployeeEvent(
                                    id: widget.employee!.id!,
                                    name: _employeeNameController.text.trim(),
                                    role: _employeeRoleController.text.trim(),
                                    fromDate: _selectedFromDate,
                                    toDate: _selectedToDate,
                                  ),
                                );
                              } else {
                                BlocProvider.of<AddEmployeeDetailsScreenBloc>(
                                        context)
                                    .add(
                                  InsertEmployeeEvent(
                                    name: _employeeNameController.text.trim(),
                                    role: _employeeRoleController.text.trim(),
                                    fromDate: _selectedFromDate,
                                    toDate: _selectedToDate,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showRolesBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 8.0),
          height: 220.0,
          alignment: Alignment.center,
          child: ListView.separated(
            itemCount: roleTypes.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      roleTypes[index],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _employeeRoleController.text = roleTypes[index];
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }

  _showDateTimePickerDialog(bool isFromDate, DateSelection preSelectedDate) {
    DateRangePickerController dateRangePickerController =
        DateRangePickerController();
    DateSelection selectedButton = preSelectedDate;
    String selectedDate = preSelectedDate == DateSelection.noDate
        ? noDateHintText
        : getFormattedDateTime(getDateForSelectedEnum(selectedButton));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(16.0),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isFromDate) ...[
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextButton(
                            title: todayButtonTitle,
                            foregroundColor:
                                selectedButton == DateSelection.today
                                    ? Colors.white
                                    : AppColors.primaryColor,
                            backgroundColor:
                                selectedButton == DateSelection.today
                                    ? AppColors.primaryColor
                                    : const Color(0xffEDF8FF),
                            onPressed: () {
                              setState(() {
                                dateRangePickerController.selectedDate =
                                    getDateForSelectedEnum(DateSelection.today);
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: CustomTextButton(
                            title: nextMondayButtonTitle,
                            foregroundColor:
                                selectedButton == DateSelection.nextMonday
                                    ? Colors.white
                                    : AppColors.primaryColor,
                            backgroundColor:
                                selectedButton == DateSelection.nextMonday
                                    ? AppColors.primaryColor
                                    : const Color(0xffEDF8FF),
                            onPressed: () {
                              setState(() {
                                dateRangePickerController.selectedDate =
                                    getDateForSelectedEnum(
                                        DateSelection.nextMonday);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextButton(
                            title: nextTuesdayButtonTitle,
                            foregroundColor:
                                selectedButton == DateSelection.nextTuesday
                                    ? Colors.white
                                    : AppColors.primaryColor,
                            backgroundColor:
                                selectedButton == DateSelection.nextTuesday
                                    ? AppColors.primaryColor
                                    : const Color(0xffEDF8FF),
                            onPressed: () {
                              setState(() {
                                dateRangePickerController.selectedDate =
                                    getDateForSelectedEnum(
                                        DateSelection.nextTuesday);
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: CustomTextButton(
                            title: after1WeekButtonTitle,
                            foregroundColor:
                                selectedButton == DateSelection.after1Week
                                    ? Colors.white
                                    : AppColors.primaryColor,
                            backgroundColor:
                                selectedButton == DateSelection.after1Week
                                    ? AppColors.primaryColor
                                    : const Color(0xffEDF8FF),
                            onPressed: () {
                              setState(() {
                                dateRangePickerController.selectedDate =
                                    getDateForSelectedEnum(
                                        DateSelection.after1Week);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextButton(
                            title: noDateButtonTitle,
                            foregroundColor:
                                selectedButton == DateSelection.noDate
                                    ? Colors.white
                                    : AppColors.primaryColor,
                            backgroundColor:
                                selectedButton == DateSelection.noDate
                                    ? AppColors.primaryColor
                                    : const Color(0xffEDF8FF),
                            onPressed: () {
                              setState(() {
                                selectedButton = DateSelection.noDate;
                                selectedDate = noDateHintText;
                                dateRangePickerController.selectedDate = null;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: CustomTextButton(
                            title: todayButtonTitle,
                            foregroundColor:
                                selectedButton == DateSelection.today
                                    ? Colors.white
                                    : AppColors.primaryColor,
                            backgroundColor:
                                selectedButton == DateSelection.today
                                    ? AppColors.primaryColor
                                    : const Color(0xffEDF8FF),
                            onPressed: () {
                              setState(() {
                                dateRangePickerController.selectedDate =
                                    getDateForSelectedEnum(DateSelection.today);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 260.0,
                    child: SfDateRangePicker(
                      controller: dateRangePickerController,
                      onSelectionChanged:
                          (dateRangePickerSelectionChangedArgs) {
                        if (dateRangePickerSelectionChangedArgs.value != null) {
                          setState(() {
                            selectedDate = getFormattedDateTime(
                                dateRangePickerSelectionChangedArgs.value);
                            selectedButton =
                                getEnumForSelectedDate(selectedDate);
                          });
                        }
                      },
                      selectionMode: DateRangePickerSelectionMode.single,
                      allowViewNavigation: false,
                      maxDate: isFromDate
                          ? null
                          : DateTime
                              .now(), // Future dates are disabled for employee leaving date
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black38,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.primaryColor,
                            size: 20.0,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              selectedDate,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          CustomTextButton(
                            title: cancelButtonText,
                            foregroundColor: AppColors.primaryColor,
                            backgroundColor: const Color(0xffEDF8FF),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 16.0),
                          CustomTextButton(
                            title: saveButtonText,
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () {
                              _onDateSelectionChanged(isFromDate, selectedDate);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _onDateSelectionChanged(bool isFromDate, String selectedDate) {
    setState(() {
      if (isFromDate) {
        _selectedFromDate = selectedDate;
      } else {
        _selectedToDate = selectedDate;
      }
    });
  }
}
