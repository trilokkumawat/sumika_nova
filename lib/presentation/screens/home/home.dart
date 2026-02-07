import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/custom_iot_type.dart';
import 'package:sumikanova/core/widget/custom_switch.dart';
import 'package:sumikanova/core/widget/customback.dart';
import 'package:sumikanova/core/widget/sunsetcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double appBarHeight = MediaQuery.sizeOf(context).height / 7.3;
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: <Widget>[
          CustomHeader(title: 'Thomes Home'),
          Expanded(
            child: Column(
              spacing: 20,
              children: [
                SizedBox(height: 0),
                SunsetCard(temperature: 20, dateLabel: 'Tuesday, 23 December'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 5),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.gray3.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 4,
                          children: [
                            Image.asset('assets/icons/kitchen.png'),
                            Text(
                              'Kitchen',
                              style: TextStyle(color: AppColor.black),
                            ),
                          ],
                        ),
                        const Spacer(),
                        CustomIotType(
                          icon: Icons.lightbulb_outline,
                          label: '04',
                          index: 0,
                        ),
                        CustomIotType(icon: Icons.air, label: '00', index: 1),
                        CustomIotType(
                          icon: Icons.vertical_split,
                          label: '00',
                          index: 2,
                        ),
                        CustomIotType(
                          icon: Icons.ac_unit,
                          label: '00',
                          index: 3,
                        ),
                        const SizedBox(width: 5),
                        CustomSwitch(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  spacing: 20,
                  children: [
                    Image.asset('assets/icons/empty.png'),
                    Column(
                      spacing: 10,
                      children: [
                        AppButton(
                          text: 'Add Device',
                          onPressed: () {},
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                        AppButton(
                          text: 'Create Room',
                          onPressed: () {
                            context.push(RouteName.roomAdd);
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
