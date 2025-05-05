import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madarj/Feature/all_works/data/repo/all_work_repo.dart';
import 'package:madarj/Feature/all_works/logic/cubit/all_work_state.dart';

class AllWorkCubit extends Cubit<AllWorkState> {
  AllWorkCubit(this._allWorkRepo ) : super(const AllWorkState.initial());

  final AllWorkRepo _allWorkRepo;
  Future<void> getAllMonthWork() async {
    emit(const AllWorkState.getAllUserMonthWorkLoading());
    final response = await _allWorkRepo.getTotalWorkingMonthAt();
    response.when(
      success: (thisPayPeriodResponse) async {
        emit(AllWorkState.getAllUserMonthWorkSuccess(thisPayPeriodResponse));
      },
      failure: (apiErrorModel) {
        emit(AllWorkState.getAllUserMonthWorkError(apiErrorModel));
      },
    );
  }
}
