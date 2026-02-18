import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/utils/snakbar.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/devicecard.dart';
import 'package:sumikanova/core/widget/errorshow.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/subhomanagement/home_mngmt_provider.dart';

class HomeManagementParentScreen extends ConsumerStatefulWidget {
  const HomeManagementParentScreen({super.key});

  @override
  ConsumerState<HomeManagementParentScreen> createState() =>
      _HomeManagementParentScreenState();
}

class _HomeManagementParentScreenState
    extends ConsumerState<HomeManagementParentScreen> {
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
                  CustomHeader(
                    title: 'Home Management',
                    isAllowBack: true,
                    isSubmit: true,
                    onSubmit: () async {},
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Material(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'My Home',
                                      style: TypographyFont.uih5bold.copyWith(
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
                          ),
                          Material(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                context.push(RouteName.homeManagement);
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Create a Home',
                                      style: TypographyFont.uih5bold.copyWith(
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     final userData =
                          //         await SecureAuthStorage.getUserData();
                          //     final userId = userData?['id']?.toString();
                          //     print(userId);
                          //   },
                          //   child: Text("data"),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
