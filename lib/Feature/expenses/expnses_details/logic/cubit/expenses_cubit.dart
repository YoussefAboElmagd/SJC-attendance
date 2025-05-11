import 'package:bloc/bloc.dart';
import 'package:madarj/Feature/expenses/expnses_details/data/repo/expenses_repo.dart';
import 'package:madarj/Feature/expenses/expnses_details/logic/cubit/expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit(this._expensesRepo) : super(const ExpensesState.initial());

  final ExpensesRepo _expensesRepo;

    Future<void> getExpenseCategories() async {
    emit(const ExpensesState.getExpensesLoading());
    
    final result = await _expensesRepo.getExpenseCategories();
    
    result.when(
      success: (data) {
        emit(ExpensesState.getExpensesSuccess(data));
      },
      failure: (error) {
        emit(ExpensesState.getExpensesError(error));
      },
    );
  }
}
