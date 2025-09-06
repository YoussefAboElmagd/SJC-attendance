import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';
import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_cubit.dart';
import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_state.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/widget/leave_log_manager_card.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/widget/leave_manager_body.dart';
import 'package:madarj/Feature/leave/leave_managment/ui/widget/no_leave_manager_today.dart';

class ListOfManagerLeave extends StatefulWidget {
  const ListOfManagerLeave({
    super.key,
    this.data,
    required this.selectedIndex,
    this.isPending,
  });
  final List<HolidayRequestData>? data;

  final int selectedIndex;
  final bool? isPending;

  @override
  State<ListOfManagerLeave> createState() => _ListOfManagerLeaveState();
}

class _ListOfManagerLeaveState extends State<ListOfManagerLeave> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    controller.removeListener(_onScroll);
    controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (widget.selectedIndex == 0) {
        if (context.read<LeaveManagerDetailsCubit>().hasNextPending) {
          context.read<LeaveManagerDetailsCubit>().getPendingTimeoff(
            context,
            context.read<LeaveManagerDetailsCubit>().pagePending + 1,
          );
        }
      } else if (widget.selectedIndex == 1) {
        if (context.read<LeaveManagerDetailsCubit>().hasNextApprove) {
          context.read<LeaveManagerDetailsCubit>().getApprovedTimeoff(
            context,
            context.read<LeaveManagerDetailsCubit>().pageApprove + 1,
          );
        }
      } else {
        if (context.read<LeaveManagerDetailsCubit>().hasNextRefused) {
          context.read<LeaveManagerDetailsCubit>().getRefusedTimeoff(
            context,
            context.read<LeaveManagerDetailsCubit>().pageRefused + 1,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveManagerDetailsCubit, LeaveManagerDetailsState>(
      builder: (context, state) {
        if (state is GetPendingLeaveError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setUpErrorState(context, state.error);
          });
          return const SizedBox.shrink();
        }
        if (state is GetRefusedLeaveError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setUpErrorState(context, state.apiErrorModel);
          });
          return const SizedBox.shrink();
        }
        if (state is GetApprovedLeaveError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setUpErrorState(context, state.apiErrorModel);
          });
          return const SizedBox.shrink();
        }
        return SizedBox(
          height: (MediaQuery.sizeOf(context).height - 275.h),
          child:
              widget.data == null || widget.data!.isEmpty
                  ? const NoLeaveToday()
                  : Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: controller,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          itemBuilder: (context, index) {
                            return index == widget.data!.length - 1
                                ? Padding(
                                  padding: EdgeInsets.only(bottom: 25.h),
                                  child: LeaveManagerLogCard(
                                    data: widget.data![index],
                                    isPending: widget.isPending ?? false,
                                  ),
                                )
                                : LeaveManagerLogCard(
                                  data: widget.data![index],
                                  isPending: widget.isPending ?? false,
                                );
                          },
                          separatorBuilder:
                              (context, index) => SizedBox(height: 15.h),
                          itemCount: widget.data!.length,
                        ),
                      ),

                      state is GetPendingLeaveLoading ||
                              state is GetRefusedLeaveLoading ||
                              state is GetApprovedLeaveLoading
                          ? const SizedBox(
                            child: Center(child: CircularProgressIndicator()),
                          )
                          : const SizedBox.shrink(),
                    ],
                  ),
        );
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:madarj/Feature/leave/leave_managment/data/model/new_holiday_response.dart';
// import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_cubit.dart';
// import 'package:madarj/Feature/leave/leave_managment/logic/cubit/leave_manager_details_state.dart';
// import 'package:madarj/Feature/leave/leave_managment/ui/widget/leave_log_manager_card.dart';
// import 'package:madarj/Feature/leave/leave_managment/ui/widget/leave_manager_body.dart';
// import 'package:madarj/Feature/leave/leave_managment/ui/widget/no_leave_manager_today.dart';

// class ListOfManagerLeave extends StatefulWidget {
//   const ListOfManagerLeave({
//     super.key,
//     this.data,
//     required this.selectedIndex,
//     this.isPending,
//   });
//   final List<HolidayRequestData>? data;

//   final int selectedIndex;
//   final bool? isPending;

//   @override
//   State<ListOfManagerLeave> createState() => _ListOfManagerLeaveState();
// }

// class _ListOfManagerLeaveState extends State<ListOfManagerLeave> {
//   final controller = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     controller.removeListener(_onScroll);
//     controller.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (controller.position.pixels == controller.position.maxScrollExtent) {
//       if (widget.selectedIndex == 0) {
//         if (context.read<LeaveManagerDetailsCubit>().hasNextPending) {
//           context.read<LeaveManagerDetailsCubit>().getPendingTimeoff(
//             context,
//             context.read<LeaveManagerDetailsCubit>().pagePending + 1,
//           );
//         }
//       } else if (widget.selectedIndex == 1) {
//         if (context.read<LeaveManagerDetailsCubit>().hasNextApprove) {
//           context.read<LeaveManagerDetailsCubit>().getApprovedTimeoff(
//             context,
//             context.read<LeaveManagerDetailsCubit>().pageApprove + 1,
//           );
//         }
//       } else {
//         if (context.read<LeaveManagerDetailsCubit>().hasNextRefused) {
//           context.read<LeaveManagerDetailsCubit>().getRefusedTimeoff(
//             context,
//             context.read<LeaveManagerDetailsCubit>().pageRefused + 1,
//           );
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LeaveManagerDetailsCubit, LeaveManagerDetailsState>(
//       builder: (context, state) {
//         if (state is GetPendingLeaveError) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             setUpErrorState(context, state.error);
//           });
//           return const SizedBox.shrink();
//         }
//         if (state is GetRefusedLeaveError) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             setUpErrorState(context, state.apiErrorModel);
//           });
//           return const SizedBox.shrink();
//         }
//         if (state is GetApprovedLeaveError) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             setUpErrorState(context, state.apiErrorModel);
//           });
//           return const SizedBox.shrink();
//         }
//         return SizedBox(
//           height: (MediaQuery.sizeOf(context).height - 270.h),
//           child:
//               widget.data == null || widget.data!.isEmpty
//                   ? const NoLeaveToday()
//                   : Column(
//                     children: [
//                       Expanded(
//                         child: ListView.separated(
//                           controller: controller,
//                           padding: EdgeInsets.symmetric(vertical: 10.h),
//                           itemBuilder: (context, index) {
//                             return index == widget.data!.length - 1
//                                 ? Padding(
//                                   padding: EdgeInsets.only(bottom: 25.h),
//                                   child: LeaveManagerLogCard(
//                                     data: widget.data![index],
//                                     isPending: widget.isPending ?? false,
//                                   ),
//                                 )
//                                 : LeaveManagerLogCard(
//                                   data: widget.data![index],
//                                   isPending: widget.isPending ?? false,
//                                 );
//                           },
//                           separatorBuilder:
//                               (context, index) => SizedBox(height: 15.h),
//                           itemCount: widget.data!.length,
//                         ),
//                       ),

//                       state is GetPendingLeaveLoading ||
//                               state is GetRefusedLeaveLoading ||
//                               state is GetApprovedLeaveLoading
//                           ? const SizedBox(
//                             child: Center(child: CircularProgressIndicator()),
//                           )
//                           : const SizedBox.shrink(),
//                     ],
//                   ),
//         );
//       },
//     );
//   }
// }
