import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

/// API response for "Device List".
@freezed
class DeviceListResponse with _$DeviceListResponse {
  const factory DeviceListResponse({
    required bool success,
    required String message,
    required List<DeviceItem> data,
  }) = _DeviceListResponse;

  factory DeviceListResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceListResponseFromJson(json);
}

/// Single device item from the API.
@freezed
class DeviceItem with _$DeviceItem {
  const factory DeviceItem({
    required int id,
    required String name,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'is_active') required int isActive,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _DeviceItem;

  factory DeviceItem.fromJson(Map<String, dynamic> json) =>
      _$DeviceItemFromJson(json);
}

/// Extension to convert [DeviceItem] to the map shape expected by [CustomDeviceCard].
extension DeviceItemCardMap on DeviceItem {
  Map<String, String> toDeviceCardMap({String fallbackIcon = 'assets/icons/light.png'}) {
    return {
      'id': id.toString(),
      'label': name,
      'icon': imageUrl.isNotEmpty ? imageUrl : fallbackIcon,
    };
  }
}
