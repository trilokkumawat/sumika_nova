import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/utils/customheader.dart';
import 'package:sumikanova/core/widget/activitycard.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<Map<String, dynamic>> activityData = [
    {
      'id': 1,
      'location': 'Bedroom',
      'device': 'Fan',
      'status': true,
      'timeAgo': '5 min ago',
    },
    {
      'id': 2,
      'location': 'Drawing Room',
      'device': 'TV',
      'status': false,
      'timeAgo': '10 min ago',
    },
    {
      'id': 3,
      'location': 'Lobby',
      'device': 'Fan',
      'status': true,
      'timeAgo': '15 min ago',
    },
    {
      'id': 4,
      'location': 'Study Room',
      'device': 'Light',
      'status': true,
      'timeAgo': '20 min ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: [
          CustomHeader(title: 'Activity'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: activityData.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final data = activityData[index];
                  return CustomActivityCard(
                    location: data['location'] as String,
                    device: data['device'] as String,
                    isStatus: data['status'] as bool,
                    timeAgo: data['timeAgo'] as String,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
