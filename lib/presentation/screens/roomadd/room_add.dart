import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/utils/customheader.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/widget/appbutton.dart';
import 'package:sumikanova/core/widget/custom_iot_type.dart';
import 'package:sumikanova/core/widget/custom_switch.dart';
import 'package:sumikanova/core/widget/customback.dart';
import 'package:sumikanova/core/widget/sunsetcard.dart';

class RoomAddScreen extends StatefulWidget {
  const RoomAddScreen({super.key});

  @override
  State<RoomAddScreen> createState() => _RoomAddScreenState();
}

class _RoomAddScreenState extends State<RoomAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: <Widget>[
          CustomHeader(
            isAllowBack: true,
            title: 'Add Room',
            isSubmit: true,
            onSubmit: () {
              print('submit');
            },
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                spacing: 20,
                children: [
                  CustomTxtFormField(
                    hintText: 'Room Name',
                    labelText: 'Room Name',
                    hintColor: AppColor.black,

                    validator: (String? value) {
                      return null;
                    },
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
