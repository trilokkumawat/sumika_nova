/// Simple room/location model for the location_list API (no code generation).
class RoomModel {
  const RoomModel({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String? imageUrl;

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: (json['id'] ?? json['location_id'] ?? '').toString(),
      name: (json['name'] ?? json['location_name'] ?? '').toString(),
      imageUrl: (json['image_url'] ?? json['image'] ?? '').toString().isEmpty
          ? null
          : (json['image_url'] ?? json['image']).toString(),
    );
  }

  /// Converts to the map shape expected by [CustomDeviceCard] (id, label, icon).
  /// Uses [imageUrl] when present, otherwise [fallbackIcon] (asset path).
  Map<String, String> toDeviceCardMap({String fallbackIcon = 'assets/icons/light.png'}) {
    return {
      'id': id,
      'label': name,
      'icon': (imageUrl != null && imageUrl!.isNotEmpty) ? imageUrl! : fallbackIcon,
    };
  }
}
