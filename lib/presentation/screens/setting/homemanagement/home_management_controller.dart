import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/data/model/homelist/homelist_model.dart';
import 'package:sumikanova/data/model/locationlist/locationlist_model.dart';
import 'package:sumikanova/data/model/room_model_simple.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/home_management_state.dart';

/// Single controller for the Home Management feature.
/// All state changes go through this controller; UI watches [homeManagementProvider].
class HomeManagementController extends StateNotifier<HomeManagementState> {
  HomeManagementController() : super(const HomeManagementState());

  /// Loads user's home list. Call on parent screen init and refresh.
  Future<void> loadHomes() async {
    state = state.copyWith(homesLoading: true, homesError: null);
    try {
      final userData = await SecureAuthStorage.getUserData();
      final userId = userData?['id']?.toString();
      if (userId == null || userId.isEmpty) {
        state = state.copyWith(
          homesLoading: false,
          homesError: 'User not found. Please sign in again.',
        );
        return;
      }
      final response =
          await SumikiNovaApi.getUserHomeListCall.call(userId: userId);
      if (!response.succeeded) {
        state = state.copyWith(
          homesLoading: false,
          homesError: response.exceptionMessage.isNotEmpty
              ? response.exceptionMessage
              : 'Failed to load homes',
        );
        return;
      }
      final body = response.jsonBody;
      final map = body is Map<String, dynamic>
          ? body
          : (body is Map ? Map<String, dynamic>.from(body) : null);
      if (map == null) {
        state = state.copyWith(
          homesLoading: false,
          homesError: 'Invalid response',
        );
        return;
      }
      final homeList = HomeListResponse.fromJson(map);
      final homes = homeList.data.homes;
      state = state.copyWith(
        homes: homes,
        homesLoading: false,
        homesError: null,
      );
    } catch (e) {
      state = state.copyWith(
        homesLoading: false,
        homesError: 'Something went wrong. Please try again.',
      );
    }
  }

  /// Loads rooms from location_list API (for create-home flow).
  Future<void> loadRooms() async {
    state = state.copyWith(roomsLoading: true, roomsError: null);
    try {
      final response = await SumikiNovaApi.getRoomCall.call();
      if (response.succeeded &&
          response.jsonBody is Map &&
          (response.jsonBody as Map).containsKey('data')) {
        final data = (response.jsonBody as Map)['data'];
        if (data is List) {
          final rooms = data
              .where((e) => e is Map)
              .map(
                (e) =>
                    RoomModel.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .where((r) => r.id.isNotEmpty)
              .toList();
          state = state.copyWith(
            rooms: rooms,
            roomsLoading: false,
            roomsError: null,
          );
          return;
        }
      }
      state = state.copyWith(
        roomsLoading: false,
        roomsError: 'Could not load rooms.',
      );
    } catch (e) {
      state = state.copyWith(
        roomsLoading: false,
        roomsError: 'Something went wrong. Please try again.',
      );
    }
  }

  /// Loads locations (rooms) for a given home (settings screen).
  Future<void> loadLocationsForHome(int homeId) async {
    state = state.copyWith(
      locationsLoading: true,
      locationsError: null,
      locationsForCurrentHome: const [],
    );
    try {
      final response = await SumikiNovaApi.getHomeByIdLocationCall.call(
        homeid: homeId.toString(),
      );
      if (!response.succeeded) {
        state = state.copyWith(
          locationsLoading: false,
          locationsError: 'Could not load rooms.',
        );
        return;
      }
      final body = response.jsonBody;
      final map = body is Map<String, dynamic>
          ? body
          : (body is Map ? Map<String, dynamic>.from(body) : null);
      if (map == null) {
        state = state.copyWith(
          locationsLoading: false,
          locationsForCurrentHome: const [],
        );
        return;
      }
      final locationList = LocationListResponse.fromJson(map);
      state = state.copyWith(
        locationsForCurrentHome: locationList.data.locations,
        locationsLoading: false,
        locationsError: null,
      );
    } catch (e) {
      state = state.copyWith(
        locationsLoading: false,
        locationsError: 'Something went wrong. Please try again.',
      );
    }
  }

  /// Creates a home (name only). Returns true on success.
  Future<bool> createHome({required String name}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userData = await SecureAuthStorage.getUserData();
      final userId = userData?['id']?.toString();
      if (userId == null || userId.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'User not found. Please sign in again.',
        );
        return false;
      }
      final response = await SumikiNovaApi.createHomeCall.call(
        name: name.trim(),
        userid: userId,
        is_active: '1',
      );
      if (response.succeeded) {
        state = state.copyWith(
          isLoading: false,
          message: _messageFromResponse(response),
        );
        return true;
      }
      state = state.copyWith(
        isLoading: false,
        error: _extractErrorMessage(response),
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Please try again.',
      );
      return false;
    }
  }

  /// Creates a home with address and selected locations. Returns true on success.
  Future<bool> createHomeWithLocations({
    required String name,
    required String address,
    required List<Map<String, String>> locations,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final userData = await SecureAuthStorage.getUserData();
      final userId = userData?['id']?.toString();
      if (userId == null || userId.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          error: 'User not found. Please sign in again.',
        );
        return false;
      }
      final response = await SumikiNovaApi.createHomeWithLocationsCall.call(
        name: name.trim(),
        address: address,
        userid: userId,
        isActive: '1',
        locations: locations,
      );
      if (response.succeeded) {
        state = state.copyWith(
          isLoading: false,
          message: _messageFromResponse(response),
        );
        return true;
      }
      state = state.copyWith(
        isLoading: false,
        error: _extractErrorMessage(response),
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Please try again.',
      );
      return false;
    }
  }

  String _messageFromResponse(ApiCallResponse response) {
    final body = response.jsonBody;
    if (body is Map && body['message'] != null) {
      return body['message'].toString();
    }
    return 'Home created successfully';
  }

  String _extractErrorMessage(ApiCallResponse response) {
    final body = response.jsonBody;
    if (body is Map) {
      if (body.containsKey('errors') && body['errors'] is Map) {
        final errors = body['errors'] as Map;
        final messages = <String>[];
        for (final field in errors.values) {
          if (field is List) {
            messages.addAll(field.map((e) => e.toString()));
          }
        }
        if (messages.isNotEmpty) return messages.join('\n');
      }
      if (body.containsKey('message') && body['message'] != null) {
        return body['message'].toString();
      }
    }
    return 'Request failed (${response.statusCode}). Please try again.';
  }

  void clearError() {
    state = state.copyWith(error: null, homesError: null, roomsError: null);
  }

  void clearMessage() {
    state = state.copyWith(message: null);
  }
}
