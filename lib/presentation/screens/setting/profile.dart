import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/navigation/route_name.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/secure_auth_storage.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/utils/snakbar.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/nicknamecard.dart';
import 'package:sumikanova/core/widget/profilemenuitem.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await SecureAuthStorage.getUserData();
    if (!mounted) return;
    setState(() {
      _userName = userData?['name'] as String?;
    });
  }

  Future<void> _showEditNicknameBottomSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditNameBottomSheet(
        initialName: _userName ?? '',
        onSaved: (newName) {
          setState(() => _userName = newName);
        },
      ),
    );
  }

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
                  NicknameCard(
                    displayName: _userName,
                    onTap: _showEditNicknameBottomSheet,
                  ),
                  ProfileMenuCard(
                    items: [
                      ProfileMenuItem(
                        label: 'Home Management',
                        onTap: () {
                          // context.push(RouteName.homeManagement);
                          //
                          context.push(RouteName.homeManagementParent);
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

class _EditNameBottomSheet extends StatefulWidget {
  const _EditNameBottomSheet({
    required this.initialName,
    required this.onSaved,
  });

  final String initialName;
  final void Function(String newName) onSaved;

  @override
  State<_EditNameBottomSheet> createState() => _EditNameBottomSheetState();
}

class _EditNameBottomSheetState extends State<_EditNameBottomSheet> {
  late final TextEditingController _controller;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      SnakBarUtils.showSnakBar(context, 'Please enter a name');
      return;
    }
    setState(() => _saving = true);
    final response = await SumikiNovaApi.editProfileCall.call(name: name);
    if (!mounted) return;
    setState(() => _saving = false);
    if (!response.succeeded) {
      SnakBarUtils.showSnakBar(
        context,
        response.exceptionMessage.isNotEmpty
            ? response.exceptionMessage
            : 'Failed to update name',
      );
      return;
    }
    final userData = await SecureAuthStorage.getUserData();
    if (userData != null) {
      userData['name'] = name;
      await SecureAuthStorage.saveUserData(userData);
    }
    widget.onSaved(name);
    if (!mounted) return;
    Navigator.of(context).pop();
    SnakBarUtils.showSnakBar(context, 'Name updated successfully');
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Edit name',
            style: TypographyFont.uih4bold.copyWith(color: AppColor.black),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter your name',
              hintStyle: TypographyFont.uih5reg.copyWith(color: AppColor.gray4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            style: TypographyFont.uih5med.copyWith(color: AppColor.black),
            textCapitalization: TextCapitalization.words,
            enabled: !_saving,
          ),
          const SizedBox(height: 20),
          AppButton(
            text: _saving ? 'Saving...' : 'Save',
            onPressed: _saving ? null : _save,
          ),
        ],
      ),
    );
  }
}
