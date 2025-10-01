import 'package:json_annotation/json_annotation.dart';

part 'notification_request.g.dart';

@JsonSerializable()
class NotificationRequest {

  @JsonKey(name: 'fcm_token')
  String? fcmToken;

  NotificationRequest({
    required this.fcmToken,
  });

  factory NotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRequestToJson(this);
}
