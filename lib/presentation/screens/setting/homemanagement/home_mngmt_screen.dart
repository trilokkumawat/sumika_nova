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
import 'package:sumikanova/presentation/screens/setting/homemanagement/home_mngmt_provider.dart';

class HomeManagementScreen extends ConsumerStatefulWidget {
  const HomeManagementScreen({super.key});

  @override
  ConsumerState<HomeManagementScreen> createState() =>
      _HomeManagementScreenState();
}

class _HomeManagementScreenState extends ConsumerState<HomeManagementScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController deviceNameController = TextEditingController();
  Map<String, dynamic>? selectedRoomId;
  String? selectedDeviceType;
  LatLng? _selectedLocation;
  bool _roomsLoadTriggered = false;

  @override
  void dispose() {
    deviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeMngmtState = ref.watch(homeMngmtProvider);
    final homeMngmtController = ref.read(homeMngmtProvider.notifier);
    if (!_roomsLoadTriggered) {
      _roomsLoadTriggered = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        homeMngmtController.loadRooms();
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
                          if (homeMngmtState.error != null)
                            CustomErrorShow(
                              errorMessage: homeMngmtState.error!,
                            ),
                          if (homeMngmtState.roomsError != null)
                            CustomErrorShow(
                              errorMessage: homeMngmtState.roomsError!,
                            ),
                          InkWell(
                            onTap: () async {
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
                                  Text(
                                    _selectedLocation != null
                                        ? 'Location set (${_selectedLocation!.latitude.toStringAsFixed(4)}, ${_selectedLocation!.longitude.toStringAsFixed(4)})'
                                        : 'Set Location',
                                    style: TypographyFont.uih5med.copyWith(
                                      color: AppColor.black,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColor.gray4,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          homeMngmtState.roomsLoading
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
                                  itemCount: homeMngmtState.rooms.length,
                                  itemBuilder: (context, index) {
                                    final room = homeMngmtState.rooms[index];
                                    final device = room.toDeviceCardMap();
                                    final isSelected =
                                        selectedDeviceType == device['id'];
                                    return CustomDeviceCard(
                                      device: device,
                                      cardwidth: 150.0,
                                      cardheight: 150.0,
                                      isSelected: isSelected,
                                      onTap: () => setState(
                                        () => selectedDeviceType = device['id'],
                                      ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: AppButton(
                      borderRadius: 16,
                      text: 'Add More',
                      onPressed: homeMngmtState.isLoading
                          ? null
                          : () async {
                              if (!formKey.currentState!.validate()) return;
                              if (_selectedLocation == null) {
                                SnakBarUtils.showSnakBar(
                                  context,
                                  'Please set location',
                                );
                                return;
                              }
                              final success = await homeMngmtController
                                  .createHome(
                                    name: deviceNameController.text.trim(),
                                  );
                              if (!mounted) return;
                              if (success) {
                                final msg = ref.read(homeMngmtProvider).message;
                                SnakBarUtils.showSnakBar(
                                  context,
                                  msg ?? 'Home saved successfully',
                                );
                                context.pop();
                              }
                            },
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
