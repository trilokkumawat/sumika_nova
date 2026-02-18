// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homelist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeListResponseImpl _$$HomeListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$HomeListResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: HomeListData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$HomeListResponseImplToJson(
  _$HomeListResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_$HomeListDataImpl _$$HomeListDataImplFromJson(Map<String, dynamic> json) =>
    _$HomeListDataImpl(
      homes: (json['homes'] as List<dynamic>)
          .map((e) => HomeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HomeListDataImplToJson(_$HomeListDataImpl instance) =>
    <String, dynamic>{'homes': instance.homes};

_$HomeItemImpl _$$HomeItemImplFromJson(Map<String, dynamic> json) =>
    _$HomeItemImpl(
      id: (json['id'] as num).toInt(),
      adminUserId: (json['admin_user_id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      isActive: (json['is_active'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$HomeItemImplToJson(_$HomeItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'admin_user_id': instance.adminUserId,
      'name': instance.name,
      'address': instance.address,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
