import 'package:sumikanova/data/model/locationlist/locationlist_model.dart';
import 'package:sumikanova/data/model/weather/open_meteo_weather_model.dart';

/// State for the main Home screen: home list, selected home, locations, header.
class HomeScreenState {
  const HomeScreenState({
    this.homeList = const [],
    this.selectedHomeId,
    this.locationList = const [],
    this.locationListLoading = false,
    this.selectedLocationIndex = 0,
    this.headerTitle,
    this.currentWeatherTemperature,
    this.currentWeather,
    this.weatherLoading = false,
  });

  /// Options for the header dropdown: [{"id": int, "name": String}].
  final List<Map<String, dynamic>> homeList;
  final int? selectedHomeId;
  final List<LocationItem> locationList;
  final bool locationListLoading;
  final int selectedLocationIndex;
  final String? headerTitle;
  /// Temperature from Open-Meteo current_weather (℃). Null until fetched or on error.
  final double? currentWeatherTemperature;
  /// Current weather from Open-Meteo (e.g. isDay, weathercode). Null until fetched.
  final CurrentWeather? currentWeather;
  final bool weatherLoading;

  HomeScreenState copyWith({
    List<Map<String, dynamic>>? homeList,
    int? selectedHomeId,
    List<LocationItem>? locationList,
    bool? locationListLoading,
    int? selectedLocationIndex,
    String? headerTitle,
    double? currentWeatherTemperature,
    CurrentWeather? currentWeather,
    bool? weatherLoading,
  }) {
    return HomeScreenState(
      homeList: homeList ?? this.homeList,
      selectedHomeId: selectedHomeId ?? this.selectedHomeId,
      locationList: locationList ?? this.locationList,
      locationListLoading: locationListLoading ?? this.locationListLoading,
      selectedLocationIndex:
          selectedLocationIndex ?? this.selectedLocationIndex,
      headerTitle: headerTitle ?? this.headerTitle,
      currentWeatherTemperature:
          currentWeatherTemperature ?? this.currentWeatherTemperature,
      currentWeather: currentWeather ?? this.currentWeather,
      weatherLoading: weatherLoading ?? this.weatherLoading,
    );
  }
}
