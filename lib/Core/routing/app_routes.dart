import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Core/di/dependency_injection.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Feature/LanguageOption/Ui/language_options.dart';
import 'package:madarj/Feature/all_works/ui/all_works.dart';
import 'package:madarj/Feature/attendance_manager/ui/attendance_manager.dart';
import 'package:madarj/Feature/base/ui/views/base_layer.dart';
import 'package:madarj/Feature/cards/ui/cards_screen.dart';
import 'package:madarj/Feature/clock_in/ui/clock_in_screen.dart';
import 'package:madarj/Feature/expenses/expenses_details/logic/cubit/expenses_cubit.dart';
import 'package:madarj/Feature/expenses/expenses_details/ui/expenses.dart';
import 'package:madarj/Feature/expenses/send_expenses/ui/send_expenses.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/ui/show_expenses_details.dart';
import 'package:madarj/Feature/home/ui/home.dart';
import 'package:madarj/Feature/leave/leave_details/logic/cubit/leave_details_cubit.dart';
import 'package:madarj/Feature/leave/leave_details/ui/leave_screen.dart';
import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_cubit.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/leave_manager_screen.dart';
import 'package:madarj/Feature/leave/send_leave/logic/cubit/send_leave_cubit.dart';
import 'package:madarj/Feature/leave/send_leave/ui/send_leave.dart';
import 'package:madarj/Feature/on_boarding/ui/on_boarding_screen.dart';
import 'package:madarj/Feature/payroll/logic/cubit/payroll_cubit.dart';
import 'package:madarj/Feature/payroll/ui/payroll.dart';
import 'package:madarj/Feature/payroll/ui/widget/payroll_details.dart';
import 'package:madarj/Feature/registration/login/Logic/cubit/login_cubit.dart';
import 'package:madarj/Feature/registration/login/Ui/login.dart';
import 'package:madarj/Feature/tasks/send_tasks/ui/send_tasks.dart';
import 'package:madarj/Feature/tasks/show_task/ui/show_task.dart';
import 'package:madarj/Feature/tasks/tasks_details/ui/tasks.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    var arg = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<LoginCubit>(
                create: (context) => getIt<LoginCubit>(),
                child: const Login(),
              ),
        );
      case Routes.baseLayer:
        final index = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => BaseLayer(initialIndex: index),
        );
      // case Routes.baseLayer:
      //   return MaterialPageRoute(
      //     builder: (_) => const BaseLayer(),
      //   );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.leaveScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<LeaveDetailsCubit>()..getAllLeaves(context),
                child: const Leave(),
              ),
        );
      case Routes.leaveManager:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<LeaveManagerDetailsCubit>()
                          ..getAllLeaves(context),
                child: const LeaveManager(),
              ),
        );
      case Routes.expenseScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ExpensesCubit>(),
                child: const Expenses(),
              ),
        );
      case Routes.showExpensesDetailsBody:
        final args = settings.arguments as Map<String, dynamic>?;

        return MaterialPageRoute(
          builder:
              (_) => ShowExpensesDetails(
                isApproved: args?['isApproved'] as bool?,
                rejected: args?['rejected'] as bool?,
                pending: args?['pending'] as bool?,
                isNew: args?['isNew'] as bool?,
                id: args?['id'] as int?,
              ),
        );
      case Routes.tasksScreen:
        return MaterialPageRoute(builder: (_) => const Tasks());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.clockInScreen:
        return MaterialPageRoute(builder: (_) => const ClockInScreen());
      case Routes.allMonthWorks:
        return MaterialPageRoute(builder: (_) => const AllMonthWorks());
      case Routes.language:
        return MaterialPageRoute(builder: (_) => const Languageoptions());
      case Routes.payrollDetails:
        final args = settings.arguments as Map<String, dynamic>?;

        return MaterialPageRoute(
          builder: (_) => PayrollDetails(payslipId: args?['id'] ?? 0),
        );
      case Routes.payroll:
        final args = settings.arguments as Map<String, dynamic>?;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<PayrollCubit>()
                          ..getEmployeePayslips(context, "0"),
                child: const Payroll(),
              ),
        );
      case Routes.sendExpenses:
        final args = settings.arguments as Map<String, dynamic>?;
        print(args?['id']);
        return MaterialPageRoute(
          builder:
              (_) => SendExpenses(
                update: args?['update'] ?? false,
                id: args?['id'] ?? 0,
              ),
        );
      case Routes.sendLeave:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<SendLeaveCubit>()..getTimeoffTypes(context),
                child: const SendLeave(),
              ),
        );
      case Routes.sendTasks:
        return MaterialPageRoute(builder: (_) => const SendTasks());
      case Routes.taskDetails:
        return MaterialPageRoute(builder: (_) => const ShowTaskDetails());
      case Routes.cardsScreen:
        return MaterialPageRoute(builder: (_) => const CardsScreen());
      case Routes.attendanceManager:
        return MaterialPageRoute(builder: (_) => const AttendanceManager());
    }
    return null;
  }
}
