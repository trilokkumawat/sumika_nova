import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/data/model/homelist/homelist_model.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/home_management_provider.dart';

class HomeManagementParentScreen extends ConsumerStatefulWidget {
  const HomeManagementParentScreen({super.key});

  @override
  ConsumerState<HomeManagementParentScreen> createState() =>
      _HomeManagementParentScreenState();
}

class _HomeManagementParentScreenState
    extends ConsumerState<HomeManagementParentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeManagementProvider.notifier).loadHomes();
    });
  }

  Future<void> _refreshHomeList() async {
    await ref.read(homeManagementProvider.notifier).loadHomes();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeManagementProvider);
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
        child: Stack(
          children: [
            Column(
              children: [
                CustomHeader(title: 'Home Management', isAllowBack: true),
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
                          if (state.homesLoading)
                            Container(
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              child: const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          else if (state.homesError != null)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                state.homesError!,
                                style: TypographyFont.uih5reg.copyWith(
                                  color: AppColor.red,
                                ),
                              ),
                            )
                          else if (state.homes.isEmpty)
                            Container(
                              padding: const EdgeInsets.all(16),
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
                              child: Text(
                                'No homes yet',
                                style: TypographyFont.uih5reg.copyWith(
                                  color: AppColor.gray4,
                                ),
                              ),
                            )
                          else
                            Column(
                              spacing: 12,
                              children: state.homes
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
                                  await context.push(RouteName.homeManagement);
                                  if (context.mounted) {
                                    await _refreshHomeList();
                                  }
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
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final userData =
                                  await SecureAuthStorage.getUserData();
                              final userId = userData?['id']?.toString();
                              debugPrint(userId);
                            },
                            child: Text('Create a Home'),
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
