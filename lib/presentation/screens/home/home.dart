import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/utils/date_helper.dart';
import 'package:sumikanova/core/widget/custom_iot_type.dart';
import 'package:sumikanova/core/widget/custom_switch.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/sunsetcard.dart';
import 'package:sumikanova/presentation/screens/home/home_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.onRegisterRefresh});

  final void Function(void Function() refresh)? onRegisterRefresh;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(homeProvider.notifier).loadHomeList();
    widget.onRegisterRefresh?.call(() {
      ref.read(homeProvider.notifier).loadHomeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final controller = ref.read(homeProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: <Widget>[
          CustomHeader(
            title: state.headerTitle ?? '',
            isPopupmenu: true,
            homeOptions: state.homeList.isEmpty ? null : state.homeList,
            selectedHomeId: state.selectedHomeId,
            onHomeChanged: (id) => controller.setSelectedHome(id),
          ),
          Expanded(
            child: Column(
              spacing: 20,
              children: [
                const SizedBox(height: 0),
                SunsetCard(
                  temperature: DateHelper().tempratureFormat(20),
                  dateLabel: DateHelper().formatFullDate(),
                ),
                Visibility(
                  visible: state.locationList.isNotEmpty,
                  child: SizedBox(
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.locationList.length + 1,
                      itemBuilder: (context, index) {
                        final label = index == 0
                            ? 'All Device'
                            : state.locationList[index - 1].name;
                        final isSelected = index == state.selectedLocationIndex;
                        return GestureDetector(
                          onTap: () =>
                              controller.setSelectedLocationIndex(index),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              label,
                              style: TypographyFont.uih5bold.copyWith(
                                color: isSelected
                                    ? AppColor.black
                                    : AppColor.gray4,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     context.push(RouteName.deviceDetails);
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 16),
                //     child: Container(
                //       padding: const EdgeInsets.only(left: 16, right: 5),
                //       decoration: BoxDecoration(
                //         color: AppColor.white,
                //         borderRadius: BorderRadius.circular(10),
                //         boxShadow: [
                //           BoxShadow(
                //             color: AppColor.gray3.withValues(alpha: 0.3),
                //             blurRadius: 20,
                //             offset: const Offset(0, 10),
                //           ),
                //         ],
                //       ),
                //       child: Row(
                //         children: [
                //           Column(
                //             mainAxisSize: MainAxisSize.min,
                //             spacing: 4,
                //             children: [
                //               Image.asset('assets/icons/kitchen.png'),
                //               Text(
                //                 'Kitchen',
                //                 style: TextStyle(color: AppColor.black),
                //               ),
                //             ],
                //           ),
                //           const Spacer(),
                //           CustomIotType(
                //             icon: Icons.lightbulb_outline,
                //             label: '04',
                //             index: 0,
                //           ),
                //           CustomIotType(icon: Icons.air, label: '00', index: 1),
                //           CustomIotType(
                //             icon: Icons.vertical_split,
                //             label: '00',
                //             index: 2,
                //           ),
                //           CustomIotType(
                //             icon: Icons.ac_unit,
                //             label: '00',
                //             index: 3,
                //           ),
                //           const SizedBox(width: 5),
                //           CustomSwitch(
                //             height: MediaQuery.of(context).size.height * 0.06,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Column(
                  spacing: 20,
                  children: [
                    Image.asset('assets/icons/empty.png'),
                    Column(
                      spacing: 10,
                      children: [
                        AppButton(
                          text: 'Add Device',
                          onPressed: () {
                            context.push(RouteName.addDevice);
                          },
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
