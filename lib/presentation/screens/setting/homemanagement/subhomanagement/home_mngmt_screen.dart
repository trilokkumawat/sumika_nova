import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/utils/snakbar.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/devicecard.dart';
import 'package:sumikanova/core/widget/errorshow.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/home_management_provider.dart';

class HomeManagementScreen extends ConsumerStatefulWidget {
  const HomeManagementScreen({super.key});

  @override
  ConsumerState<HomeManagementScreen> createState() =>
      _HomeManagementScreenState();
}

class _HomeManagementScreenState extends ConsumerState<HomeManagementScreen> {
  static const int _maxRoomsToShow = 8;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController deviceNameController = TextEditingController();
  Map<String, dynamic>? selectedRoomId;
  final List<Map<String, dynamic>> _selectedDevices = [];
  LatLng? _selectedLocation;
  String? _selectedAddress;
  bool _roomsLoadTriggered = false;

  @override
  void dispose() {
    deviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeManagementProvider);
    final controller = ref.read(homeManagementProvider.notifier);
    if (!_roomsLoadTriggered) {
      _roomsLoadTriggered = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.loadRooms();
      });
    }
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          if (context.mounted) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              Column(
                children: [
                  CustomHeader(title: 'Create Home', isAllowBack: true),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTxtFormField(
                            hintColor: AppColor.black,
                            controller: deviceNameController,
                            hintText: 'Home Name',
                            labelText: 'Home Name',
                            validator: (value) {
                              return validationEmpty(value, 'Enter home name');
                            },
                          ),
                          if (state.error != null)
                            CustomErrorShow(
                              errorMessage: state.error!,
                            ),
                          if (state.roomsError != null)
                            CustomErrorShow(
                              errorMessage: state.roomsError!,
                            ),
                          InkWell(
                            onTap: () async {
                              _selectedAddress = null;
                              _selectedLocation = null;
                              final result = await context
                                  .push<Map<String, dynamic>?>(
                                    RouteName.mapView,
                                    extra: _selectedLocation != null
                                        ? {
                                            'lat': _selectedLocation!.latitude,
                                            'lng': _selectedLocation!.longitude,
                                          }
                                        : null,
                                  );
                              if (result != null && mounted) {
                                setState(() {
                                  _selectedLocation = LatLng(
                                    (result['lat'] as num).toDouble(),
                                    (result['lng'] as num).toDouble(),
                                  );
                                  _selectedAddress =
                                      result['address'] as String?;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x40C7C6C6),
                                    offset: const Offset(0, 2),
                                    blurRadius: 6,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedLocation != null
                                          ? (_selectedAddress != null &&
                                                    _selectedAddress!.isNotEmpty
                                                ? _selectedAddress!
                                                : 'Location set (${_selectedLocation!.latitude.toStringAsFixed(4)}, ${_selectedLocation!.longitude.toStringAsFixed(4)})')
                                          : 'Set Location',
                                      style: TypographyFont.uih5med.copyWith(
                                        color: AppColor.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColor.gray4,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          state.roomsLoading
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(24),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 12.0,
                                        mainAxisSpacing: 12.0,
                                        childAspectRatio: 1.5,
                                      ),
                                  itemCount:
                                      state.rooms.length > _maxRoomsToShow
                                      ? _maxRoomsToShow
                                      : state.rooms.length,
                                  itemBuilder: (context, index) {
                                    final room = state.rooms[index];
                                    final device = room.toDeviceCardMap();
                                    final deviceMap = Map<String, dynamic>.from(
                                      device,
                                    );
                                    final isSelected = _selectedDevices.any(
                                      (m) => m['id'] == device['id'],
                                    );
                                    return CustomDeviceCard(
                                      device: device,
                                      cardwidth: 150.0,
                                      cardheight: 150.0,
                                      isSelected: isSelected,
                                      onTap: () => setState(() {
                                        final id = device['id'];
                                        if (id == null) return;
                                        final idx = _selectedDevices.indexWhere(
                                          (m) => m['id'] == id,
                                        );
                                        if (idx >= 0) {
                                          _selectedDevices.removeAt(idx);
                                        } else {
                                          _selectedDevices.add(deviceMap);
                                        }
                                      }),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  bottom: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            borderRadius: 16,
                            text: 'Save',
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) return;
                              if (_selectedLocation == null) {
                                SnakBarUtils.showSnakBar(
                                  context,
                                  'Please set location',
                                );
                                return;
                              }
                              if (_selectedDevices.isEmpty) {
                                SnakBarUtils.showSnakBar(
                                  context,
                                  'Please select location',
                                );
                                return;
                              }
                              final address =
                                  (_selectedAddress != null &&
                                      _selectedAddress!.isNotEmpty)
                                  ? _selectedAddress!
                                  : '${_selectedLocation!.latitude},${_selectedLocation!.longitude}';
                              final locations = _selectedDevices
                                  .map<Map<String, String>>(
                                    (d) => {
                                      'name': (d['label'] ?? '').toString(),
                                      'location_list_id': (d['id'] ?? '')
                                          .toString(),
                                      'is_active': '1',
                                    },
                                  )
                                  .toList();
                              final success = await controller
                                  .createHomeWithLocations(
                                    name: deviceNameController.text.trim(),
                                    address: address,
                                    locations: locations,
                                  );
                              if (success && mounted) {
                                final message = ref
                                    .read(homeManagementProvider)
                                    .message;
                                SnakBarUtils.showSnakBar(
                                  context,
                                  message ?? 'Home created successfully',
                                );
                                context.pop();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            borderRadius: 16,
                            text: 'Add Room',
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;
                              if (_selectedLocation == null) {
                                SnakBarUtils.showSnakBar(
                                  context,
                                  'Please set location first',
                                );
                                return;
                              }
                              final address =
                                  (_selectedAddress != null &&
                                      _selectedAddress!.isNotEmpty)
                                  ? _selectedAddress!
                                  : '${_selectedLocation!.latitude},${_selectedLocation!.longitude}';
                              final extra = <String, dynamic>{
                                'homeName': deviceNameController.text.trim(),
                                'address': address,
                              };
                              context.push(RouteName.roomAdd, extra: extra);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
