/// Simple device model for the device_list API (no code generation).
class DeviceModel {
  const DeviceModel({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String? imageUrl;

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: (json['id'] ?? json['device_id'] ?? '').toString(),
      name: (json['name'] ?? json['device_name'] ?? json['label'] ?? '').toString(),
      imageUrl: (json['image_url'] ?? json['image'] ?? json['icon'] ?? '').toString().isEmpty
          ? null
          : (json['image_url'] ?? json['image'] ?? json['icon']).toString(),
    );
  }

  /// Converts to the map shape expected by [CustomDeviceCard] (id, label, icon).
  Map<String, String> toDeviceCardMap({String fallbackIcon = 'assets/icons/light.png'}) {
    return {
      'id': id,
      'label': name,
      'icon': (imageUrl != null && imageUrl!.isNotEmpty) ? imageUrl! : fallbackIcon,
    };
  }
}
