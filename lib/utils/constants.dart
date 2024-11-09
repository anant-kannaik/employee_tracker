const appNameText = 'Employee Tracker';

const employeeListScreenRouteName = '/EmployeeList';
const addEmployeeDetailsScreenRouteName = '/AddEmployeeDetails';

const employeeKey = 'employee';
const isCurrentEmployeeKey = 'isCurrentEmployee';
const employeeListScreenBlocKey = 'employeeListScreenBloc';

const employeeListScreenTitle = 'Employee List';
const addEmployeeDetailsScreenTitle = 'Add Employee Details';
const editEmployeeDetailsScreenTitle = 'Edit Employee Details';

const noEmployeeImageName = 'assets/no_employee_image.png';

const employeeNameHintText = 'Employee name';
const selectRoleHintText = 'Select role';

const todayDateHintText = 'Today';
const noDateHintText = 'No date';

const cancelButtonText = 'Cancel';
const saveButtonText = 'Save';

const List<String> roleTypes = [
  'Product Designer',
  'Flutter Developer',
  'QA Tester',
  'Product Owner'
];

const dateFormat = 'dd MMM, y';

enum DateSelection { today, nextMonday, nextTuesday, after1Week, noDate, date }

const appErrorCode = '0';
const enterEmployeeNameAndRoleMessage = 'Please enter employee name and role';
const leavingDateGreaterThanJoiningDateMessage =
    'Leaving date cannot be greater than joining date';
const employeeDataDeletedMessage = 'Employee data has been deleted';

const currentEmployeesText = 'Current employees';
const previousEmployeesText = 'Previous employees';

const swipeLeftToDeleteMessage = 'Swipe left to delete';

const todayButtonTitle = 'Today';
const nextMondayButtonTitle = 'Next Monday';
const nextTuesdayButtonTitle = 'Next Tuesday';
const after1WeekButtonTitle = 'After 1 week';
const noDateButtonTitle = 'No date';
