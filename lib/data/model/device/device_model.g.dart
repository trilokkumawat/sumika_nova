// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceListResponseImpl _$$DeviceListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DeviceListResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => DeviceItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$DeviceListResponseImplToJson(
  _$DeviceListResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_$DeviceItemImpl _$$DeviceItemImplFromJson(Map<String, dynamic> json) =>
    _$DeviceItemImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      isActive: (json['is_active'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$DeviceItemImplToJson(_$DeviceItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
