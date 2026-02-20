import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/data/model/homelist/homelist_model.dart';
import 'package:sumikanova/data/model/locationlist/locationlist_model.dart';
import 'package:sumikanova/presentation/screens/home/home_state.dart';

/// Controller for the main Home screen. Loads home list by userId, locations by homeId, persists selected home.
class HomeController extends StateNotifier<HomeScreenState> {
  HomeController() : super(const HomeScreenState());

  /// Loads user's home list and restores selected home from local storage (or default to first).
  Future<void> loadHomeList() async {
    final userData = await SecureAuthStorage.getUserData();
    final userId = userData?['id']?.toString();
    final userName = userData?['name']?.toString();
    if (userId == null || userId.isEmpty) {
      state = state.copyWith(headerTitle: userName);
      return;
    }
    state = state.copyWith(headerTitle: userName);
    final response =
        await SumikiNovaApi.getUserHomeListCall.call(userId: userId);
    if (!response.succeeded || response.jsonBody == null) return;
    try {
      final parsed = HomeListResponse.fromJson(
        response.jsonBody as Map<String, dynamic>,
      );
      final homes = parsed.data.homes;
      final list = homes
          .map<Map<String, dynamic>>((h) => {'id': h.id, 'name': h.name})
          .toList();
      int? selectedId = state.selectedHomeId;
      final savedId = await SecureAuthStorage.getHomeIdLocal();
      final savedInt = savedId != null ? int.tryParse(savedId) : null;
      if (list.isNotEmpty) {
        final ids = list.map((m) => m['id'] as int).toList();
        if (savedInt != null && ids.contains(savedInt)) {
          selectedId = savedInt;
        } else {
          selectedId = ids.first;
          await SecureAuthStorage.saveHomeIdLocal(selectedId.toString());
        }
      } else {
        selectedId = null;
      }
      state = state.copyWith(
        homeList: list,
        selectedHomeId: selectedId,
        locationList: const [],
        selectedLocationIndex: 0,
      );
      if (selectedId != null) await loadLocationList(selectedId);
    } catch (_) {
      state = state.copyWith(homeList: [], selectedHomeId: null);
    }
  }

  /// Sets selected home, persists to local storage, and loads locations for that home.
  Future<void> setSelectedHome(int? id) async {
    if (id != null) await SecureAuthStorage.saveHomeIdLocal(id.toString());
    state = state.copyWith(
      selectedHomeId: id,
      locationList: const [],
      selectedLocationIndex: 0,
    );
    if (id != null) await loadLocationList(id);
  }

  /// Loads locations (rooms) for the given home id.
  Future<void> loadLocationList(int homeId) async {
    state = state.copyWith(locationListLoading: true, locationList: const []);
    final response = await SumikiNovaApi.getHomeByIdLocationCall.call(
      homeid: homeId.toString(),
    );
    if (!response.succeeded || response.jsonBody == null) {
      state = state.copyWith(
        locationList: const [],
        locationListLoading: false,
      );
      return;
    }
    try {
      final parsed = LocationListResponse.fromJson(
        response.jsonBody as Map<String, dynamic>,
      );
      state = state.copyWith(
        locationList: parsed.data.locations,
        locationListLoading: false,
        selectedLocationIndex: 0,
      );
    } catch (_) {
      state = state.copyWith(
        locationList: const [],
        locationListLoading: false,
      );
    }
  }

  void setSelectedLocationIndex(int index) {
    state = state.copyWith(selectedLocationIndex: index);
  }
}
