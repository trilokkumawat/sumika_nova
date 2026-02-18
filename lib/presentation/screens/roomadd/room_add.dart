import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/utils/snakbar.dart';
import 'package:sumikanova/data/model/room_model_simple.dart';

class RoomAddScreen extends StatefulWidget {
  const RoomAddScreen({super.key, this.extraData});

  /// Data passed from Create Home (home name, location, selected rooms).
  final Map<String, dynamic>? extraData;

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

  /// Selected recommend room ids (location_list_id from API). Used when saving.
  final Set<String> _selectedRecommendIds = {};

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

  /// Build locations list for CreateHomeWithLocationsCall: selected recommend
  /// (with their id) + custom rooms (location_list_id "0") + extraData selectedRooms.
  List<Map<String, String>> _buildLocationsList() {
    final List<Map<String, String>> list = [];

    // From Create Home (extraData selectedRooms)
    final extraRooms = widget.extraData?['selectedRooms'] as List?;
    if (extraRooms != null) {
      for (final r in extraRooms) {
        if (r is Map) {
          final map = Map<String, dynamic>.from(r);
          final id = (map['id'] ?? '').toString();
          final name = (map['label'] ?? map['name'] ?? '').toString();
          if (name.isNotEmpty) {
            list.add({'name': name, 'location_list_id': id, 'is_active': '1'});
          }
        }
      }
    }

    // Selected recommend rooms (use API id)
    for (final room in _recommendedRooms) {
      if (_selectedRecommendIds.contains(room.id)) {
        list.add({
          'name': room.name,
          'location_list_id': room.id,
          'is_active': '1',
        });
      }
    }

    // Custom rooms (location_list_id 0)
    for (final r in _userAddedRooms) {
      final name = (r['name'] as String?)?.trim() ?? '';
      if (name.isNotEmpty) {
        list.add({'name': name, 'location_list_id': '0', 'is_active': '1'});
      }
    }

    return list;
  }

  Future<void> _saveHomeWithLocations() async {
    if (widget.extraData == null) {
      SnakBarUtils.showSnakBar(context, 'Complete Create Home first');
      return;
    }
    final homeName = (widget.extraData!['homeName'] as String?)?.trim() ?? '';
    final address = (widget.extraData!['address'] as String?)?.trim() ?? '';
    if (homeName.isEmpty) {
      SnakBarUtils.showSnakBar(context, 'Home name is required');
      return;
    }
    if (address.isEmpty) {
      SnakBarUtils.showSnakBar(context, 'Address is required');
      return;
    }

    final locations = _buildLocationsList();
    if (locations.isEmpty) {
      SnakBarUtils.showSnakBar(
        context,
        'Select at least one room or add a custom room',
      );
      return;
    }

    final userData = await SecureAuthStorage.getUserData();
    final userId = userData?['id']?.toString();
    if (userId == null || userId.isEmpty) {
      SnakBarUtils.showSnakBar(context, 'Please sign in again');
      return;
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
        SnakBarUtils.showSnakBar(
          context,
          response.jsonBody is Map && response.jsonBody['message'] != null
              ? response.jsonBody['message'].toString()
              : 'Home saved successfully',
        );
        context.pop();
      } else {
        final msg =
            response.jsonBody is Map && response.jsonBody['message'] != null
            ? response.jsonBody['message'].toString()
            : 'Failed to save. Please try again.';
        SnakBarUtils.showSnakBar(context, msg);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _saveLoading = false);
        SnakBarUtils.showSnakBar(
          context,
          'Something went wrong. Please try again.',
        );
      }
    }
  }

  void _addCustomRoom() {
    if (!formKey.currentState!.validate()) return;
    final name = roomNameController.text.trim();
    if (name.isEmpty) return;
    setState(() {
      _userAddedRooms.add({
        'id': 'custom_${_userAddedRooms.length}',
        'name': name,
      });
    });
    roomNameController.clear();
    FocusScope.of(context).unfocus();
    SnakBarUtils.showSnakBar(context, 'Room added');
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
              onSubmit: _saveLoading ? null : _saveHomeWithLocations,
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
                    if (widget.extraData != null &&
                        (widget.extraData!['homeName'] != null ||
                            widget.extraData!['address'] != null)) ...[
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x40C7C6C6),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 8,
                          children: [
                            if (widget.extraData!['homeName'] != null &&
                                (widget.extraData!['homeName'] as String)
                                    .isNotEmpty)
                              _InfoRow(
                                label: 'Home Name',
                                value: widget.extraData!['homeName'] as String,
                              ),
                            if (widget.extraData!['address'] != null)
                              _InfoRow(
                                label: 'Location',
                                value: widget.extraData!['address'] as String,
                              ),
                            if (widget.extraData!['selectedRooms'] != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Selected rooms: ${(widget.extraData!['selectedRooms'] as List).length}',
                                style: TypographyFont.uih6reg.copyWith(
                                  color: AppColor.black,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                    CustomTxtFormField(
                      controller: roomNameController,
                      hintText: 'Room Name',
                      labelText: 'Room Name',
                      hintColor: AppColor.black,
                      validator: (String? value) {
                        return validationEmpty(value, 'Enter room name');
                      },
                    ),
                    AppButton(text: 'Add room', onPressed: _addCustomRoom),

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
                          ..._recommendedRooms.map<Widget>(
                            (RoomModel room) => _RoomChip(
                              name: room.name,
                              locationListId: room.id,
                              isSelected: _selectedRecommendIds.contains(
                                room.id,
                              ),
                              onTap: () {
                                setState(() {
                                  if (_selectedRecommendIds.contains(room.id)) {
                                    _selectedRecommendIds.remove(room.id);
                                  } else {
                                    _selectedRecommendIds.add(room.id);
                                  }
                                });
                              },
                            ),
                          ),
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TypographyFont.uih6reg.copyWith(color: AppColor.gray4),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TypographyFont.uih6reg.copyWith(color: AppColor.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
