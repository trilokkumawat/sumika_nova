/// User model for stored auth user data.
class UserModel {
  const UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    Map<String, dynamic>? raw,
  }) : _raw = raw;

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final Map<String, dynamic>? _raw;

  /// Creates [UserModel] from API/storage map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      raw: json,
    );
  }

  /// Converts to map for storage.
  Map<String, dynamic> toJson() {
    return _raw ?? <String, dynamic>{
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
    };
  }

  /// Returns a value from the raw map by key (for extra API fields).
  T? get<T>(String key) {
    final v = _raw?[key];
    return v is T ? v : null;
  }
}
