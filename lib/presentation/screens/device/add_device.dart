import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/custmdropdown2.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/devicecard.dart';

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

  static const List<Map<String, String>> _deviceTypes = [
    {'id': 'light', 'label': 'Light 1', 'icon': 'assets/icons/light.png'},
    {'id': 'fan', 'label': 'Fan', 'icon': 'assets/icons/fan.png'},
    {'id': 'curtain', 'label': 'Curtain', 'icon': 'assets/icons/curtain.png'},
    {'id': 'ac', 'label': 'AC', 'icon': 'assets/icons/ac.png'},
  ];

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
                                setState(() => selectedRoomId = val);
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

                    LayoutBuilder(
                      builder: (context, constraints) {
                        const spacing = 12.0;
                        const crossAxisCount = 2;
                        final cardSize =
                            (constraints.maxWidth - spacing) / crossAxisCount;
                        return Wrap(
                          spacing: spacing,
                          runSpacing: spacing,
                          children: _deviceTypes.map((device) {
                            final isSelected =
                                selectedDeviceType == device['id'];
                            return CustomDeviceCard(
                              device: device,
                              cardSize: cardSize,
                              isSelected: isSelected,
                              onTap: () => setState(
                                () => selectedDeviceType = device['id'],
                              ),
                            );
                          }).toList(),
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
