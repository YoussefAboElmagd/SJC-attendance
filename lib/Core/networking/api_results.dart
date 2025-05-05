// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:labaiik_mo3tmer/Core/networking/api_error_handler.dart';
// part 'api_results.freezed.dart';

// @Freezed()
// abstract class ApiResults <T>with _$ApiResults<T>{

//   const factory ApiResults.success(T data)=Success<T>;
  
//   const factory ApiResults.failure(ErrorHandler errorHandler)=Failure<T>;
// }


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
part 'api_results.freezed.dart';

@Freezed()
abstract class ApiResults <T>with _$ApiResults<T>{

  const factory ApiResults.success(T data)=Success<T>;
  
  const factory ApiResults.failure(ApiErrorModel apiErrorModel)=Failure<T>;
}

