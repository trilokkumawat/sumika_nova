import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/utils/date_helper.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/custom_iot_type.dart';
import 'package:sumikanova/core/widget/custom_switch.dart';
import 'package:sumikanova/core/widget/sunsetcard.dart';
import 'package:sumikanova/data/model/homelist/homelist_model.dart';
import 'package:sumikanova/data/model/locationlist/locationlist_model.dart';
import 'package:sumikanova/data/user/userinfo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onRegisterRefresh});

  final void Function(void Function() refresh)? onRegisterRefresh;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _homeList = [];
  int? _selectedHomeId;
  List<LocationItem> _locationList = [];
  bool _locationListLoading = false;
  int _selectedLocationIndex = 0;

  Future<String> _headerTitle() async {
    final user = await getUserInfo();
    return user?.name ?? '';
  }

  Future<void> _loadHomeList() async {
    final user = await getUserInfo();
    final userId = user?.id;
    if (userId == null || userId.isEmpty) return;

    final response = await SumikiNovaApi.getUserHomeListCall.call(
      userId: userId,
    );
    if (!mounted) return;
    if (!response.succeeded || response.jsonBody == null) return;

    try {
      final parsed = HomeListResponse.fromJson(
        response.jsonBody as Map<String, dynamic>,
      );
      final homes = parsed.data.homes;
      final list = homes
          .map<Map<String, dynamic>>((h) => {'id': h.id, 'name': h.name})
          .toList();
      setState(() {
        _homeList = list;
        _selectedHomeId = list.isNotEmpty ? list.first['id'] as int? : null;
      });
      if (_selectedHomeId != null) await _loadLocationList(_selectedHomeId!);
    } catch (_) {
      // Keep _homeList empty on parse error
    }
  }

  Future<void> _loadLocationList(int homeId) async {
    setState(() => _locationListLoading = true);
    final response = await SumikiNovaApi.getHomeByIdLocationCall.call(
      homeid: homeId.toString(),
    );
    if (!mounted) return;
    if (!response.succeeded || response.jsonBody == null) {
      setState(() {
        _locationList = [];
        _locationListLoading = false;
      });
      return;
    }
    try {
      final parsed = LocationListResponse.fromJson(
        response.jsonBody as Map<String, dynamic>,
      );
      setState(() {
        _locationList = parsed.data.locations;

        _locationListLoading = false;
        _selectedLocationIndex = 0;
      });
    } catch (_) {
      setState(() {
        _locationList = [];
        _locationListLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadHomeList();
    widget.onRegisterRefresh?.call(_loadHomeList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: <Widget>[
          FutureBuilder<String>(
            future: _headerTitle(),
            builder: (context, snapshot) {
              return CustomHeader(
                title: snapshot.data ?? '',
                isPopupmenu: true,
                homeOptions: _homeList,
                selectedHomeId: _selectedHomeId,
                onHomeChanged: (id) {
                  setState(() => _selectedHomeId = id);
                  if (id != null) _loadLocationList(id);
                },
              );
            },
          ),

          Expanded(
            child: Column(
              spacing: 20,
              children: [
                SizedBox(height: 0),
                SunsetCard(
                  temperature: DateHelper().tempratureFormat(20),
                  dateLabel: DateHelper().formatFullDate(),
                ),
                Visibility(
                  visible: _locationList.isNotEmpty,
                  child: SizedBox(
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _locationList.length + 1,
                      itemBuilder: (context, index) {
                        final label = index == 0
                            ? 'All Device'
                            : _locationList[index - 1].name;
                        final isSelected = index == _selectedLocationIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedLocationIndex = index);
                          },
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
                            // SnakBarUtils.showSnakBar(
                            //   context,
                            //   'Add Device feature is coming soon',
                            // );
                            context.push(RouteName.addDevice);
                          },
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                        // AppButton(
                        //   text: 'Create Room',
                        //   onPressed: () {
                        //     context.push(RouteName.roomAdd);
                        //   },
                        //   width: MediaQuery.of(context).size.width * 0.6,
                        // ),
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
