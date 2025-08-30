// import 'dart:io';

import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/expenses/send_expenses/apis/send_expenses_constants.dart';
// import 'package:madarj/Feature/expenses/send_expenses/data/model/create_expense_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/request_types_model_response.dart';
import 'package:madarj/Feature/expenses/send_expenses/data/model/send_exp_categories_model_response.dart';
import 'package:madarj/Feature/expenses/show_expenses_details/data/model/get_expense_details.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'send_expenses_service.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class SendExpensesService {
  factory SendExpensesService(Dio dio, {String baseUrl}) = _SendExpensesService;
  @GET(SendExpensesConstants.requestTypes)
  Future<RequestTypesModel> getRequestTypes();

  @GET(SendExpensesConstants.categories)
  Future<SendExpCategResponse> getCategories();
  @GET(SendExpensesConstants.detailsExpenses)
  Future<ExpenseDetailsResponse> getExpenseDetails(
    @Query("expense_id") int expenseId,
  );
  // In your service
  // @POST(SendExpensesConstants.createExpense)
  // @MultiPart()
  // Future<CreateExpenseResponse> createExpense(
  //   // @Body() FormData formData,
  //   @Part() String category_id,
  //   @Part() String request_type_id,
  //   @Part() String description,
  //   @Part() String total_amount,
  //   @Part() List<File> file,
  // );

  // Add this new method for editing expense
  // @POST(SendExpensesConstants.editExpense)
  // @MultiPart()
  // Future<CreateExpenseResponse> editExpense(
  //   @Query('expense_id') int expenseId,
  //   @Part() String category_id,
  //   @Part() String request_type_id,
  //   @Part() String description,
  //   @Part() String total_amount,
  //   @Part() List<File> file,
  // );
}
