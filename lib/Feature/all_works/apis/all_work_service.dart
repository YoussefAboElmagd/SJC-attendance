import 'package:madarj/Core/networking/api_constants.dart';
import 'package:madarj/Feature/all_works/apis/all_works_constants.dart';
import 'package:madarj/Feature/all_works/data/model/get_month_work_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'all_work_service.g.dart';

@RestApi(baseUrl: ApiConstants.prodBaseDomain)
abstract class AllWorkService {
  factory AllWorkService(Dio dio, {String baseUrl}) = _AllWorkService;

  @GET(AllWorksConstants.monthAt)
  Future<List<WorkDayEntry>> getTotalWorkingMonthAt();
}
