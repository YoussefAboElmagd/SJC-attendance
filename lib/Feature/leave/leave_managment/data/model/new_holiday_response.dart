import 'package:json_annotation/json_annotation.dart';

part 'new_holiday_response.g.dart';

@JsonSerializable()
class NewHolidayResponse {
  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'data')
  HolidayRequestDataWrapper? data;

  NewHolidayResponse({this.count, this.data});

  factory NewHolidayResponse.fromJson(Map<String, dynamic> json) =>
      _$NewHolidayResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewHolidayResponseToJson(this);
}

@JsonSerializable()
class HolidayRequestDataWrapper {
  @JsonKey(name: 'data')
  List<HolidayRequestData>? data;

  @JsonKey(name: 'meta')
  PaginationMeta? meta;

  HolidayRequestDataWrapper({this.data, this.meta});

  factory HolidayRequestDataWrapper.fromJson(Map<String, dynamic> json) =>
      _$HolidayRequestDataWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayRequestDataWrapperToJson(this);
}

@JsonSerializable()
class PaginationMeta {
  @JsonKey(name: 'pagination')
  Pagination? pagination;

  PaginationMeta({this.pagination});

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: 'current_page')
  int? currentPage;

  @JsonKey(name: 'per_page')
  int? perPage;

  @JsonKey(name: 'total_items')
  int? totalItems;

  @JsonKey(name: 'total_pages')
  int? totalPages;

  @JsonKey(name: 'has_next')
  bool? hasNext;

  @JsonKey(name: 'has_prev')
  bool? hasPrev;

  Pagination({
    this.currentPage,
    this.perPage,
    this.totalItems,
    this.totalPages,
    this.hasNext,
    this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class HolidayRequestData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'employee_name')
  String? employeeName;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'holiday_type')
  String? holidayType;

  @JsonKey(name: 'request_date_from')
  String? requestDateFrom;

  @JsonKey(name: 'request_date_to')
  String? requestDateTo;

  @JsonKey(name: 'number_of_days')
  int? numberOfDays;

  @JsonKey(name: 'state')
  String? state;

  @JsonKey(name: 'state_display')
  String? stateDisplay;

  @JsonKey(name: 'create_date')
  String? createDate;

  HolidayRequestData({
    this.id,
    this.employeeName,
    this.name,
    this.holidayType,
    this.requestDateFrom,
    this.requestDateTo,
    this.numberOfDays,
    this.state,
    this.stateDisplay,
    this.createDate,
  });

  factory HolidayRequestData.fromJson(Map<String, dynamic> json) =>
      _$HolidayRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayRequestDataToJson(this);
}
