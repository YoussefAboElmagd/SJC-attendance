// lib/feature/expenses/send_expenses/data/model/create_expense_request.dart
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';

part 'create_expense_request.g.dart';

@JsonSerializable()
class CreateExpenseRequest {
  @JsonKey(name: 'category_id', ignore: true)
  final String? categoryId;

  @JsonKey(ignore: true, name: 'request_type_id')
  final String? requestTypeId;

  @JsonKey(ignore: true)
  final String? description;

  @JsonKey(name: 'total_amount', ignore: true)
  final String? totalAmount;

  // final String? date;

  @JsonKey(ignore: true)
  final List<File>? files;

  CreateExpenseRequest({
    this.categoryId,
    this.requestTypeId,
    this.description,
    this.totalAmount,
    // this.date,
    this.files,
  });

  Map<String, dynamic> toJson() => _$CreateExpenseRequestToJson(this);

  // For multipart/form-data requests
  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      'category_id': categoryId,
      'request_type_id': requestTypeId,
      'description': description,
      'total_amount': totalAmount,
      // 'date': date,
    });

    // Add files if they exist
    if (files != null && files!.isNotEmpty) {
      for (var file in files!) {
        formData.files.add(MapEntry(
          'file', // Field name should match your API requirements
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ));
      }
    }

    return formData;
  }
}
