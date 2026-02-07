import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/customheader.dart';
import 'package:sumikanova/core/utils/customtxtformfield.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/utils/snakbar.dart';

class RoomAddScreen extends StatefulWidget {
  const RoomAddScreen({super.key});

  @override
  State<RoomAddScreen> createState() => _RoomAddScreenState();
}

class _RoomAddScreenState extends State<RoomAddScreen> {
  final TextEditingController roomNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> roomList = [
    {'id': 1, 'name': 'Living'},
    {'id': 2, 'name': 'Master'},
    {'id': 3, 'name': 'Second'},
    {'id': 4, 'name': 'Dinning'},
    {'id': 5, 'name': 'Kitchen'},
    {'id': 6, 'name': 'Study'},
    {'id': 7, 'name': 'Porch'},
    {'id': 8, 'name': 'Balcony'},
    {'id': 9, 'name': 'Kids'},
    {'id': 10, 'name': 'Closet'},
    {'id': 11, 'name': 'Master Bedroom'},
  ];

  @override
  void dispose() {
    roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.white2,
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            CustomHeader(
              isAllowBack: true,
              title: 'Add Room',
              isSubmit: true,
              onSubmit: () {
                final isValid = formKey.currentState!.validate();
                if (isValid) {
                  SnakBarUtils.showSnakBar(context, 'Room added successfully');
                }
              },
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  spacing: 20,
                  children: [
                    CustomTxtFormField(
                      controller: roomNameController,
                      hintText: 'Room Name',
                      labelText: 'Room Name',
                      hintColor: AppColor.black,

                      validator: (String? value) {
                        return validationEmpty(value, 'Enter room name');
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Recommend',
                          style: TypographyFont.uih5med.copyWith(
                            color: AppColor.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: roomList.map<Widget>((
                        Map<String, dynamic> room,
                      ) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x40C7C6C6),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Text(
                            room['name'] as String,
                            style: TypographyFont.uih6reg.copyWith(
                              color: AppColor.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
