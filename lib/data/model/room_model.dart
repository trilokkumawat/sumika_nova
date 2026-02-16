import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

/// API response for "Location List".
@freezed
class LocationListResponse with _$LocationListResponse {
  const factory LocationListResponse({
    required bool success,
    required String message,
    required List<LocationItem> data,
  }) = _LocationListResponse;

  factory LocationListResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationListResponseFromJson(json);
}

/// Single location/room item from the API.
@freezed
class LocationItem with _$LocationItem {
  const factory LocationItem({
    required int id,
    required String name,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'is_active') required int isActive,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _LocationItem;

  factory LocationItem.fromJson(Map<String, dynamic> json) =>
      _$LocationItemFromJson(json);
}
