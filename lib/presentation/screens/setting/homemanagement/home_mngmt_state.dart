import 'package:sumikanova/data/model/room_model_simple.dart';

class HomeMngmtState {
  final bool isLoading;
  final String? error;
  final String? message;
  final List<RoomModel> rooms;
  final bool roomsLoading;
  final String? roomsError;

  HomeMngmtState({
    this.isLoading = false,
    this.error,
    this.message,
    this.rooms = const [],
    this.roomsLoading = false,
    this.roomsError,
  });

  HomeMngmtState copyWith({
    bool? isLoading,
    String? error,
    String? message,
    List<RoomModel>? rooms,
    bool? roomsLoading,
    String? roomsError,
  }) {
    return HomeMngmtState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      message: message ?? this.message,
      rooms: rooms ?? this.rooms,
      roomsLoading: roomsLoading ?? this.roomsLoading,
      roomsError: roomsError,
    );
  }
}
