import 'package:madarj/Core/networking/api_error_handler.dart';
import 'package:madarj/Core/networking/api_results.dart';
import 'package:madarj/Feature/all_works/apis/all_work_service.dart';
import 'package:madarj/Feature/all_works/data/model/get_month_work_response.dart';

class AllWorkRepo {
  final AllWorkService _allWorkService;
  AllWorkRepo(this._allWorkService);


  Future<ApiResults<List<WorkDayEntry>>> getTotalWorkingMonthAt() async {
    try {
      final response = await _allWorkService.getTotalWorkingMonthAt();
      return ApiResults.success(response);
    } catch (error) {
      return ApiResults.failure(ApiErrorHandler.handle(error));
    }
  }
}
