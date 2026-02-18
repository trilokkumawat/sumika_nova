import 'package:freezed_annotation/freezed_annotation.dart';

part 'locationlist_model.freezed.dart';
part 'locationlist_model.g.dart';

/// API response for "Location list fetched successfully".
@freezed
class LocationListResponse with _$LocationListResponse {
  const factory LocationListResponse({
    required bool success,
    required String message,
    required LocationListData data,
  }) = _LocationListResponse;

  factory LocationListResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationListResponseFromJson(json);
}

/// Wrapper for the locations array in the response.
@freezed
class LocationListData with _$LocationListData {
  const factory LocationListData({
    required List<LocationItem> locations,
  }) = _LocationListData;

  factory LocationListData.fromJson(Map<String, dynamic> json) =>
      _$LocationListDataFromJson(json);
}

/// Single location (room) item from the API.
@freezed
class LocationItem with _$LocationItem {
  const factory LocationItem({
    required int id,
    @JsonKey(name: 'home_id') required int homeId,
    @JsonKey(name: 'location_list_id') required int locationListId,
    required String name,
    @JsonKey(name: 'photo_path') required String photoPath,
    @JsonKey(name: 'is_active') required int isActive,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'show_photo_path') required String showPhotoPath,
    @JsonKey(name: 'location_list') required LocationListRef locationList,
  }) = _LocationItem;

  factory LocationItem.fromJson(Map<String, dynamic> json) =>
      _$LocationItemFromJson(json);
}

/// Nested location_list reference (default icon/metadata).
@freezed
class LocationListRef with _$LocationListRef {
  const factory LocationListRef({
    required int id,
    required String name,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'is_active') required int isActive,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _LocationListRef;

  factory LocationListRef.fromJson(Map<String, dynamic> json) =>
      _$LocationListRefFromJson(json);
}
