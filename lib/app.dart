import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/presentation/screens/home/home.dart';
import 'package:sumikanova/presentation/screens/setting/profile.dart';

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  int _currentIndex = 0;
  VoidCallback? _refreshHome;

  List<Widget> get _screens => <Widget>[
    HomeScreen(onRegisterRefresh: (cb) => _refreshHome = cb),
    const SceneScreen(),
    const ActivityScreen(),
    const ProfileScreen(),
  ];

  static const List<_NavItem> _navItems = <_NavItem>[
    _NavItem(iconPath: 'assets/icons/home.png', label: 'Home'),
    _NavItem(iconPath: 'assets/icons/scene.png', label: 'Scene'),
    _NavItem(iconPath: 'assets/icons/activity.png', label: 'Activity'),
    _NavItem(iconPath: 'assets/icons/profile.png', label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: MediaQuery.sizeOf(context).width / 20,
        ),
        decoration: const BoxDecoration(
          color: AppColor.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColor.gray2,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List<Widget>.generate(
            _navItems.length,
            (int index) => Expanded(
              child: _CustomNavTile(
                iconPath: _navItems[index].iconPath,
                label: _navItems[index].label,
                isSelected: _currentIndex == index,
                onTap: () {
                  setState(() => _currentIndex = index);
                  if (index == 0) _refreshHome?.call();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.iconPath, required this.label});
  final String iconPath;
  final String label;
}

class _CustomNavTile extends StatelessWidget {
  const _CustomNavTile({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? AppColor.white : AppColor.black;
    final TextStyle textStyle = isSelected
        ? TypographyFont.uih7semimed.copyWith(color: color)
        : TypographyFont.uih7med.copyWith(color: color);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.bgbuttoncolor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                iconPath,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                color: color,
              ),
              Text(label, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}

class SceneScreen extends StatelessWidget {
  const SceneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Scene'));
  }
}

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Activity'));
  }
}

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text('Profile'));
//   }
// }
