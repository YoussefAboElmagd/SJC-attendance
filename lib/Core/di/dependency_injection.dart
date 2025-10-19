import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:madarj/Core/all_application_cubit/application_cubit.dart';
// import 'package:madarj/Core/networking/api_service.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Feature/all_works/apis/all_work_service.dart';
import 'package:madarj/Feature/all_works/data/repo/all_work_repo.dart';
import 'package:madarj/Feature/all_works/logic/cubit/all_work_cubit.dart';
import 'package:madarj/Feature/attendance_manager/apis/attendance_manager_services.dart';
import 'package:madarj/Feature/attendance_manager/data/repo/attendance_manager_repo.dart';
import 'package:madarj/Feature/attendance_manager/logic/attendance_manager_cubit.dart';
import 'package:madarj/Feature/expenses/expenses_details/apis/expenses_service.dart';
import 'package:madarj/Feature/expenses/expenses_details/data/repo/expenses_repo.dart';
import 'package:madarj/Feature/expenses/expenses_details/logic/cubit/expenses_cubit.dart';
import 'package:madarj/Feature/expenses/send_expenses/apis/send_expenses_service.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/repo/send_expenses_repo.dart';
import 'package:madarj/Feature/expenses/send_expenses/logic/cubit/send_expenses_cubit.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/apis/show_expenses_details_service.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/repo/get_expense_details_repo.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/logic/cubit/expenses_details_cubit.dart';
import 'package:madarj/Feature/home/apis/home_services.dart';
import 'package:madarj/Feature/home/data/repo/home_repo.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/leave/leave_details/apis/leave_details_service.dart';
import 'package:madarj/Feature/leave/leave_details/data/repo/leave_details_repo.dart';
import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_cubit.dart';
import 'package:madarj/Feature/leave/leave_managment/apis/leave_manager_details_service.dart';
import 'package:madarj/Feature/leave/leave_managment/data/repo/leave_manager_details_repo.dart';
import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_cubit.dart';
import 'package:madarj/Feature/leave/send_leave/apis/send_leave_service.dart';
import 'package:madarj/Feature/leave/send_leave/data/repo/send_leave_repo.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
import 'package:madarj/Feature/payroll/apis/payroll_service.dart';
import 'package:madarj/Feature/payroll/data/repo/payroll_repo.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_cubit.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_cubit.dart';
import 'package:madarj/Feature/registration/login/apis/login_services.dart';
import 'package:madarj/Feature/registration/login/data/repos/login_repo.dart';
import 'package:madarj/Feature/tasks/send_tasks/apis/send_tasks_service.dart';
import 'package:madarj/Feature/tasks/send_tasks/data/repo/send_task_repo.dart';
import 'package:madarj/Feature/tasks/send_tasks/logic/cubit/send_tasks_cubit.dart';
import 'package:madarj/Feature/tasks/show_task/logic/cubit/show_task_details_cubit.dart';

final getIt = GetIt.instance;

Future<void> setGetIt() async {
  Dio dio = await DioFactory.getDio();

  // getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  getIt.registerFactory<ApplicationCubit>(() => ApplicationCubit());

  getIt.registerLazySingleton<LoginService>(() => LoginService(dio));
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  getIt.registerLazySingleton<HomeServices>(() => HomeServices(dio));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  // all works
  getIt.registerLazySingleton<AllWorkService>(() => AllWorkService(dio));
  getIt.registerLazySingleton<AllWorkRepo>(() => AllWorkRepo(getIt()));
  getIt.registerFactory<AllWorkCubit>(() => AllWorkCubit(getIt()));

  //  expenses
  getIt.registerLazySingleton<ExpensesService>(() => ExpensesService(dio));
  getIt.registerLazySingleton<ExpensesRepo>(() => ExpensesRepo(getIt()));
  getIt.registerFactory<ExpensesCubit>(() => ExpensesCubit(getIt()));

  // send expenses
  getIt.registerLazySingleton<SendExpensesService>(
    () => SendExpensesService(dio),
  );
  getIt.registerLazySingleton<SendExpensesRepo>(
    () => SendExpensesRepo(getIt()),
  );
  getIt.registerFactory<SendExpensesCubit>(() => SendExpensesCubit(getIt()));

  // send leave
  getIt.registerLazySingleton<SendLeaveService>(() => SendLeaveService(dio));
  getIt.registerLazySingleton<SendLeaveRepo>(() => SendLeaveRepo(getIt()));
  getIt.registerFactory<SendLeaveCubit>(() => SendLeaveCubit(getIt()));

  // leave
  getIt.registerLazySingleton<LeaveDetailsService>(
    () => LeaveDetailsService(dio),
  );
  getIt.registerLazySingleton<LeaveDetailsRepo>(
    () => LeaveDetailsRepo(getIt()),
  );
  getIt.registerFactory<LeaveDetailsCubit>(() => LeaveDetailsCubit(getIt()));

  // leave Manager
  getIt.registerLazySingleton<LeaveManagerDetailsService>(
    () => LeaveManagerDetailsService(dio),
  );
  getIt.registerLazySingleton<LeaveManagerDetailsRepo>(
    () => LeaveManagerDetailsRepo(getIt()),
  );
  getIt.registerFactory<LeaveManagerDetailsCubit>(
    () => LeaveManagerDetailsCubit(getIt()),
  );

  // Send Tasks
  getIt.registerLazySingleton<SendTasksService>(() => SendTasksService(dio));
  getIt.registerLazySingleton<SendTaskRepo>(() => SendTaskRepo(getIt()));
  getIt.registerFactory<SendTasksCubit>(() => SendTasksCubit(getIt()));

  // payroll
  getIt.registerLazySingleton<PayrollService>(() => PayrollService(dio));
  getIt.registerLazySingleton<PayrollRepo>(() => PayrollRepo(getIt()));
  getIt.registerFactory<PayrollCubit>(() => PayrollCubit(getIt()));

  // ShowTaskDetailsCubit
  getIt.registerFactory<ShowTaskDetailsCubit>(() => ShowTaskDetailsCubit());

  getIt.registerLazySingleton<ShowExpensesDetailsService>(
    () => ShowExpensesDetailsService(dio),
  );
  getIt.registerLazySingleton<GetExpenseDetailsRepo>(
    () => GetExpenseDetailsRepo(getIt()),
  );
  getIt.registerFactory<ExpensesDetailsCubit>(
    () => ExpensesDetailsCubit(getIt()),
  );
  // Attendance Manager
  getIt.registerLazySingleton<AttendanceManagerServices>(
    () => AttendanceManagerServices(dio),
  );
  getIt.registerLazySingleton<AttendanceManagerRepo>(
    () => AttendanceManagerRepo(getIt()),
  );
  getIt.registerFactory<AttendanceManagerCubit>(
    () => AttendanceManagerCubit(getIt()),
  );
}
