// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationListResponseImpl _$$LocationListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$LocationListResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: LocationListData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$LocationListResponseImplToJson(
  _$LocationListResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_$LocationListDataImpl _$$LocationListDataImplFromJson(
  Map<String, dynamic> json,
) => _$LocationListDataImpl(
  locations: (json['locations'] as List<dynamic>)
      .map((e) => LocationItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$LocationListDataImplToJson(
  _$LocationListDataImpl instance,
) => <String, dynamic>{'locations': instance.locations};

_$LocationItemImpl _$$LocationItemImplFromJson(Map<String, dynamic> json) =>
    _$LocationItemImpl(
      id: (json['id'] as num).toInt(),
      homeId: (json['home_id'] as num).toInt(),
      locationListId: (json['location_list_id'] as num).toInt(),
      name: json['name'] as String,
      photoPath: json['photo_path'] as String,
      isActive: (json['is_active'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      showPhotoPath: json['show_photo_path'] as String,
      locationList: LocationListRef.fromJson(
        json['location_list'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$LocationItemImplToJson(_$LocationItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'home_id': instance.homeId,
      'location_list_id': instance.locationListId,
      'name': instance.name,
      'photo_path': instance.photoPath,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'show_photo_path': instance.showPhotoPath,
      'location_list': instance.locationList,
    };

_$LocationListRefImpl _$$LocationListRefImplFromJson(
  Map<String, dynamic> json,
) => _$LocationListRefImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  imageUrl: json['image_url'] as String,
  isActive: (json['is_active'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$$LocationListRefImplToJson(
  _$LocationListRefImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image_url': instance.imageUrl,
  'is_active': instance.isActive,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
