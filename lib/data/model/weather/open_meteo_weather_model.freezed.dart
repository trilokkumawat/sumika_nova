// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_meteo_weather_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OpenMeteoWeatherResponse _$OpenMeteoWeatherResponseFromJson(
  Map<String, dynamic> json,
) {
  return _OpenMeteoWeatherResponse.fromJson(json);
}

/// @nodoc
mixin _$OpenMeteoWeatherResponse {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'generationtime_ms')
  double? get generationtimeMs => throw _privateConstructorUsedError;
  @JsonKey(name: 'utc_offset_seconds')
  int? get utcOffsetSeconds => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  @JsonKey(name: 'timezone_abbreviation')
  String? get timezoneAbbreviation => throw _privateConstructorUsedError;
  double? get elevation => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_weather_units')
  CurrentWeatherUnits? get currentWeatherUnits =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'current_weather')
  CurrentWeather get currentWeather => throw _privateConstructorUsedError;

  /// Serializes this OpenMeteoWeatherResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OpenMeteoWeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpenMeteoWeatherResponseCopyWith<OpenMeteoWeatherResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpenMeteoWeatherResponseCopyWith<$Res> {
  factory $OpenMeteoWeatherResponseCopyWith(
    OpenMeteoWeatherResponse value,
    $Res Function(OpenMeteoWeatherResponse) then,
  ) = _$OpenMeteoWeatherResponseCopyWithImpl<$Res, OpenMeteoWeatherResponse>;
  @useResult
  $Res call({
    double latitude,
    double longitude,
    @JsonKey(name: 'generationtime_ms') double? generationtimeMs,
    @JsonKey(name: 'utc_offset_seconds') int? utcOffsetSeconds,
    String? timezone,
    @JsonKey(name: 'timezone_abbreviation') String? timezoneAbbreviation,
    double? elevation,
    @JsonKey(name: 'current_weather_units')
    CurrentWeatherUnits? currentWeatherUnits,
    @JsonKey(name: 'current_weather') CurrentWeather currentWeather,
  });

  $CurrentWeatherUnitsCopyWith<$Res>? get currentWeatherUnits;
  $CurrentWeatherCopyWith<$Res> get currentWeather;
}

/// @nodoc
class _$OpenMeteoWeatherResponseCopyWithImpl<
  $Res,
  $Val extends OpenMeteoWeatherResponse
