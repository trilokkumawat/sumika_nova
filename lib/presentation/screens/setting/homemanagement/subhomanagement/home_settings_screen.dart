import 'package:flutter/material.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/data/model/homelist/homelist_model.dart';
import 'package:sumikanova/data/model/locationlist/locationlist_model.dart';

/// Home Settings screen: home header + room list.
/// Modern UI with section cards and clear hierarchy.
class HomeSettingsScreen extends StatefulWidget {
  const HomeSettingsScreen({super.key, required this.home});

  final HomeItem home;

  @override
  State<HomeSettingsScreen> createState() => _HomeSettingsScreenState();
}

class _HomeSettingsScreenState extends State<HomeSettingsScreen> {
  late Future<List<LocationItem>> _locationListFuture;

  @override
  void initState() {
    super.initState();
    _locationListFuture = _fetchLocationsByHomeId(widget.home.id);
  }

  Future<List<LocationItem>> _fetchLocationsByHomeId(int homeId) async {
    final response = await SumikiNovaApi.getHomeByIdLocationCall.call(
      homeid: homeId.toString(),
    );
    if (!response.succeeded) return [];
    try {
      final body = response.jsonBody;
      final map = body is Map<String, dynamic>
          ? body
          : (body is Map ? Map<String, dynamic>.from(body) : null);
      if (map == null) return [];
      final locationList = LocationListResponse.fromJson(map);
      return locationList.data.locations;
    } catch (_) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(title: 'Home Settings', isAllowBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HomeHeaderCard(homeName: widget.home.name),
                  const SizedBox(height: 24),
                  FutureBuilder<List<LocationItem>>(
                    future: _locationListFuture,
                    builder: (context, locSnapshot) {
                      if (locSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return _LoadingSection();
                      }
                      if (locSnapshot.hasError) {
                        return _ErrorSection(
                          message: 'Couldn’t load rooms. ${locSnapshot.error}',
                        );
                      }
                      final rooms = locSnapshot.data ?? [];
                      if (rooms.isEmpty) {
                        return _EmptyRoomsSection();
                      }
                      return _RoomsSection(rooms: rooms);
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

/// Hero card for the current home name.
class _HomeHeaderCard extends StatelessWidget {
  const _HomeHeaderCard({required this.homeName});

  final String homeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.home_rounded,
              color: AppColor.primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home',
                  style: TypographyFont.uih7reg.copyWith(
                    color: AppColor.gray5,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  homeName,
                  style: TypographyFont.uih3bold.copyWith(
                    color: AppColor.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Section title + list of room tiles.
class _RoomsSection extends StatelessWidget {
  const _RoomsSection({required this.rooms});

  final List<LocationItem> rooms;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.gray4.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Text(
                  rooms.length > 1 ? 'Rooms' : 'Room',
                  style: TypographyFont.uih5bold.copyWith(
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${rooms.length}',
                    style: TypographyFont.uih7med.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...rooms.asMap().entries.map((e) {
            final isLast = e.key == rooms.length - 1;
            return Column(
              children: [
                _RoomListTile(location: e.value),
                if (!isLast)
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: 76,
                    endIndent: 20,
                    color: AppColor.gray1,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _RoomListTile extends StatelessWidget {
  const _RoomListTile({required this.location});

  final LocationItem location;

  @override
  Widget build(BuildContext context) {
    final imageUrl = location.locationList.imageUrl;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              _RoomIcon(imageUrl: imageUrl),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  location.name,
                  style: TypographyFont.uih5med.copyWith(color: AppColor.black),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColor.gray4,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoomIcon extends StatelessWidget {
  const _RoomIcon({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColor.gray1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.door_front_door_rounded,
        color: AppColor.gray4,
        size: 22,
      ),
    );
    if (imageUrl.isEmpty) return placeholder;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        width: 44,
        height: 44,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => placeholder,
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.gray4.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      ),
    );
  }
}

class _ErrorSection extends StatelessWidget {
  const _ErrorSection({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.gray4.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline_rounded, color: AppColor.red, size: 40),
          const SizedBox(height: 12),
          Text(
            message,
            style: TypographyFont.uih5reg.copyWith(color: AppColor.gray6),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _EmptyRoomsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.gray4.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.meeting_room_rounded, color: AppColor.gray3, size: 40),
          const SizedBox(height: 12),
          Text(
            'No rooms yet',
            style: TypographyFont.uih5reg.copyWith(color: AppColor.gray5),
          ),
        ],
      ),
    );
  }
}
