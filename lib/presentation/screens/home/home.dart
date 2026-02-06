import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/widget/customback.dart';

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
      body: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: SizedBox(
              width: double.infinity,
              height: appBarHeight,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(color: AppColor.primary),
                  Positioned.fill(
                    child: Transform.rotate(
                      angle: 3.141592653589793, // 180 degrees in radians
                      child: Image.asset(
                        'assets/icons/btmbg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: CustomBack(
                      isAllowBack: false,
                      isPopupmenu: true,
                      title: 'Thomas Home',
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      onPopupMenuItemTap: (int index) {
                        print(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expanded(child: Container(child: Text("data"))),
        ],
      ),
    );
  }
}
