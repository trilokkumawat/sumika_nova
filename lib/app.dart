import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/utils/img_colorfilter.dart';
import 'package:sumikanova/presentation/screens/home/home.dart';
import 'package:sumikanova/presentation/screens/setting/profile.dart';

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<Widget> _screens;
  VoidCallback? _refreshHome;

  static const List<_NavItem> _navItems = <_NavItem>[
    _NavItem(iconPath: 'assets/icons/home.png', label: 'Home'),
    _NavItem(iconPath: 'assets/icons/scene.png', label: 'Scene'),
    _NavItem(iconPath: 'assets/icons/activity.png', label: 'Activity'),
    _NavItem(iconPath: 'assets/icons/profile.png', label: 'Profile'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _navItems.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _screens = <Widget>[
      HomeScreen(onRegisterRefresh: (cb) => _refreshHome = cb),
      const SceneScreen(),
      const ActivityScreen(),
      const ProfileScreen(),
    ];
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    if (_tabController.index == 0) {
      _refreshHome?.call();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: _tabController, children: _screens),
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
                isSelected: _tabController.index == index,
                onTap: () {
                  _tabController.animateTo(index);
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
              ImageColorFilterGress(
                child: Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  color: color,
                ),
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
