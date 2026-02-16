import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/nicknamecard.dart';
import 'package:sumikanova/core/widget/profilemenuitem.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: [
          CustomHeader(title: 'Profile'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                spacing: 10,
                children: [
                  const NicknameCard(),
                  ProfileMenuCard(
                    items: [
                      ProfileMenuItem(
                        label: 'Home Management',
                        onTap: () {
                          context.push(RouteName.homeManagement);
                        },
                      ),
                      ProfileMenuItem(
                        label: 'Logout',
                        onTap: () async {
                          logout(context);
                        },
                      ),
                      ProfileMenuItem(
                        label: 'Help Center',
                        onTap: () {
                          print('Help Center');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
