import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/data/model/room_model_simple.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/home_mngmt_state.dart';

class HomeMngmtController extends StateNotifier<HomeMngmtState> {
  HomeMngmtController() : super(HomeMngmtState());

  /// Fetches rooms from location_list API and updates state.
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
              .map((e) => RoomModel.fromJson(Map<String, dynamic>.from(e as Map)))
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

  /// Creates a home. Returns true on success.
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
          message:
              response.jsonBody is Map && response.jsonBody['message'] != null
              ? response.jsonBody['message'].toString()
              : 'Home created successfully',
        );
        return true;
      }
      final errorMsg = _extractErrorMessage(response);
      state = state.copyWith(isLoading: false, error: errorMsg);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Please try again.',
      );
      return false;
    }
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
    state = state.copyWith(error: null);
  }
}
