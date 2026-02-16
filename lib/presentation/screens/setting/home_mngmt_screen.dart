import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/custmdropdown2.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/devicecard.dart';

class HomeManagementScreen extends StatefulWidget {
  const HomeManagementScreen({super.key});

  @override
  State<HomeManagementScreen> createState() => _HomeManagementScreenState();
}

class _HomeManagementScreenState extends State<HomeManagementScreen> {
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
          child: Column(
            children: [
              CustomHeader(
                title: 'Create Home',
                isAllowBack: true,
                isSubmit: true,
                submitIcon: const Icon(Icons.check, color: AppColor.white),
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
                      CustomTxtFormField(
                        hintColor: AppColor.black,
                        controller: deviceNameController,
                        hintText: 'Home Name',
                        labelText: 'Home Name',
                        validator: (value) {
                          return validationEmpty(value, 'Enter home name');
                        },
                      ),
                      InkWell(
                        onTap: () {
                          context.push(RouteName.mapView);
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Set Location",
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

                      GridView.builder(
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
                        itemCount: _deviceTypes.length,
                        itemBuilder: (context, index) {
                          final device = _deviceTypes[index];
                          final isSelected = selectedDeviceType == device['id'];
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
        ),
      ),
    );
  }
}
