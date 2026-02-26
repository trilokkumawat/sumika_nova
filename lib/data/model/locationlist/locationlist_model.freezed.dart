// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locationlist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocationListResponse _$LocationListResponseFromJson(Map<String, dynamic> json) {
  return _LocationListResponse.fromJson(json);
}

/// @nodoc
mixin _$LocationListResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  LocationListData get data => throw _privateConstructorUsedError;

  /// Serializes this LocationListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationListResponseCopyWith<LocationListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationListResponseCopyWith<$Res> {
  factory $LocationListResponseCopyWith(
    LocationListResponse value,
    $Res Function(LocationListResponse) then,
  ) = _$LocationListResponseCopyWithImpl<$Res, LocationListResponse>;
  @useResult
  $Res call({bool success, String message, LocationListData data});

  $LocationListDataCopyWith<$Res> get data;
}

/// @nodoc
class _$LocationListResponseCopyWithImpl<
  $Res,
  $Val extends LocationListResponse
>
    implements $LocationListResponseCopyWith<$Res> {
  _$LocationListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationListResponse
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
                      as LocationListData,
          )
          as $Val,
    );
  }

  /// Create a copy of LocationListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationListDataCopyWith<$Res> get data {
    return $LocationListDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocationListResponseImplCopyWith<$Res>
    implements $LocationListResponseCopyWith<$Res> {
  factory _$$LocationListResponseImplCopyWith(
    _$LocationListResponseImpl value,
    $Res Function(_$LocationListResponseImpl) then,
  ) = __$$LocationListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, LocationListData data});

  @override
  $LocationListDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$LocationListResponseImplCopyWithImpl<$Res>
    extends _$LocationListResponseCopyWithImpl<$Res, _$LocationListResponseImpl>
    implements _$$LocationListResponseImplCopyWith<$Res> {
  __$$LocationListResponseImplCopyWithImpl(
    _$LocationListResponseImpl _value,
    $Res Function(_$LocationListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$LocationListResponseImpl(
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
                  as LocationListData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationListResponseImpl implements _LocationListResponse {
  const _$LocationListResponseImpl({
    required this.success,
    required this.message,
    required this.data,
  });

  factory _$LocationListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationListResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final LocationListData data;

  @override
  String toString() {
    return 'LocationListResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationListResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, data);

  /// Create a copy of LocationListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationListResponseImplCopyWith<_$LocationListResponseImpl>
  get copyWith =>
      __$$LocationListResponseImplCopyWithImpl<_$LocationListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationListResponseImplToJson(this);
  }
}

abstract class _LocationListResponse implements LocationListResponse {
  const factory _LocationListResponse({
    required final bool success,
    required final String message,
    required final LocationListData data,
  }) = _$LocationListResponseImpl;

  factory _LocationListResponse.fromJson(Map<String, dynamic> json) =
      _$LocationListResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  LocationListData get data;

  /// Create a copy of LocationListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationListResponseImplCopyWith<_$LocationListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

LocationListData _$LocationListDataFromJson(Map<String, dynamic> json) {
  return _LocationListData.fromJson(json);
}

/// @nodoc
mixin _$LocationListData {
  List<LocationItem> get locations => throw _privateConstructorUsedError;

  /// Serializes this LocationListData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationListDataCopyWith<LocationListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationListDataCopyWith<$Res> {
  factory $LocationListDataCopyWith(
    LocationListData value,
    $Res Function(LocationListData) then,
  ) = _$LocationListDataCopyWithImpl<$Res, LocationListData>;
  @useResult
  $Res call({List<LocationItem> locations});
}

/// @nodoc
class _$LocationListDataCopyWithImpl<$Res, $Val extends LocationListData>
    implements $LocationListDataCopyWith<$Res> {
  _$LocationListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? locations = null}) {
    return _then(
      _value.copyWith(
            locations: null == locations
                ? _value.locations
                : locations // ignore: cast_nullable_to_non_nullable
                      as List<LocationItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationListDataImplCopyWith<$Res>
    implements $LocationListDataCopyWith<$Res> {
  factory _$$LocationListDataImplCopyWith(
    _$LocationListDataImpl value,
    $Res Function(_$LocationListDataImpl) then,
  ) = __$$LocationListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<LocationItem> locations});
}

/// @nodoc
class __$$LocationListDataImplCopyWithImpl<$Res>
    extends _$LocationListDataCopyWithImpl<$Res, _$LocationListDataImpl>
    implements _$$LocationListDataImplCopyWith<$Res> {
  __$$LocationListDataImplCopyWithImpl(
    _$LocationListDataImpl _value,
    $Res Function(_$LocationListDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? locations = null}) {
    return _then(
      _$LocationListDataImpl(
        locations: null == locations
            ? _value._locations
            : locations // ignore: cast_nullable_to_non_nullable
                  as List<LocationItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationListDataImpl implements _LocationListData {
  const _$LocationListDataImpl({required final List<LocationItem> locations})
    : _locations = locations;

  factory _$LocationListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationListDataImplFromJson(json);

  final List<LocationItem> _locations;
  @override
  List<LocationItem> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  String toString() {
    return 'LocationListData(locations: $locations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationListDataImpl &&
            const DeepCollectionEquality().equals(
              other._locations,
              _locations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_locations));

  /// Create a copy of LocationListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationListDataImplCopyWith<_$LocationListDataImpl> get copyWith =>
      __$$LocationListDataImplCopyWithImpl<_$LocationListDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationListDataImplToJson(this);
  }
}

abstract class _LocationListData implements LocationListData {
  const factory _LocationListData({
    required final List<LocationItem> locations,
  }) = _$LocationListDataImpl;

  factory _LocationListData.fromJson(Map<String, dynamic> json) =
      _$LocationListDataImpl.fromJson;

  @override
  List<LocationItem> get locations;

  /// Create a copy of LocationListData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationListDataImplCopyWith<_$LocationListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationItem _$LocationItemFromJson(Map<String, dynamic> json) {
  return _LocationItem.fromJson(json);
}

/// @nodoc
mixin _$LocationItem {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'home_id')
  int get homeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_list_id')
  int get locationListId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_path', fromJson: _stringFromJson)
  String get photoPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  int get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_photo_path', fromJson: _stringFromJson)
  String get showPhotoPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_list', fromJson: _locationListRefFromJson)
  LocationListRef? get locationList => throw _privateConstructorUsedError;

  /// Serializes this LocationItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationItemCopyWith<LocationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationItemCopyWith<$Res> {
  factory $LocationItemCopyWith(
    LocationItem value,
    $Res Function(LocationItem) then,
  ) = _$LocationItemCopyWithImpl<$Res, LocationItem>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'home_id') int homeId,
    @JsonKey(name: 'location_list_id') int locationListId,
    String name,
    @JsonKey(name: 'photo_path', fromJson: _stringFromJson) String photoPath,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String updatedAt,
    @JsonKey(name: 'show_photo_path', fromJson: _stringFromJson)
    String showPhotoPath,
    @JsonKey(name: 'location_list', fromJson: _locationListRefFromJson)
    LocationListRef? locationList,
  });

  $LocationListRefCopyWith<$Res>? get locationList;
}

/// @nodoc
class _$LocationItemCopyWithImpl<$Res, $Val extends LocationItem>
    implements $LocationItemCopyWith<$Res> {
  _$LocationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? homeId = null,
    Object? locationListId = null,
    Object? name = null,
    Object? photoPath = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? showPhotoPath = null,
    Object? locationList = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            homeId: null == homeId
                ? _value.homeId
                : homeId // ignore: cast_nullable_to_non_nullable
                      as int,
            locationListId: null == locationListId
                ? _value.locationListId
                : locationListId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            photoPath: null == photoPath
                ? _value.photoPath
                : photoPath // ignore: cast_nullable_to_non_nullable
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
            showPhotoPath: null == showPhotoPath
                ? _value.showPhotoPath
                : showPhotoPath // ignore: cast_nullable_to_non_nullable
                      as String,
            locationList: freezed == locationList
                ? _value.locationList
                : locationList // ignore: cast_nullable_to_non_nullable
                      as LocationListRef?,
          )
          as $Val,
    );
  }

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationListRefCopyWith<$Res>? get locationList {
    if (_value.locationList == null) {
      return null;
    }

    return $LocationListRefCopyWith<$Res>(_value.locationList!, (value) {
      return _then(_value.copyWith(locationList: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocationItemImplCopyWith<$Res>
    implements $LocationItemCopyWith<$Res> {
  factory _$$LocationItemImplCopyWith(
    _$LocationItemImpl value,
    $Res Function(_$LocationItemImpl) then,
  ) = __$$LocationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'home_id') int homeId,
    @JsonKey(name: 'location_list_id') int locationListId,
    String name,
    @JsonKey(name: 'photo_path', fromJson: _stringFromJson) String photoPath,
    @JsonKey(name: 'is_active') int isActive,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String updatedAt,
    @JsonKey(name: 'show_photo_path', fromJson: _stringFromJson)
    String showPhotoPath,
    @JsonKey(name: 'location_list', fromJson: _locationListRefFromJson)
    LocationListRef? locationList,
  });

  @override
  $LocationListRefCopyWith<$Res>? get locationList;
}

/// @nodoc
class __$$LocationItemImplCopyWithImpl<$Res>
    extends _$LocationItemCopyWithImpl<$Res, _$LocationItemImpl>
    implements _$$LocationItemImplCopyWith<$Res> {
  __$$LocationItemImplCopyWithImpl(
    _$LocationItemImpl _value,
    $Res Function(_$LocationItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? homeId = null,
    Object? locationListId = null,
    Object? name = null,
    Object? photoPath = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? showPhotoPath = null,
    Object? locationList = freezed,
  }) {
    return _then(
      _$LocationItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        homeId: null == homeId
            ? _value.homeId
            : homeId // ignore: cast_nullable_to_non_nullable
                  as int,
        locationListId: null == locationListId
            ? _value.locationListId
            : locationListId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        photoPath: null == photoPath
            ? _value.photoPath
            : photoPath // ignore: cast_nullable_to_non_nullable
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
        showPhotoPath: null == showPhotoPath
            ? _value.showPhotoPath
            : showPhotoPath // ignore: cast_nullable_to_non_nullable
                  as String,
        locationList: freezed == locationList
            ? _value.locationList
            : locationList // ignore: cast_nullable_to_non_nullable
                  as LocationListRef?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationItemImpl implements _LocationItem {
  const _$LocationItemImpl({
    required this.id,
    @JsonKey(name: 'home_id') required this.homeId,
    @JsonKey(name: 'location_list_id') required this.locationListId,
    required this.name,
    @JsonKey(name: 'photo_path', fromJson: _stringFromJson)
    required this.photoPath,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    @JsonKey(name: 'show_photo_path', fromJson: _stringFromJson)
    required this.showPhotoPath,
    @JsonKey(name: 'location_list', fromJson: _locationListRefFromJson)
    this.locationList,
  });

  factory _$LocationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationItemImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'home_id')
  final int homeId;
  @override
  @JsonKey(name: 'location_list_id')
  final int locationListId;
  @override
  final String name;
  @override
  @JsonKey(name: 'photo_path', fromJson: _stringFromJson)
  final String photoPath;
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
  @JsonKey(name: 'show_photo_path', fromJson: _stringFromJson)
  final String showPhotoPath;
  @override
  @JsonKey(name: 'location_list', fromJson: _locationListRefFromJson)
  final LocationListRef? locationList;

  @override
  String toString() {
    return 'LocationItem(id: $id, homeId: $homeId, locationListId: $locationListId, name: $name, photoPath: $photoPath, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, showPhotoPath: $showPhotoPath, locationList: $locationList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.homeId, homeId) || other.homeId == homeId) &&
            (identical(other.locationListId, locationListId) ||
                other.locationListId == locationListId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.showPhotoPath, showPhotoPath) ||
                other.showPhotoPath == showPhotoPath) &&
            (identical(other.locationList, locationList) ||
                other.locationList == locationList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    homeId,
    locationListId,
    name,
    photoPath,
    isActive,
    createdAt,
    updatedAt,
    showPhotoPath,
    locationList,
  );

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationItemImplCopyWith<_$LocationItemImpl> get copyWith =>
      __$$LocationItemImplCopyWithImpl<_$LocationItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationItemImplToJson(this);
  }
}

abstract class _LocationItem implements LocationItem {
  const factory _LocationItem({
    required final int id,
    @JsonKey(name: 'home_id') required final int homeId,
    @JsonKey(name: 'location_list_id') required final int locationListId,
    required final String name,
    @JsonKey(name: 'photo_path', fromJson: _stringFromJson)
    required final String photoPath,
    @JsonKey(name: 'is_active') required final int isActive,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'updated_at') required final String updatedAt,
    @JsonKey(name: 'show_photo_path', fromJson: _stringFromJson)
    required final String showPhotoPath,
    @JsonKey(name: 'location_list', fromJson: _locationListRefFromJson)
    final LocationListRef? locationList,
  }) = _$LocationItemImpl;

  factory _LocationItem.fromJson(Map<String, dynamic> json) =
      _$LocationItemImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'home_id')
  int get homeId;
  @override
  @JsonKey(name: 'location_list_id')
  int get locationListId;
  @override
  String get name;
  @override
  @JsonKey(name: 'photo_path', fromJson: _stringFromJson)
  String get photoPath;
  @override
  @JsonKey(name: 'is_active')
  int get isActive;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;
  @override
  @JsonKey(name: 'show_photo_path', fromJson: _stringFromJson)
  String get showPhotoPath;
  @override
  @JsonKey(name: 'location_list', fromJson: _locationListRefFromJson)
  LocationListRef? get locationList;

  /// Create a copy of LocationItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationItemImplCopyWith<_$LocationItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationListRef _$LocationListRefFromJson(Map<String, dynamic> json) {
  return _LocationListRef.fromJson(json);
}

/// @nodoc
mixin _$LocationListRef {
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

  /// Serializes this LocationListRef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationListRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationListRefCopyWith<LocationListRef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationListRefCopyWith<$Res> {
  factory $LocationListRefCopyWith(
    LocationListRef value,
    $Res Function(LocationListRef) then,
  ) = _$LocationListRefCopyWithImpl<$Res, LocationListRef>;
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
class _$LocationListRefCopyWithImpl<$Res, $Val extends LocationListRef>
    implements $LocationListRefCopyWith<$Res> {
  _$LocationListRefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationListRef
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
abstract class _$$LocationListRefImplCopyWith<$Res>
    implements $LocationListRefCopyWith<$Res> {
  factory _$$LocationListRefImplCopyWith(
    _$LocationListRefImpl value,
    $Res Function(_$LocationListRefImpl) then,
  ) = __$$LocationListRefImplCopyWithImpl<$Res>;
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
class __$$LocationListRefImplCopyWithImpl<$Res>
    extends _$LocationListRefCopyWithImpl<$Res, _$LocationListRefImpl>
    implements _$$LocationListRefImplCopyWith<$Res> {
  __$$LocationListRefImplCopyWithImpl(
    _$LocationListRefImpl _value,
    $Res Function(_$LocationListRefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationListRef
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
      _$LocationListRefImpl(
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
class _$LocationListRefImpl implements _LocationListRef {
  const _$LocationListRefImpl({
    required this.id,
    required this.name,
    @JsonKey(name: 'image_url') required this.imageUrl,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$LocationListRefImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationListRefImplFromJson(json);

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
    return 'LocationListRef(id: $id, name: $name, imageUrl: $imageUrl, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationListRefImpl &&
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

  /// Create a copy of LocationListRef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationListRefImplCopyWith<_$LocationListRefImpl> get copyWith =>
      __$$LocationListRefImplCopyWithImpl<_$LocationListRefImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationListRefImplToJson(this);
  }
}

abstract class _LocationListRef implements LocationListRef {
  const factory _LocationListRef({
    required final int id,
    required final String name,
    @JsonKey(name: 'image_url') required final String imageUrl,
    @JsonKey(name: 'is_active') required final int isActive,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'updated_at') required final String updatedAt,
  }) = _$LocationListRefImpl;

  factory _LocationListRef.fromJson(Map<String, dynamic> json) =
      _$LocationListRefImpl.fromJson;

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

  /// Create a copy of LocationListRef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationListRefImplCopyWith<_$LocationListRefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
