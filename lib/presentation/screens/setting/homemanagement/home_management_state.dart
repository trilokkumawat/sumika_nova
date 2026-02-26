import 'package:sumikanova/data/model/homelist/homelist_model.dart';
import 'package:sumikanova/data/model/locationlist/locationlist_model.dart';
import 'package:sumikanova/data/model/room_model_simple.dart';

/// Single immutable state for the entire Home Management feature.
/// Used by [HomeManagementController] and [homeManagementProvider].
class HomeManagementState {
  const HomeManagementState({
    this.homes = const [],
    this.homesLoading = false,
    this.homesError,
    this.rooms = const [],
    this.roomsLoading = false,
    this.roomsError,
    this.isLoading = false,
    this.error,
    this.message,
    this.locationsForCurrentHome = const [],
    this.locationsLoading = false,
    this.locationsError,
  });

  /// Home list (parent screen).
  final List<HomeItem> homes;
  final bool homesLoading;
  final String? homesError;

  /// Rooms from location_list (create-home flow).
  final List<RoomModel> rooms;
  final bool roomsLoading;
  final String? roomsError;

  /// Create home submission.
  final bool isLoading;
  final String? error;
  final String? message;

  /// Locations/rooms for the current home (settings screen).
  final List<LocationItem> locationsForCurrentHome;
  final bool locationsLoading;
  final String? locationsError;

  HomeManagementState copyWith({
    List<HomeItem>? homes,
    bool? homesLoading,
    String? homesError,
    List<RoomModel>? rooms,
    bool? roomsLoading,
    String? roomsError,
    bool? isLoading,
    String? error,
    String? message,
    List<LocationItem>? locationsForCurrentHome,
    bool? locationsLoading,
    String? locationsError,
  }) {
    return HomeManagementState(
      homes: homes ?? this.homes,
      homesLoading: homesLoading ?? this.homesLoading,
      homesError: homesError,
      rooms: rooms ?? this.rooms,
      roomsLoading: roomsLoading ?? this.roomsLoading,
      roomsError: roomsError,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      message: message ?? this.message,
      locationsForCurrentHome:
          locationsForCurrentHome ?? this.locationsForCurrentHome,
      locationsLoading: locationsLoading ?? this.locationsLoading,
      locationsError: locationsError,
    );
  }
}
