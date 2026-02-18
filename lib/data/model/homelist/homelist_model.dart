import 'package:freezed_annotation/freezed_annotation.dart';

part 'homelist_model.freezed.dart';
part 'homelist_model.g.dart';

/// API response for "User Home List" (user-home-list/{userId}).
@freezed
class HomeListResponse with _$HomeListResponse {
  const factory HomeListResponse({
    required bool success,
    required String message,
    required HomeListData data,
  }) = _HomeListResponse;

  factory HomeListResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeListResponseFromJson(json);
}

/// Wrapper for the homes array in the response.
@freezed
class HomeListData with _$HomeListData {
  const factory HomeListData({
    required List<HomeItem> homes,
  }) = _HomeListData;

  factory HomeListData.fromJson(Map<String, dynamic> json) =>
      _$HomeListDataFromJson(json);
}

/// Single home item from the API.
@freezed
class HomeItem with _$HomeItem {
  const factory HomeItem({
    required int id,
    @JsonKey(name: 'admin_user_id') required int adminUserId,
    required String name,
    required String address,
    @JsonKey(name: 'is_active') required int isActive,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _HomeItem;

  factory HomeItem.fromJson(Map<String, dynamic> json) =>
      _$HomeItemFromJson(json);
}
