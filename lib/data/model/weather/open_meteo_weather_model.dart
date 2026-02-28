import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_meteo_weather_model.freezed.dart';
part 'open_meteo_weather_model.g.dart';

// ignore_for_file: invalid_annotation_target
/// Open-Meteo forecast API response (current_weather).
/// See https://open-meteo.com/en/docs
@freezed
class OpenMeteoWeatherResponse with _$OpenMeteoWeatherResponse {
  const factory OpenMeteoWeatherResponse({
    required double latitude,
    required double longitude,
    @JsonKey(name: 'generationtime_ms') double? generationtimeMs,
    @JsonKey(name: 'utc_offset_seconds') int? utcOffsetSeconds,
    String? timezone,
    @JsonKey(name: 'timezone_abbreviation') String? timezoneAbbreviation,
    double? elevation,
    @JsonKey(name: 'current_weather_units')
    CurrentWeatherUnits? currentWeatherUnits,
    @JsonKey(name: 'current_weather') required CurrentWeather currentWeather,
  }) = _OpenMeteoWeatherResponse;

  factory OpenMeteoWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$OpenMeteoWeatherResponseFromJson(json);
}

@freezed
class CurrentWeatherUnits with _$CurrentWeatherUnits {
  const factory CurrentWeatherUnits({
    String? time,
    String? interval,
    String? temperature,
    String? windspeed,
    String? winddirection,
    @JsonKey(name: 'is_day') String? isDay,
    String? weathercode,
  }) = _CurrentWeatherUnits;

  factory CurrentWeatherUnits.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherUnitsFromJson(json);
}

@freezed
class CurrentWeather with _$CurrentWeather {
  const factory CurrentWeather({
    required String time,
    required int interval,
    required double temperature,
    required double windspeed,
    required int winddirection,
    @JsonKey(name: 'is_day') required int isDay,
    required int weathercode,
  }) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
}
