// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_meteo_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OpenMeteoWeatherResponseImpl _$$OpenMeteoWeatherResponseImplFromJson(
  Map<String, dynamic> json,
) => _$OpenMeteoWeatherResponseImpl(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  generationtimeMs: (json['generationtime_ms'] as num?)?.toDouble(),
  utcOffsetSeconds: (json['utc_offset_seconds'] as num?)?.toInt(),
  timezone: json['timezone'] as String?,
  timezoneAbbreviation: json['timezone_abbreviation'] as String?,
  elevation: (json['elevation'] as num?)?.toDouble(),
  currentWeatherUnits: json['current_weather_units'] == null
      ? null
      : CurrentWeatherUnits.fromJson(
          json['current_weather_units'] as Map<String, dynamic>,
        ),
  currentWeather: CurrentWeather.fromJson(
    json['current_weather'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$OpenMeteoWeatherResponseImplToJson(
  _$OpenMeteoWeatherResponseImpl instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'generationtime_ms': instance.generationtimeMs,
  'utc_offset_seconds': instance.utcOffsetSeconds,
  'timezone': instance.timezone,
  'timezone_abbreviation': instance.timezoneAbbreviation,
  'elevation': instance.elevation,
  'current_weather_units': instance.currentWeatherUnits,
  'current_weather': instance.currentWeather,
};

_$CurrentWeatherUnitsImpl _$$CurrentWeatherUnitsImplFromJson(
  Map<String, dynamic> json,
) => _$CurrentWeatherUnitsImpl(
  time: json['time'] as String?,
  interval: json['interval'] as String?,
  temperature: json['temperature'] as String?,
  windspeed: json['windspeed'] as String?,
  winddirection: json['winddirection'] as String?,
  isDay: json['is_day'] as String?,
  weathercode: json['weathercode'] as String?,
);

Map<String, dynamic> _$$CurrentWeatherUnitsImplToJson(
  _$CurrentWeatherUnitsImpl instance,
) => <String, dynamic>{
  'time': instance.time,
  'interval': instance.interval,
  'temperature': instance.temperature,
  'windspeed': instance.windspeed,
  'winddirection': instance.winddirection,
  'is_day': instance.isDay,
  'weathercode': instance.weathercode,
};

_$CurrentWeatherImpl _$$CurrentWeatherImplFromJson(Map<String, dynamic> json) =>
    _$CurrentWeatherImpl(
      time: json['time'] as String,
      interval: (json['interval'] as num).toInt(),
      temperature: (json['temperature'] as num).toDouble(),
      windspeed: (json['windspeed'] as num).toDouble(),
      winddirection: (json['winddirection'] as num).toInt(),
      isDay: (json['is_day'] as num).toInt(),
      weathercode: (json['weathercode'] as num).toInt(),
    );

Map<String, dynamic> _$$CurrentWeatherImplToJson(
  _$CurrentWeatherImpl instance,
) => <String, dynamic>{
  'time': instance.time,
  'interval': instance.interval,
  'temperature': instance.temperature,
  'windspeed': instance.windspeed,
  'winddirection': instance.winddirection,
  'is_day': instance.isDay,
  'weathercode': instance.weathercode,
};
