import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/utils/custmdropdown2.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/devicecard.dart';
import 'package:sumikanova/core/widget/errorshow.dart';
import 'package:sumikanova/data/model/device/device_model.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController deviceNameController = TextEditingController();
  final List<Map<String, dynamic>> roomList = [
    {'id': '1', 'name': 'Living'},
    {'id': '2', 'name': 'Kitchen'},
    {'id': '3', 'name': 'Bedroom'},
    {'id': '4', 'name': 'Master'},
    {'id': '5', 'name': 'Study'},
  ];
  Map<String, dynamic>? selectedRoomId;
  String? selectedDeviceType;

  List<DeviceItem> _devices = [];
  bool _devicesLoading = false;
  String? _devicesError;

  Future<void> _loadDevices({String? roomId}) async {
    setState(() {
      _devicesLoading = true;
      _devicesError = null;
      _devices = [];
    });
    try {
      final response = await SumikiNovaApi.getDeviceCall.call();
      if (response.succeeded && response.jsonBody is Map<String, dynamic>) {
        final parsed = DeviceListResponse.fromJson(
          response.jsonBody as Map<String, dynamic>,
        );
        if (parsed.success) {
          if (mounted) {
            setState(() {
              _devices = parsed.data;
              _devicesLoading = false;
              _devicesError = null;
            });
          }
          return;
        }
      }
      if (mounted) {
        setState(() {
          _devicesLoading = false;
          _devicesError = 'Could not load devices.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _devicesLoading = false;
          _devicesError = 'Something went wrong. Please try again.';
        });
      }
    }
  }

  initState() {
    super.initState();
    _loadDevices();
  }

  @override
  void dispose() {
    deviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CustomHeader(
              title: 'Add Device',
              isAllowBack: true,
              isSubmit: true,
              submitIcon: const Icon(Icons.add, color: AppColor.white),
              onSubmit: () {
                if (formKey.currentState!.validate()) {
                  // TODO: Implement add device logic
                }
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    FormField<Map<String, dynamic>?>(
                      initialValue: selectedRoomId,
                      validator: (value) =>
                          value == null ? 'Please select a room' : null,
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PerfixTileDropdown<Map<String, dynamic>>(
                              hintText: 'Select room',
                              value: field.value,
                              options: roomList,
                              optionLabels: roomList
                                  .map((e) => e['name'] as String)
                                  .toList(),
                              safeSetSate: setState,
                              onChanged: (val) {
                                field.didChange(val);
                                setState(() {
                                  selectedRoomId = val;
                                  selectedDeviceType = null;
                                });
                                if (val != null) {
                                  _loadDevices(
                                    roomId:
                                        (val['id'] ?? val['location_id'] ?? '')
                                            .toString(),
                                  );
                                } else {
                                  setState(() {
                                    _devices = [];
                                    _devicesError = null;
                                  });
                                }
                              },
                            ),
                            if (field.hasError) ...[
                              const SizedBox(height: 4),
                              Text(
                                field.errorText!,
                                style: TypographyFont.uih7reg.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0x40C7C6C6,
                            ), // #C7C6C6 with 0x40 alpha
                            offset: const Offset(0, 2),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Scan",
                            style: TypographyFont.uih5reg.copyWith(
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (_devicesError != null)
                      CustomErrorShow(errorMessage: _devicesError!),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        const spacing = 12.0;
                        const crossAxisCount = 2;
                        if (_devicesLoading) {
                          return const SizedBox(
                            height: 120,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final cellSize =
                            (constraints.maxWidth - spacing) / crossAxisCount;
                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.0,
                                mainAxisSpacing: 12.0,
                                childAspectRatio: 1,
                              ),
                          itemCount: _devices.length,
                          itemBuilder: (context, index) {
                            final device = _devices[index];
                            final cardMap = device.toDeviceCardMap();
                            final isSelected =
                                selectedDeviceType == cardMap['id'];
                            return CustomDeviceCard(
                              device: cardMap,
                              cardwidth: cellSize,
                              cardheight: cellSize,
                              isSelected: isSelected,
                              onTap: () => setState(
                                () => selectedDeviceType = cardMap['id'],
                              ),
                            );
                          },
                        );
                      },
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
