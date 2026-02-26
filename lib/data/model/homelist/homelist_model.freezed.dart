// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homelist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HomeListResponse _$HomeListResponseFromJson(Map<String, dynamic> json) {
  return _HomeListResponse.fromJson(json);
}

/// @nodoc
mixin _$HomeListResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  HomeListData get data => throw _privateConstructorUsedError;

  /// Serializes this HomeListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeListResponseCopyWith<HomeListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeListResponseCopyWith<$Res> {
  factory $HomeListResponseCopyWith(
    HomeListResponse value,
    $Res Function(HomeListResponse) then,
  ) = _$HomeListResponseCopyWithImpl<$Res, HomeListResponse>;
  @useResult
  $Res call({bool success, String message, HomeListData data});

  $HomeListDataCopyWith<$Res> get data;
}

/// @nodoc
class _$HomeListResponseCopyWithImpl<$Res, $Val extends HomeListResponse>
    implements $HomeListResponseCopyWith<$Res> {
  _$HomeListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeListResponse
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
                      as HomeListData,
          )
          as $Val,
    );
  }

  /// Create a copy of HomeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeListDataCopyWith<$Res> get data {
    return $HomeListDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeListResponseImplCopyWith<$Res>
    implements $HomeListResponseCopyWith<$Res> {
  factory _$$HomeListResponseImplCopyWith(
    _$HomeListResponseImpl value,
    $Res Function(_$HomeListResponseImpl) then,
  ) = __$$HomeListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, HomeListData data});

  @override
  $HomeListDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$HomeListResponseImplCopyWithImpl<$Res>
    extends _$HomeListResponseCopyWithImpl<$Res, _$HomeListResponseImpl>
    implements _$$HomeListResponseImplCopyWith<$Res> {
  __$$HomeListResponseImplCopyWithImpl(
    _$HomeListResponseImpl _value,
    $Res Function(_$HomeListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$HomeListResponseImpl(
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
                  as HomeListData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeListResponseImpl implements _HomeListResponse {
  const _$HomeListResponseImpl({
    required this.success,
    required this.message,
    required this.data,
  });

  factory _$HomeListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeListResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final HomeListData data;

  @override
  String toString() {
    return 'HomeListResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeListResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, data);

  /// Create a copy of HomeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeListResponseImplCopyWith<_$HomeListResponseImpl> get copyWith =>
      __$$HomeListResponseImplCopyWithImpl<_$HomeListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeListResponseImplToJson(this);
  }
}

abstract class _HomeListResponse implements HomeListResponse {
  const factory _HomeListResponse({
    required final bool success,
    required final String message,
    required final HomeListData data,
  }) = _$HomeListResponseImpl;

  factory _HomeListResponse.fromJson(Map<String, dynamic> json) =
      _$HomeListResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  HomeListData get data;

  /// Create a copy of HomeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeListResponseImplCopyWith<_$HomeListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeListData _$HomeListDataFromJson(Map<String, dynamic> json) {
  return _HomeListData.fromJson(json);
}

/// @nodoc
mixin _$HomeListData {
  List<HomeItem> get homes => throw _privateConstructorUsedError;

  /// Serializes this HomeListData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeListDataCopyWith<HomeListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeListDataCopyWith<$Res> {
  factory $HomeListDataCopyWith(
    HomeListData value,
    $Res Function(HomeListData) then,
  ) = _$HomeListDataCopyWithImpl<$Res, HomeListData>;
  @useResult
  $Res call({List<HomeItem> homes});
}

/// @nodoc
class _$HomeListDataCopyWithImpl<$Res, $Val extends HomeListData>
    implements $HomeListDataCopyWith<$Res> {
  _$HomeListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? homes = null}) {
    return _then(
      _value.copyWith(
            homes: null == homes
                ? _value.homes
                : homes // ignore: cast_nullable_to_non_nullable
                      as List<HomeItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeListDataImplCopyWith<$Res>
    implements $HomeListDataCopyWith<$Res> {
  factory _$$HomeListDataImplCopyWith(
    _$HomeListDataImpl value,
    $Res Function(_$HomeListDataImpl) then,
  ) = __$$HomeListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<HomeItem> homes});
}

/// @nodoc
class __$$HomeListDataImplCopyWithImpl<$Res>
    extends _$HomeListDataCopyWithImpl<$Res, _$HomeListDataImpl>
    implements _$$HomeListDataImplCopyWith<$Res> {
  __$$HomeListDataImplCopyWithImpl(
    _$HomeListDataImpl _value,
    $Res Function(_$HomeListDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? homes = null}) {
    return _then(
      _$HomeListDataImpl(
        homes: null == homes
            ? _value._homes
            : homes // ignore: cast_nullable_to_non_nullable
                  as List<HomeItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeListDataImpl implements _HomeListData {
  const _$HomeListDataImpl({required final List<HomeItem> homes})
    : _homes = homes;

  factory _$HomeListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeListDataImplFromJson(json);

  final List<HomeItem> _homes;
  @override
  List<HomeItem> get homes {
    if (_homes is EqualUnmodifiableListView) return _homes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_homes);
  }

  @override
  String toString() {
    return 'HomeListData(homes: $homes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeListDataImpl &&
            const DeepCollectionEquality().equals(other._homes, _homes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_homes));

  /// Create a copy of HomeListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeListDataImplCopyWith<_$HomeListDataImpl> get copyWith =>
      __$$HomeListDataImplCopyWithImpl<_$HomeListDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeListDataImplToJson(this);
  }
}

abstract class _HomeListData implements HomeListData {
  const factory _HomeListData({required final List<HomeItem> homes}) =
      _$HomeListDataImpl;

  factory _HomeListData.fromJson(Map<String, dynamic> json) =
      _$HomeListDataImpl.fromJson;

  @override
  List<HomeItem> get homes;

  /// Create a copy of HomeListData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeListDataImplCopyWith<_$HomeListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeItem _$HomeItemFromJson(Map<String, dynamic> json) {
  return _HomeItem.fromJson(json);
}

/// @nodoc
mixin _$HomeItem {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_user_id')
  int get adminUserId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  int get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this HomeItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeItemCopyWith<HomeItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeItemCopyWith<$Res> {
  factory $HomeItemCopyWith(HomeItem value, $Res Function(HomeItem) then) =
      _$HomeItemCopyWithImpl<$Res, HomeItem>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'admin_user_id') int adminUserId,
    String name,
    String address,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String updatedAt,
  });
}

/// @nodoc
class _$HomeItemCopyWithImpl<$Res, $Val extends HomeItem>
    implements $HomeItemCopyWith<$Res> {
  _$HomeItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? adminUserId = null,
    Object? name = null,
    Object? address = null,
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
            adminUserId: null == adminUserId
                ? _value.adminUserId
                : adminUserId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
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
abstract class _$$HomeItemImplCopyWith<$Res>
    implements $HomeItemCopyWith<$Res> {
  factory _$$HomeItemImplCopyWith(
    _$HomeItemImpl value,
    $Res Function(_$HomeItemImpl) then,
  ) = __$$HomeItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'admin_user_id') int adminUserId,
    String name,
    String address,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String updatedAt,
  });
}

/// @nodoc
class __$$HomeItemImplCopyWithImpl<$Res>
    extends _$HomeItemCopyWithImpl<$Res, _$HomeItemImpl>
    implements _$$HomeItemImplCopyWith<$Res> {
  __$$HomeItemImplCopyWithImpl(
    _$HomeItemImpl _value,
    $Res Function(_$HomeItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? adminUserId = null,
    Object? name = null,
    Object? address = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$HomeItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        adminUserId: null == adminUserId
            ? _value.adminUserId
            : adminUserId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
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
class _$HomeItemImpl implements _HomeItem {
  const _$HomeItemImpl({
    required this.id,
    @JsonKey(name: 'admin_user_id') required this.adminUserId,
    required this.name,
    required this.address,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$HomeItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeItemImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'admin_user_id')
  final int adminUserId;
  @override
  final String name;
  @override
  final String address;
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
    return 'HomeItem(id: $id, adminUserId: $adminUserId, name: $name, address: $address, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.adminUserId, adminUserId) ||
                other.adminUserId == adminUserId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
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
    adminUserId,
    name,
    address,
    isActive,
    createdAt,
    updatedAt,
  );

  /// Create a copy of HomeItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeItemImplCopyWith<_$HomeItemImpl> get copyWith =>
      __$$HomeItemImplCopyWithImpl<_$HomeItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeItemImplToJson(this);
  }
}

abstract class _HomeItem implements HomeItem {
  const factory _HomeItem({
    required final int id,
    @JsonKey(name: 'admin_user_id') required final int adminUserId,
    required final String name,
    required final String address,
    @JsonKey(name: 'is_active') required final int isActive,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'updated_at') required final String updatedAt,
  }) = _$HomeItemImpl;

  factory _HomeItem.fromJson(Map<String, dynamic> json) =
      _$HomeItemImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'admin_user_id')
  int get adminUserId;
  @override
  String get name;
  @override
  String get address;
  @override
  @JsonKey(name: 'is_active')
  int get isActive;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;

  /// Create a copy of HomeItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeItemImplCopyWith<_$HomeItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
