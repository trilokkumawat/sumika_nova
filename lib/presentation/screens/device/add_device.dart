import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/utils/customdropdown.dart';
import 'package:sumikanova/core/widget/customheader.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: [
          CustomHeader(title: 'Add Device', isAllowBack: true),
          Expanded(
            child: Column(
              children: [
                CustomDropdown<String>(
                  value: 'Living',
                  hint: 'Select room',
                  height: 52,
                  items: ['Living', 'Kitchen', 'Bedroom']
                      .map(
                        (e) =>
                            DropdownMenuItem<String>(value: e, child: Text(e)),
                      )
                      .toList(),
                  onChanged: (v) => print(v),
                  validator: (v) => v == null ? 'Select a room' : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
