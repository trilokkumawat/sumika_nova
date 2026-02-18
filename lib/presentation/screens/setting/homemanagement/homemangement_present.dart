import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/data/model/homelist/homelist_model.dart';
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
  late Future<ApiCallResponse> _homeListFuture;

  @override
  void initState() {
    super.initState();
    _homeListFuture = _fetchUserHomeList();
  }

  Future<void> _refreshHomeList() async {
    setState(() {
      _homeListFuture = _fetchUserHomeList();
    });
    await _homeListFuture;
  }

  @override
  void dispose() {
    deviceNameController.dispose();
    super.dispose();
  }

  Future<ApiCallResponse> _fetchUserHomeList() async {
    final userData = await SecureAuthStorage.getUserData();
    final userId = userData?['id']?.toString();
    print('userId: $userId');
    final response = await SumikiNovaApi.getUserHomeListCall.call(
      userId: userId ?? '',
    );
    print('UserHomeList response: ${response.jsonBody}');
    return response;
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
                    child: RefreshIndicator(
                      onRefresh: _refreshHomeList,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                        child: Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FutureBuilder<ApiCallResponse>(
                              future: _homeListFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    alignment: Alignment.center,
                                    child: const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      'Failed to load homes: ${snapshot.error}',
                                      style: TypographyFont.uih5reg.copyWith(
                                        color: AppColor.red,
                                      ),
                                    ),
                                  );
                                }
                                final response = snapshot.data!;
                                if (!response.succeeded) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      response.exceptionMessage.isNotEmpty
                                          ? response.exceptionMessage
                                          : 'Failed to load homes',
                                      style: TypographyFont.uih5reg.copyWith(
                                        color: AppColor.red,
                                      ),
                                    ),
                                  );
                                }
                                HomeListResponse? homeList;
                                try {
                                  final body = response.jsonBody;
                                  final map = body is Map<String, dynamic>
                                      ? body
                                      : (body is Map
                                            ? Map<String, dynamic>.from(body)
                                            : null);
                                  if (map != null) {
                                    homeList = HomeListResponse.fromJson(map);
                                  }
                                } catch (_) {}
                                final homes =
                                    homeList?.data.homes ?? <HomeItem>[];
                                if (homes.isEmpty) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.gray4.withOpacity(
                                            0.15,
                                          ),
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'No homes yet',
                                      style: TypographyFont.uih5reg.copyWith(
                                        color: AppColor.gray4,
                                      ),
                                    ),
                                  );
                                }
                                return Column(
                                  spacing: 12,
                                  children: homes
                                      .map<Widget>(
                                        (home) => _HomeListTile(
                                          home: home,
                                          onTap: () async {
                                            await context.push(
                                              RouteName.homeSettings,
                                              extra: home,
                                            );
                                            if (context.mounted) {
                                              _refreshHomeList();
                                            }
                                          },
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.gray4.withOpacity(0.15),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () async {
                                    await context.push(
                                      RouteName.homeManagement,
                                    );
                                    if (context.mounted) {
                                      _refreshHomeList();
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Create a Home',
                                          style: TypographyFont.uih5bold
                                              .copyWith(
                                                color: AppColor.primary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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

class _HomeListTile extends StatelessWidget {
  const _HomeListTile({required this.home, required this.onTap});

  final HomeItem home;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColor.gray4.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  home.name.toUpperCase(),
                  style: TypographyFont.uih5reg.copyWith(color: AppColor.gray4),
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
    );
  }
}
