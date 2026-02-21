import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/utils/snackbar.dart';
import 'package:sumikanova/data/model/room_model_simple.dart';

class RoomAddScreen extends StatefulWidget {
  const RoomAddScreen({super.key, this.extraData});

  /// Data passed from Create Home (home name, address, ...) or from Home Settings
  /// (homeId only) for add-locations-only mode.
  final Map<String, dynamic>? extraData;

  /// True when opened from Home Settings to add rooms to an existing home.
  bool get isAddLocationsOnly =>
      extraData != null && extraData!['homeId'] != null;

  @override
  State<RoomAddScreen> createState() => _RoomAddScreenState();
}

class _RoomAddScreenState extends State<RoomAddScreen> {
  final TextEditingController roomNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  /// Rooms from GetRoomCall (location_list) API — display name only.
  List<RoomModel> _recommendedRooms = [];
  bool _roomsLoading = true;
  String? _roomsError;

  /// Selected recommended rooms (id, name). Used when saving.
  final List<Map<String, dynamic>> _selectedRecommendRooms = [];

  /// User-added custom room names. Sent with location_list_id: "0" when saving.
  final List<Map<String, dynamic>> _userAddedRooms = [];

  bool _saveLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    setState(() {
      _roomsLoading = true;
      _roomsError = null;
    });
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
                (e) => RoomModel.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .where((r) => r.id.isNotEmpty)
              .toList();
          setState(() {
            _recommendedRooms = rooms;
            _roomsLoading = false;
            _roomsError = null;
          });
          return;
        }
      }
      setState(() {
        _roomsLoading = false;
        _roomsError = 'Could not load rooms.';
      });
    } catch (_) {
      setState(() {
        _roomsLoading = false;
        _roomsError = 'Something went wrong. Please try again.';
      });
    }
  }

  /// Save when in add-locations-only mode (from Home Settings): call create-multiple API.
  Future<void> _saveAddLocationsOnly() async {
    final homeId = widget.extraData?['homeId']?.toString();
    if (homeId == null || homeId.isEmpty) {
      SnackBarUtils.showSnackBar(context, 'Home not found');
      return;
    }
    final userData = await SecureAuthStorage.getUserData();
    final userId = userData?['id']?.toString();
    if (userId == null || userId.isEmpty) {
      SnackBarUtils.showSnackBar(context, 'Please sign in again');
      return;
    }
    final locations = <Map<String, String>>[
      ..._selectedRecommendRooms.map<Map<String, String>>(
        (m) => {
          'name': (m['name'] as String?) ?? '',
          'is_active': '1',
          'location_list_id': (m['id'] as String?) ?? '',
        },
      ),
      ..._userAddedRooms.map<Map<String, String>>(
        (m) => {
          'name': (m['name'] as String?) ?? '',
          'is_active': '1',
          'location_list_id': '0',
        },
      ),
    ];
    final customRoomName = roomNameController.text.trim();
    if (customRoomName.isNotEmpty) {
      locations.add({
        'name': customRoomName,
        'is_active': '1',
        'location_list_id': '0',
      });
    }
    if (locations.isEmpty) {
      SnackBarUtils.showSnackBar(context, 'Add at least one room');
      return;
    }
    setState(() => _saveLoading = true);
    try {
      final response = await SumikiNovaApi.createMultipleLocationsCall.call(
        homeId: homeId,
        userId: userId,
        locations: locations,
      );
      debugPrint('response: ${response.jsonBody}');
      if (!mounted) return;
      setState(() => _saveLoading = false);
      if (response.succeeded) {
        SnackBarUtils.showSnackBar(
          context,
          response.jsonBody is Map && response.jsonBody['message'] != null
              ? response.jsonBody['message'].toString()
              : 'Rooms added successfully',
        );
        context.pop();
      } else {
        final msg =
            response.jsonBody is Map && response.jsonBody['message'] != null
            ? response.jsonBody['message'].toString()
            : 'Failed to add rooms. Please try again.';
        SnackBarUtils.showSnackBar(context, msg);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _saveLoading = false);
        SnackBarUtils.showSnackBar(
          context,
          'Something went wrong. Please try again.',
        );
      }
    }
  }

  /// Build locations list for CreateHomeWithLocationsCall: selected recommend
  /// (with their id) + custom rooms (location_list_id "0") + extraData selectedRooms.

  Future<void> _saveHomeWithLocations() async {
    if (widget.extraData == null) {
      SnackBarUtils.showSnackBar(context, 'Complete Create Home first');
      return;
    }
    final homeName = (widget.extraData!['homeName'] as String?)?.trim() ?? '';
    final address = (widget.extraData!['address'] as String?)?.trim() ?? '';
    if (homeName.isEmpty) {
      SnackBarUtils.showSnackBar(context, 'Home name is required');
      return;
    }
    if (address.isEmpty) {
      SnackBarUtils.showSnackBar(context, 'Address is required');
      return;
    }

    final userData = await SecureAuthStorage.getUserData();
    final userId = userData?['id']?.toString();
    if (userId == null || userId.isEmpty) {
      SnackBarUtils.showSnackBar(context, 'Please sign in again');
      return;
    }

    final locations = <Map<String, String>>[
      ..._selectedRecommendRooms.map<Map<String, String>>(
        (m) => {
          'name': (m['name'] as String?) ?? '',
          'is_active': '1',
          'location_list_id': (m['id'] as String?) ?? '',
        },
      ),
      ..._userAddedRooms.map<Map<String, String>>(
        (m) => {
          'name': (m['name'] as String?) ?? '',
          'is_active': '1',
          'location_list_id': '0',
        },
      ),
    ];
    final customRoomName = roomNameController.text.trim();
    if (customRoomName.isNotEmpty) {
      locations.add({
        'name': customRoomName,
        'is_active': '1',
        'location_list_id': '0',
      });
    }
    setState(() => _saveLoading = true);
    try {
      final response = await SumikiNovaApi.createHomeWithLocationsCall.call(
        name: homeName,
        address: address,
        userid: userId,
        isActive: '1',
        locations: locations,
      );
      if (!mounted) return;
      setState(() => _saveLoading = false);
      if (response.succeeded) {
        SnackBarUtils.showSnackBar(
          context,
          response.jsonBody is Map && response.jsonBody['message'] != null
              ? response.jsonBody['message'].toString()
              : 'Home saved successfully',
        );
        context.pop();
        context.pop();
      } else {
        final msg =
            response.jsonBody is Map && response.jsonBody['message'] != null
            ? response.jsonBody['message'].toString()
            : 'Failed to save. Please try again.';
        SnackBarUtils.showSnackBar(context, msg);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _saveLoading = false);
        SnackBarUtils.showSnackBar(
          context,
          'Something went wrong. Please try again.',
        );
      }
    }
  }

  @override
  void dispose() {
    roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.white2,
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            CustomHeader(
              isAllowBack: true,
              title: 'Add Room',
              isSubmit: true,
              onSubmit: _saveLoading
                  ? null
                  : (widget.isAddLocationsOnly
                        ? _saveAddLocationsOnly
                        : _saveHomeWithLocations),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // if (widget.extraData != null &&
                    //     (widget.extraData!['homeName'] != null ||
                    //         widget.extraData!['address'] != null)) ...[
                    //   Container(
                    //     padding: const EdgeInsets.all(14),
                    //     decoration: BoxDecoration(
                    //       color: AppColor.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: const Color(0x40C7C6C6),
                    //           blurRadius: 6,
                    //           offset: const Offset(0, 2),
                    //           spreadRadius: 0,
                    //         ),
                    //       ],
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.stretch,
                    //       spacing: 8,
                    //       children: [
                    //         if (widget.extraData!['homeName'] != null &&
                    //             (widget.extraData!['homeName'] as String)
                    //                 .isNotEmpty)
                    //           _InfoRow(
                    //             label: 'Home Name',
                    //             value: widget.extraData!['homeName'] as String,
                    //           ),
                    //         if (widget.extraData!['address'] != null)
                    //           _InfoRow(
                    //             label: 'Location',
                    //             value: widget.extraData!['address'] as String,
                    //           ),
                    //       ],
                    //     ),
                    //   ),
                    // ],
                    CustomTxtFormField(
                      controller: roomNameController,
                      hintText: 'Room Name',
                      labelText: 'Room Name',
                      hintColor: AppColor.black,
                      validator: (String? value) {
                        return validationEmpty(value, 'Enter room name');
                      },
                    ),
                    // Text(_selectedRecommendRooms.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Recommend',
                          style: TypographyFont.uih5med.copyWith(
                            color: AppColor.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    if (_roomsLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_roomsError != null)
                      Center(
                        child: Text(
                          _roomsError!,
                          style: TypographyFont.uih6reg.copyWith(
                            color: AppColor.black,
                          ),
                        ),
                      )
                    else
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          ..._recommendedRooms.map<Widget>((RoomModel room) {
                            final isSelected = _selectedRecommendRooms.any(
                              (m) => m['id'] == room.id,
                            );
                            return _RoomChip(
                              name: room.name,
                              locationListId: room.id,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  final idx = _selectedRecommendRooms
                                      .indexWhere((m) => m['id'] == room.id);
                                  if (idx >= 0) {
                                    _selectedRecommendRooms.removeAt(idx);
                                  } else {
                                    _selectedRecommendRooms.add({
                                      'id': room.id,
                                      'name': room.name,
                                    });
                                  }
                                });
                              },
                            );
                          }),
                          ..._userAddedRooms.map<Widget>(
                            (Map<String, dynamic> room) => _RoomChip(
                              name: (room['name'] as String?) ?? '',
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoomChip extends StatelessWidget {
  const _RoomChip({
    required this.name,
    this.locationListId,
    this.isSelected = false,
    this.onTap,
  });

  final String name;
  final String? locationListId;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(4),
        border: isSelected
            ? Border.all(color: AppColor.primary, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: const Color(0x40C7C6C6),
            blurRadius: 6,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Text(
        name,
        style: TypographyFont.uih6reg.copyWith(color: AppColor.black),
      ),
    );
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: child,
      );
    }
    return child;
  }
}