>
    implements $OpenMeteoWeatherResponseCopyWith<$Res> {
  _$OpenMeteoWeatherResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OpenMeteoWeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? generationtimeMs = freezed,
    Object? utcOffsetSeconds = freezed,
    Object? timezone = freezed,
    Object? timezoneAbbreviation = freezed,
    Object? elevation = freezed,
    Object? currentWeatherUnits = freezed,
    Object? currentWeather = null,
  }) {
    return _then(
      _value.copyWith(
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            generationtimeMs: freezed == generationtimeMs
                ? _value.generationtimeMs
                : generationtimeMs // ignore: cast_nullable_to_non_nullable
                      as double?,
            utcOffsetSeconds: freezed == utcOffsetSeconds
                ? _value.utcOffsetSeconds
                : utcOffsetSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
            timezoneAbbreviation: freezed == timezoneAbbreviation
                ? _value.timezoneAbbreviation
                : timezoneAbbreviation // ignore: cast_nullable_to_non_nullable
                      as String?,
            elevation: freezed == elevation
                ? _value.elevation
                : elevation // ignore: cast_nullable_to_non_nullable
                      as double?,
            currentWeatherUnits: freezed == currentWeatherUnits
                ? _value.currentWeatherUnits
                : currentWeatherUnits // ignore: cast_nullable_to_non_nullable
                      as CurrentWeatherUnits?,
            currentWeather: null == currentWeather
                ? _value.currentWeather
                : currentWeather // ignore: cast_nullable_to_non_nullable
                      as CurrentWeather,
          )
          as $Val,
    );
  }

  /// Create a copy of OpenMeteoWeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CurrentWeatherUnitsCopyWith<$Res>? get currentWeatherUnits {
    if (_value.currentWeatherUnits == null) {
      return null;
    }

    return $CurrentWeatherUnitsCopyWith<$Res>(_value.currentWeatherUnits!, (
      value,
    ) {
      return _then(_value.copyWith(currentWeatherUnits: value) as $Val);
    });
  }

  /// Create a copy of OpenMeteoWeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CurrentWeatherCopyWith<$Res> get currentWeather {
    return $CurrentWeatherCopyWith<$Res>(_value.currentWeather, (value) {
      return _then(_value.copyWith(currentWeather: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OpenMeteoWeatherResponseImplCopyWith<$Res>
    implements $OpenMeteoWeatherResponseCopyWith<$Res> {
  factory _$$OpenMeteoWeatherResponseImplCopyWith(
    _$OpenMeteoWeatherResponseImpl value,
    $Res Function(_$OpenMeteoWeatherResponseImpl) then,
  ) = __$$OpenMeteoWeatherResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double latitude,
    double longitude,
    @JsonKey(name: 'generationtime_ms') double? generationtimeMs,
    @JsonKey(name: 'utc_offset_seconds') int? utcOffsetSeconds,
    String? timezone,
    @JsonKey(name: 'timezone_abbreviation') String? timezoneAbbreviation,
    double? elevation,
    @JsonKey(name: 'current_weather_units')
    CurrentWeatherUnits? currentWeatherUnits,
    @JsonKey(name: 'current_weather') CurrentWeather currentWeather,
  });

  @override
  $CurrentWeatherUnitsCopyWith<$Res>? get currentWeatherUnits;
  @override
  $CurrentWeatherCopyWith<$Res> get currentWeather;
}

/// @nodoc
class __$$OpenMeteoWeatherResponseImplCopyWithImpl<$Res>
    extends
        _$OpenMeteoWeatherResponseCopyWithImpl<
          $Res,
          _$OpenMeteoWeatherResponseImpl
        >
    implements _$$OpenMeteoWeatherResponseImplCopyWith<$Res> {
  __$$OpenMeteoWeatherResponseImplCopyWithImpl(
    _$OpenMeteoWeatherResponseImpl _value,
    $Res Function(_$OpenMeteoWeatherResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OpenMeteoWeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? generationtimeMs = freezed,
    Object? utcOffsetSeconds = freezed,
    Object? timezone = freezed,
    Object? timezoneAbbreviation = freezed,
    Object? elevation = freezed,
    Object? currentWeatherUnits = freezed,
    Object? currentWeather = null,
  }) {
    return _then(
      _$OpenMeteoWeatherResponseImpl(
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        generationtimeMs: freezed == generationtimeMs
            ? _value.generationtimeMs
            : generationtimeMs // ignore: cast_nullable_to_non_nullable
                  as double?,
        utcOffsetSeconds: freezed == utcOffsetSeconds
            ? _value.utcOffsetSeconds
            : utcOffsetSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
        timezoneAbbreviation: freezed == timezoneAbbreviation
            ? _value.timezoneAbbreviation
            : timezoneAbbreviation // ignore: cast_nullable_to_non_nullable
                  as String?,
        elevation: freezed == elevation
            ? _value.elevation
            : elevation // ignore: cast_nullable_to_non_nullable
                  as double?,
        currentWeatherUnits: freezed == currentWeatherUnits
            ? _value.currentWeatherUnits
            : currentWeatherUnits // ignore: cast_nullable_to_non_nullable
                  as CurrentWeatherUnits?,
        currentWeather: null == currentWeather
            ? _value.currentWeather
            : currentWeather // ignore: cast_nullable_to_non_nullable
                  as CurrentWeather,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OpenMeteoWeatherResponseImpl implements _OpenMeteoWeatherResponse {
  const _$OpenMeteoWeatherResponseImpl({
    required this.latitude,
    required this.longitude,
    @JsonKey(name: 'generationtime_ms') this.generationtimeMs,
    @JsonKey(name: 'utc_offset_seconds') this.utcOffsetSeconds,
    this.timezone,
    @JsonKey(name: 'timezone_abbreviation') this.timezoneAbbreviation,
    this.elevation,
    @JsonKey(name: 'current_weather_units') this.currentWeatherUnits,
    @JsonKey(name: 'current_weather') required this.currentWeather,
  });

  factory _$OpenMeteoWeatherResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OpenMeteoWeatherResponseImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey(name: 'generationtime_ms')
  final double? generationtimeMs;
  @override
  @JsonKey(name: 'utc_offset_seconds')
  final int? utcOffsetSeconds;
  @override
  final String? timezone;
  @override
  @JsonKey(name: 'timezone_abbreviation')
  final String? timezoneAbbreviation;
  @override
  final double? elevation;
  @override
  @JsonKey(name: 'current_weather_units')
  final CurrentWeatherUnits? currentWeatherUnits;
  @override
  @JsonKey(name: 'current_weather')
  final CurrentWeather currentWeather;

  @override
  String toString() {
    return 'OpenMeteoWeatherResponse(latitude: $latitude, longitude: $longitude, generationtimeMs: $generationtimeMs, utcOffsetSeconds: $utcOffsetSeconds, timezone: $timezone, timezoneAbbreviation: $timezoneAbbreviation, elevation: $elevation, currentWeatherUnits: $currentWeatherUnits, currentWeather: $currentWeather)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpenMeteoWeatherResponseImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.generationtimeMs, generationtimeMs) ||
                other.generationtimeMs == generationtimeMs) &&
            (identical(other.utcOffsetSeconds, utcOffsetSeconds) ||
                other.utcOffsetSeconds == utcOffsetSeconds) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.timezoneAbbreviation, timezoneAbbreviation) ||
                other.timezoneAbbreviation == timezoneAbbreviation) &&
            (identical(other.elevation, elevation) ||
                other.elevation == elevation) &&
            (identical(other.currentWeatherUnits, currentWeatherUnits) ||
                other.currentWeatherUnits == currentWeatherUnits) &&
            (identical(other.currentWeather, currentWeather) ||
                other.currentWeather == currentWeather));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    latitude,
    longitude,
    generationtimeMs,
    utcOffsetSeconds,
    timezone,
    timezoneAbbreviation,
    elevation,
    currentWeatherUnits,
    currentWeather,
  );

  /// Create a copy of OpenMeteoWeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpenMeteoWeatherResponseImplCopyWith<_$OpenMeteoWeatherResponseImpl>
  get copyWith =>
      __$$OpenMeteoWeatherResponseImplCopyWithImpl<
        _$OpenMeteoWeatherResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OpenMeteoWeatherResponseImplToJson(this);
  }
}

abstract class _OpenMeteoWeatherResponse implements OpenMeteoWeatherResponse {
  const factory _OpenMeteoWeatherResponse({
    required final double latitude,
    required final double longitude,
    @JsonKey(name: 'generationtime_ms') final double? generationtimeMs,
    @JsonKey(name: 'utc_offset_seconds') final int? utcOffsetSeconds,
    final String? timezone,
    @JsonKey(name: 'timezone_abbreviation') final String? timezoneAbbreviation,
    final double? elevation,
    @JsonKey(name: 'current_weather_units')
    final CurrentWeatherUnits? currentWeatherUnits,
    @JsonKey(name: 'current_weather')
    required final CurrentWeather currentWeather,
  }) = _$OpenMeteoWeatherResponseImpl;

  factory _OpenMeteoWeatherResponse.fromJson(Map<String, dynamic> json) =
      _$OpenMeteoWeatherResponseImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(name: 'generationtime_ms')
  double? get generationtimeMs;
  @override
  @JsonKey(name: 'utc_offset_seconds')
  int? get utcOffsetSeconds;
  @override
  String? get timezone;
  @override
  @JsonKey(name: 'timezone_abbreviation')
  String? get timezoneAbbreviation;
  @override
  double? get elevation;
  @override
  @JsonKey(name: 'current_weather_units')
  CurrentWeatherUnits? get currentWeatherUnits;
  @override
  @JsonKey(name: 'current_weather')
  CurrentWeather get currentWeather;

  /// Create a copy of OpenMeteoWeatherResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpenMeteoWeatherResponseImplCopyWith<_$OpenMeteoWeatherResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CurrentWeatherUnits _$CurrentWeatherUnitsFromJson(Map<String, dynamic> json) {
  return _CurrentWeatherUnits.fromJson(json);
}

/// @nodoc
mixin _$CurrentWeatherUnits {
  String? get time => throw _privateConstructorUsedError;
  String? get interval => throw _privateConstructorUsedError;
  String? get temperature => throw _privateConstructorUsedError;
  String? get windspeed => throw _privateConstructorUsedError;
  String? get winddirection => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_day')
  String? get isDay => throw _privateConstructorUsedError;
  String? get weathercode => throw _privateConstructorUsedError;

  /// Serializes this CurrentWeatherUnits to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CurrentWeatherUnits
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurrentWeatherUnitsCopyWith<CurrentWeatherUnits> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWeatherUnitsCopyWith<$Res> {
  factory $CurrentWeatherUnitsCopyWith(
    CurrentWeatherUnits value,
    $Res Function(CurrentWeatherUnits) then,
  ) = _$CurrentWeatherUnitsCopyWithImpl<$Res, CurrentWeatherUnits>;
  @useResult
  $Res call({
    String? time,
    String? interval,
    String? temperature,
    String? windspeed,
    String? winddirection,
    @JsonKey(name: 'is_day') String? isDay,
    String? weathercode,
  });
}

/// @nodoc
class _$CurrentWeatherUnitsCopyWithImpl<$Res, $Val extends CurrentWeatherUnits>
    implements $CurrentWeatherUnitsCopyWith<$Res> {
  _$CurrentWeatherUnitsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrentWeatherUnits
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = freezed,
    Object? interval = freezed,
    Object? temperature = freezed,
    Object? windspeed = freezed,
    Object? winddirection = freezed,
    Object? isDay = freezed,
    Object? weathercode = freezed,
  }) {
    return _then(
      _value.copyWith(
            time: freezed == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as String?,
            interval: freezed == interval
                ? _value.interval
                : interval // ignore: cast_nullable_to_non_nullable
                      as String?,
            temperature: freezed == temperature
                ? _value.temperature
                : temperature // ignore: cast_nullable_to_non_nullable
                      as String?,
            windspeed: freezed == windspeed
                ? _value.windspeed
                : windspeed // ignore: cast_nullable_to_non_nullable
                      as String?,
            winddirection: freezed == winddirection
                ? _value.winddirection
                : winddirection // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDay: freezed == isDay
                ? _value.isDay
                : isDay // ignore: cast_nullable_to_non_nullable
                      as String?,
            weathercode: freezed == weathercode
                ? _value.weathercode
                : weathercode // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CurrentWeatherUnitsImplCopyWith<$Res>
    implements $CurrentWeatherUnitsCopyWith<$Res> {
  factory _$$CurrentWeatherUnitsImplCopyWith(
    _$CurrentWeatherUnitsImpl value,
    $Res Function(_$CurrentWeatherUnitsImpl) then,
  ) = __$$CurrentWeatherUnitsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? time,
    String? interval,
    String? temperature,
    String? windspeed,
    String? winddirection,
    @JsonKey(name: 'is_day') String? isDay,
    String? weathercode,
  });
}

/// @nodoc
class __$$CurrentWeatherUnitsImplCopyWithImpl<$Res>
    extends _$CurrentWeatherUnitsCopyWithImpl<$Res, _$CurrentWeatherUnitsImpl>
    implements _$$CurrentWeatherUnitsImplCopyWith<$Res> {
  __$$CurrentWeatherUnitsImplCopyWithImpl(
    _$CurrentWeatherUnitsImpl _value,
    $Res Function(_$CurrentWeatherUnitsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CurrentWeatherUnits
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = freezed,
    Object? interval = freezed,
    Object? temperature = freezed,
    Object? windspeed = freezed,
    Object? winddirection = freezed,
    Object? isDay = freezed,
    Object? weathercode = freezed,
  }) {
    return _then(
      _$CurrentWeatherUnitsImpl(
        time: freezed == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as String?,
        interval: freezed == interval
            ? _value.interval
            : interval // ignore: cast_nullable_to_non_nullable
                  as String?,
        temperature: freezed == temperature
            ? _value.temperature
            : temperature // ignore: cast_nullable_to_non_nullable
                  as String?,
        windspeed: freezed == windspeed
            ? _value.windspeed
            : windspeed // ignore: cast_nullable_to_non_nullable
                  as String?,
        winddirection: freezed == winddirection
            ? _value.winddirection
            : winddirection // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDay: freezed == isDay
            ? _value.isDay
            : isDay // ignore: cast_nullable_to_non_nullable
                  as String?,
        weathercode: freezed == weathercode
            ? _value.weathercode
            : weathercode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentWeatherUnitsImpl implements _CurrentWeatherUnits {
  const _$CurrentWeatherUnitsImpl({
    this.time,
    this.interval,
    this.temperature,
    this.windspeed,
    this.winddirection,
    @JsonKey(name: 'is_day') this.isDay,
    this.weathercode,
  });

  factory _$CurrentWeatherUnitsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentWeatherUnitsImplFromJson(json);

  @override
  final String? time;
  @override
  final String? interval;
  @override
  final String? temperature;
  @override
  final String? windspeed;
  @override
  final String? winddirection;
  @override
  @JsonKey(name: 'is_day')
  final String? isDay;
  @override
  final String? weathercode;

  @override
  String toString() {
    return 'CurrentWeatherUnits(time: $time, interval: $interval, temperature: $temperature, windspeed: $windspeed, winddirection: $winddirection, isDay: $isDay, weathercode: $weathercode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentWeatherUnitsImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.windspeed, windspeed) ||
                other.windspeed == windspeed) &&
            (identical(other.winddirection, winddirection) ||
                other.winddirection == winddirection) &&
            (identical(other.isDay, isDay) || other.isDay == isDay) &&
            (identical(other.weathercode, weathercode) ||
                other.weathercode == weathercode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    time,
    interval,
    temperature,
    windspeed,
    winddirection,
    isDay,
    weathercode,
  );

  /// Create a copy of CurrentWeatherUnits
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentWeatherUnitsImplCopyWith<_$CurrentWeatherUnitsImpl> get copyWith =>
      __$$CurrentWeatherUnitsImplCopyWithImpl<_$CurrentWeatherUnitsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentWeatherUnitsImplToJson(this);
  }
}

abstract class _CurrentWeatherUnits implements CurrentWeatherUnits {
  const factory _CurrentWeatherUnits({
    final String? time,
    final String? interval,
    final String? temperature,
    final String? windspeed,
    final String? winddirection,
    @JsonKey(name: 'is_day') final String? isDay,
    final String? weathercode,
  }) = _$CurrentWeatherUnitsImpl;

  factory _CurrentWeatherUnits.fromJson(Map<String, dynamic> json) =
      _$CurrentWeatherUnitsImpl.fromJson;

  @override
  String? get time;
  @override
  String? get interval;
  @override
  String? get temperature;
  @override
  String? get windspeed;
  @override
  String? get winddirection;
  @override
  @JsonKey(name: 'is_day')
  String? get isDay;
  @override
  String? get weathercode;

  /// Create a copy of CurrentWeatherUnits
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurrentWeatherUnitsImplCopyWith<_$CurrentWeatherUnitsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) {
  return _CurrentWeather.fromJson(json);
}

/// @nodoc
mixin _$CurrentWeather {
  String get time => throw _privateConstructorUsedError;
  int get interval => throw _privateConstructorUsedError;
  double get temperature => throw _privateConstructorUsedError;
  double get windspeed => throw _privateConstructorUsedError;
  int get winddirection => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_day')
  int get isDay => throw _privateConstructorUsedError;
  int get weathercode => throw _privateConstructorUsedError;

  /// Serializes this CurrentWeather to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CurrentWeatherCopyWith<CurrentWeather> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWeatherCopyWith<$Res> {
  factory $CurrentWeatherCopyWith(
    CurrentWeather value,
    $Res Function(CurrentWeather) then,
  ) = _$CurrentWeatherCopyWithImpl<$Res, CurrentWeather>;
  @useResult
  $Res call({
    String time,
    int interval,
    double temperature,
    double windspeed,
    int winddirection,
    @JsonKey(name: 'is_day') int isDay,
    int weathercode,
  });
}

/// @nodoc
class _$CurrentWeatherCopyWithImpl<$Res, $Val extends CurrentWeather>
    implements $CurrentWeatherCopyWith<$Res> {
  _$CurrentWeatherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? interval = null,
    Object? temperature = null,
    Object? windspeed = null,
    Object? winddirection = null,
    Object? isDay = null,
    Object? weathercode = null,
  }) {
    return _then(
      _value.copyWith(
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as String,
            interval: null == interval
                ? _value.interval
                : interval // ignore: cast_nullable_to_non_nullable
                      as int,
            temperature: null == temperature
                ? _value.temperature
                : temperature // ignore: cast_nullable_to_non_nullable
                      as double,
            windspeed: null == windspeed
                ? _value.windspeed
                : windspeed // ignore: cast_nullable_to_non_nullable
                      as double,
            winddirection: null == winddirection
                ? _value.winddirection
                : winddirection // ignore: cast_nullable_to_non_nullable
                      as int,
            isDay: null == isDay
                ? _value.isDay
                : isDay // ignore: cast_nullable_to_non_nullable
                      as int,
            weathercode: null == weathercode
                ? _value.weathercode
                : weathercode // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CurrentWeatherImplCopyWith<$Res>
    implements $CurrentWeatherCopyWith<$Res> {
  factory _$$CurrentWeatherImplCopyWith(
    _$CurrentWeatherImpl value,
    $Res Function(_$CurrentWeatherImpl) then,
  ) = __$$CurrentWeatherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String time,
    int interval,
    double temperature,
    double windspeed,
    int winddirection,
    @JsonKey(name: 'is_day') int isDay,
    int weathercode,
  });
}

/// @nodoc
class __$$CurrentWeatherImplCopyWithImpl<$Res>
    extends _$CurrentWeatherCopyWithImpl<$Res, _$CurrentWeatherImpl>
    implements _$$CurrentWeatherImplCopyWith<$Res> {
  __$$CurrentWeatherImplCopyWithImpl(
    _$CurrentWeatherImpl _value,
    $Res Function(_$CurrentWeatherImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? interval = null,
    Object? temperature = null,
    Object? windspeed = null,
    Object? winddirection = null,
    Object? isDay = null,
    Object? weathercode = null,
  }) {
    return _then(
      _$CurrentWeatherImpl(
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as String,
        interval: null == interval
            ? _value.interval
            : interval // ignore: cast_nullable_to_non_nullable
                  as int,
        temperature: null == temperature
            ? _value.temperature
            : temperature // ignore: cast_nullable_to_non_nullable
                  as double,
        windspeed: null == windspeed
            ? _value.windspeed
            : windspeed // ignore: cast_nullable_to_non_nullable
                  as double,
        winddirection: null == winddirection
            ? _value.winddirection
            : winddirection // ignore: cast_nullable_to_non_nullable
                  as int,
        isDay: null == isDay
            ? _value.isDay
            : isDay // ignore: cast_nullable_to_non_nullable
                  as int,
        weathercode: null == weathercode
            ? _value.weathercode
            : weathercode // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentWeatherImpl implements _CurrentWeather {
  const _$CurrentWeatherImpl({
    required this.time,
    required this.interval,
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    @JsonKey(name: 'is_day') required this.isDay,
    required this.weathercode,
  });

  factory _$CurrentWeatherImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentWeatherImplFromJson(json);

  @override
  final String time;
  @override
  final int interval;
  @override
  final double temperature;
  @override
  final double windspeed;
  @override
  final int winddirection;
  @override
  @JsonKey(name: 'is_day')
  final int isDay;
  @override
  final int weathercode;

  @override
  String toString() {
    return 'CurrentWeather(time: $time, interval: $interval, temperature: $temperature, windspeed: $windspeed, winddirection: $winddirection, isDay: $isDay, weathercode: $weathercode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentWeatherImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.windspeed, windspeed) ||
                other.windspeed == windspeed) &&
            (identical(other.winddirection, winddirection) ||
                other.winddirection == winddirection) &&
            (identical(other.isDay, isDay) || other.isDay == isDay) &&
            (identical(other.weathercode, weathercode) ||
                other.weathercode == weathercode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    time,
    interval,
    temperature,
    windspeed,
    winddirection,
    isDay,
    weathercode,
  );

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentWeatherImplCopyWith<_$CurrentWeatherImpl> get copyWith =>
      __$$CurrentWeatherImplCopyWithImpl<_$CurrentWeatherImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentWeatherImplToJson(this);
  }
}

abstract class _CurrentWeather implements CurrentWeather {
  const factory _CurrentWeather({
    required final String time,
    required final int interval,
    required final double temperature,
    required final double windspeed,
    required final int winddirection,
    @JsonKey(name: 'is_day') required final int isDay,
    required final int weathercode,
  }) = _$CurrentWeatherImpl;

  factory _CurrentWeather.fromJson(Map<String, dynamic> json) =
      _$CurrentWeatherImpl.fromJson;

  @override
  String get time;
  @override
  int get interval;
  @override
  double get temperature;
  @override
  double get windspeed;
  @override
  int get winddirection;
  @override
  @JsonKey(name: 'is_day')
  int get isDay;
  @override
  int get weathercode;

  /// Create a copy of CurrentWeather
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurrentWeatherImplCopyWith<_$CurrentWeatherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
