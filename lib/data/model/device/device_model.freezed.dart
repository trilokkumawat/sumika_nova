// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DeviceListResponse _$DeviceListResponseFromJson(Map<String, dynamic> json) {
  return _DeviceListResponse.fromJson(json);
}

/// @nodoc
mixin _$DeviceListResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<DeviceItem> get data => throw _privateConstructorUsedError;

  /// Serializes this DeviceListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceListResponseCopyWith<DeviceListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceListResponseCopyWith<$Res> {
  factory $DeviceListResponseCopyWith(
    DeviceListResponse value,
    $Res Function(DeviceListResponse) then,
  ) = _$DeviceListResponseCopyWithImpl<$Res, DeviceListResponse>;
  @useResult
  $Res call({bool success, String message, List<DeviceItem> data});
}

/// @nodoc
class _$DeviceListResponseCopyWithImpl<$Res, $Val extends DeviceListResponse>
    implements $DeviceListResponseCopyWith<$Res> {
  _$DeviceListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<DeviceItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceListResponseImplCopyWith<$Res>
    implements $DeviceListResponseCopyWith<$Res> {
  factory _$$DeviceListResponseImplCopyWith(
    _$DeviceListResponseImpl value,
    $Res Function(_$DeviceListResponseImpl) then,
  ) = __$$DeviceListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, List<DeviceItem> data});
}

/// @nodoc
class __$$DeviceListResponseImplCopyWithImpl<$Res>
    extends _$DeviceListResponseCopyWithImpl<$Res, _$DeviceListResponseImpl>
    implements _$$DeviceListResponseImplCopyWith<$Res> {
  __$$DeviceListResponseImplCopyWithImpl(
    _$DeviceListResponseImpl _value,
    $Res Function(_$DeviceListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$DeviceListResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<DeviceItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceListResponseImpl implements _DeviceListResponse {
  const _$DeviceListResponseImpl({
    required this.success,
    required this.message,
    required final List<DeviceItem> data,
  }) : _data = data;

  factory _$DeviceListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceListResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  final List<DeviceItem> _data;
  @override
  List<DeviceItem> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'DeviceListResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceListResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of DeviceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceListResponseImplCopyWith<_$DeviceListResponseImpl> get copyWith =>
      __$$DeviceListResponseImplCopyWithImpl<_$DeviceListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceListResponseImplToJson(this);
  }
}

abstract class _DeviceListResponse implements DeviceListResponse {
  const factory _DeviceListResponse({
    required final bool success,
    required final String message,
    required final List<DeviceItem> data,
  }) = _$DeviceListResponseImpl;

  factory _DeviceListResponse.fromJson(Map<String, dynamic> json) =
      _$DeviceListResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  List<DeviceItem> get data;

  /// Create a copy of DeviceListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceListResponseImplCopyWith<_$DeviceListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeviceItem _$DeviceItemFromJson(Map<String, dynamic> json) {
  return _DeviceItem.fromJson(json);
}

/// @nodoc
mixin _$DeviceItem {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  int get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DeviceItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceItemCopyWith<DeviceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceItemCopyWith<$Res> {
  factory $DeviceItemCopyWith(
    DeviceItem value,
    $Res Function(DeviceItem) then,
  ) = _$DeviceItemCopyWithImpl<$Res, DeviceItem>;
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String updatedAt,
  });
}

/// @nodoc
class _$DeviceItemCopyWithImpl<$Res, $Val extends DeviceItem>
    implements $DeviceItemCopyWith<$Res> {
  _$DeviceItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeviceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeviceItemImplCopyWith<$Res>
    implements $DeviceItemCopyWith<$Res> {
  factory _$$DeviceItemImplCopyWith(
    _$DeviceItemImpl value,
    $Res Function(_$DeviceItemImpl) then,
  ) = __$$DeviceItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    @JsonKey(name: 'image_url') String imageUrl,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String updatedAt,
  });
}

/// @nodoc
class __$$DeviceItemImplCopyWithImpl<$Res>
    extends _$DeviceItemCopyWithImpl<$Res, _$DeviceItemImpl>
    implements _$$DeviceItemImplCopyWith<$Res> {
  __$$DeviceItemImplCopyWithImpl(
    _$DeviceItemImpl _value,
    $Res Function(_$DeviceItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeviceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$DeviceItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceItemImpl implements _DeviceItem {
  const _$DeviceItemImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'image_url') required this.imageUrl,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$DeviceItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceItemImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey(name: 'is_active')
  final int isActive;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @override
  String toString() {
    return 'DeviceItem(id: $id, name: $name, imageUrl: $imageUrl, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    imageUrl,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of DeviceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceItemImplCopyWith<_$DeviceItemImpl> get copyWith =>
      __$$DeviceItemImplCopyWithImpl<_$DeviceItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceItemImplToJson(this);
  }
}

abstract class _DeviceItem implements DeviceItem {
  const factory _DeviceItem({
    required final int id,
    required final String name,
    @JsonKey(name: 'image_url') required final String imageUrl,
    @JsonKey(name: 'is_active') required final int isActive,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'updated_at') required final String updatedAt,
  }) = _$DeviceItemImpl;

  factory _DeviceItem.fromJson(Map<String, dynamic> json) =
      _$DeviceItemImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @JsonKey(name: 'is_active')
  int get isActive;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;

  /// Create a copy of DeviceItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceItemImplCopyWith<_$DeviceItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
