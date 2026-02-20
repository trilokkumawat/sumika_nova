import 'package:sumikanova/data/model/locationlist/locationlist_model.dart';

/// State for the main Home screen: home list, selected home, locations, header.
class HomeScreenState {
  const HomeScreenState({
    this.homeList = const [],
    this.selectedHomeId,
    this.locationList = const [],
    this.locationListLoading = false,
    this.selectedLocationIndex = 0,
    this.headerTitle,
  });

  /// Options for the header dropdown: [{"id": int, "name": String}].
  final List<Map<String, dynamic>> homeList;
  final int? selectedHomeId;
  final List<LocationItem> locationList;
  final bool locationListLoading;
  final int selectedLocationIndex;
  final String? headerTitle;

  HomeScreenState copyWith({
    List<Map<String, dynamic>>? homeList,
    int? selectedHomeId,
    List<LocationItem>? locationList,
    bool? locationListLoading,
    int? selectedLocationIndex,
    String? headerTitle,
  }) {
    return HomeScreenState(
      homeList: homeList ?? this.homeList,
      selectedHomeId: selectedHomeId ?? this.selectedHomeId,
      locationList: locationList ?? this.locationList,
      locationListLoading: locationListLoading ?? this.locationListLoading,
      selectedLocationIndex:
          selectedLocationIndex ?? this.selectedLocationIndex,
      headerTitle: headerTitle ?? this.headerTitle,
    );
  }
}
