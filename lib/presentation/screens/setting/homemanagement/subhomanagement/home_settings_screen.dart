import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';
import 'package:sumikanova/core/services/api_config.dart';
import 'package:sumikanova/core/services/api_name.dart';
import 'package:sumikanova/core/utils/fluttermap.dart';
import 'package:sumikanova/core/utils/inkwell_effect.dart';
import 'package:sumikanova/core/utils/reusablemethod.dart';
import 'package:sumikanova/core/widget/customheader.dart';
import 'package:sumikanova/data/model/homelist/homelist_model.dart';
import 'package:sumikanova/data/model/locationlist/locationlist_model.dart';
import 'package:sumikanova/presentation/screens/setting/homemanagement/home_management_provider.dart';

/// Home Settings screen: home header + room list.
/// Uses [homeManagementProvider] for state; loads locations via controller.
class HomeSettingsScreen extends ConsumerStatefulWidget {
  const HomeSettingsScreen({super.key, required this.home});

  final HomeItem home;

  @override
  ConsumerState<HomeSettingsScreen> createState() => _HomeSettingsScreenState();
}

class _HomeSettingsScreenState extends ConsumerState<HomeSettingsScreen> {
  late String _displayName;
  late String _displayAddress;

  @override
  void initState() {
    super.initState();
    _displayName = widget.home.name;
    _displayAddress = widget.home.address;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(homeManagementProvider.notifier);
      notifier.loadLocationsForHome(widget.home.id);
      notifier.loadRooms();
    });
  }

  Future<void> _updateHome(BuildContext context) async {
    final nameController = TextEditingController(text: _displayName);
    final addressController = TextEditingController(text: _displayAddress);
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Home'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Home Name',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () async {
                    final mapResult =
                        await Navigator.push<Map<String, dynamic>>(
                          ctx,
                          MaterialPageRoute<Map<String, dynamic>>(
                            builder: (_) => const MapViewScreen(),
                          ),
                        );
                    if (mapResult != null && mapResult['address'] != null) {
                      addressController.text = mapResult['address'] as String;
                      setDialogState(() {});
                    }
                  },
                  icon: const Icon(Icons.location_on_outlined, size: 20),
                  label: const Text('Pick address on map'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop({
                'name': nameController.text.trim(),
                'address': addressController.text.trim(),
              }),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (result == null || !context.mounted) return;
    final name = result['name'] ?? _displayName;
    final address = result['address'] ?? _displayAddress;
    final response = await SumikiNovaApi.updateHomeCall.call(
      homeId: widget.home.id.toString(),
      name: name,
      address: address,
      isActive: widget.home.isActive,
    );
    if (!context.mounted) return;
    if (response.succeeded) {
      setState(() {
        _displayName = name;
        _displayAddress = address;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Home updated successfully')),
        );
      }
    } else {
      final message = _errorMessage(response, 'Failed to update home.');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _deleteHome(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Home'),
        content: RichText(
          text: TextSpan(
            text: 'Are you sure you want to delete ',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.black),
            children: [
              TextSpan(
                text: '"${widget.home.name.titleCase()}"',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const TextSpan(text: '?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColor.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    final response = await SumikiNovaApi.deleteCall.call(
      endpoint: ApiName.deletehome,
      id: widget.home.id.toString(),
    );
    if (!context.mounted) return;
    if (response.succeeded) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Home deleted successfully')),
        );
        context.pop();
      }
    } else {
      final message = _errorMessage(response, 'Failed to delete home.');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _updateRoom(BuildContext context, LocationItem location) async {
    final state = ref.read(homeManagementProvider);
    final nameController = TextEditingController(text: location.name);
    final roomOptions = state.rooms;
    final optionIds = roomOptions
        .map((r) => int.tryParse(r.id))
        .whereType<int>()
        .toList();
    int selectedLocationListId = location.locationListId;
    if (optionIds.isNotEmpty && !optionIds.contains(selectedLocationListId)) {
      selectedLocationListId = optionIds.first;
    }
    int isActive = location.isActive;
    String? pickedImagePath;
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: const Text('Edit Room'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Room Name',
                      border: OutlineInputBorder(),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 16),
                  if (roomOptions.isNotEmpty)
                    DropdownButtonFormField<int>(
                      value: optionIds.contains(selectedLocationListId)
                          ? selectedLocationListId
                          : optionIds.first,
                      decoration: const InputDecoration(
                        labelText: 'Room Type',
                        border: OutlineInputBorder(),
                      ),
                      items: roomOptions
                          .where((r) => int.tryParse(r.id) != null)
                          .map(
                            (r) => DropdownMenuItem<int>(
                              value: int.parse(r.id),
                              child: Text(r.name),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          setDialogState(() => selectedLocationListId = v);
                        }
                      },
                    ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    value: isActive,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Active')),
                      DropdownMenuItem(value: 0, child: Text('Inactive')),
                    ],
                    onChanged: (v) {
                      if (v != null) {
                        setDialogState(() => isActive = v);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  _RoomEditImageSection(
                    location: location,
                    pickedImagePath: pickedImagePath,
                    onPickImage: () async {
                      final picker = ImagePicker();
                      final xFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 800,
                        imageQuality: 85,
                      );
                      if (xFile != null) {
                        pickedImagePath = xFile.path;
                        setDialogState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop({
                  'name': nameController.text.trim(),
                  'location_list_id': selectedLocationListId.toString(),
                  'is_active': isActive.toString(),
                  'photo_path': pickedImagePath,
                }),
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
    if (result == null || !context.mounted) return;
    final name = result['name'] as String? ?? location.name;
    final locationListId =
        result['location_list_id'] as String? ??
        location.locationListId.toString();
    final isActiveStr =
        result['is_active'] as String? ?? location.isActive.toString();
    final photoPath = result['photo_path'] as String?;

    print('photoPath: $photoPath');
    print('location.id: ${location.id}');
    print('name: $name');
    print('isActiveStr: $isActiveStr');
    print('locationListId: $locationListId');

    final response = await SumikiNovaApi.updateLocationCall.call(
      locationId: location.id.toString(),
      name: name,
      isActive: isActiveStr,
      locationListId: locationListId,
      photoFilePath: photoPath,
    );
    if (!context.mounted) return;
    if (response.succeeded) {
      ref
          .read(homeManagementProvider.notifier)
          .loadLocationsForHome(widget.home.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Room updated successfully')),
        );
      }
    } else {
      final message = _errorMessage(response, 'Failed to update room.');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _deleteRoom(BuildContext context, LocationItem location) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Room'),
        content: RichText(
          text: TextSpan(
            text: 'Are you sure you want to delete ',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.black),
            children: [
              TextSpan(
                text: '"${location.name}"',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const TextSpan(text: '?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColor.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    final response = await SumikiNovaApi.deleteLocationCall.call(
      locationId: location.id.toString(),
    );
    if (!context.mounted) return;
    if (response.succeeded) {
      ref
          .read(homeManagementProvider.notifier)
          .loadLocationsForHome(widget.home.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Room deleted successfully')),
        );
      }
    } else {
      final message = _errorMessage(response, 'Failed to delete room.');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  String _errorMessage(ApiCallResponse response, String fallback) {
    final body = response.jsonBody;
    if (body is Map) {
      if (body['message'] != null) return body['message'].toString();
      if (body['errors'] is Map) {
        final errors = body['errors'] as Map;
        final list = errors.values.whereType<List>().expand((e) => e).toList();
        if (list.isNotEmpty) return list.map((e) => e.toString()).join(' ');
      }
    }
    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeManagementProvider);
    return Scaffold(
      backgroundColor: AppColor.white2,
      body: Column(
        children: [
          const CustomHeader(title: 'Home Settings', isAllowBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HomeHeaderCard(
                    homeName: _displayName,
                    homeAddress: _displayAddress,
                    onEdit: _updateHome,
                    onDelete: () => _deleteHome(context),
                  ),
                  const SizedBox(height: 24),
                  if (state.locationsLoading) _LoadingSection(),
                  if (!state.locationsLoading && state.locationsError != null)
                    _ErrorSection(message: state.locationsError!),
                  if (!state.locationsLoading &&
                      state.locationsError == null &&
                      state.locationsForCurrentHome.isEmpty)
                    _EmptyRoomsSection(),
                  if (!state.locationsLoading &&
                      state.locationsError == null &&
                      state.locationsForCurrentHome.isNotEmpty)
                    _RoomsSection(
                      rooms: state.locationsForCurrentHome,
                      onEditRoom: _updateRoom,
                      onDeleteRoom: _deleteRoom,
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
  const _HomeHeaderCard({
    required this.homeName,
    required this.homeAddress,
    this.onEdit,
    this.onDelete,
  });

  final String homeName;
  final String homeAddress;
  final void Function(BuildContext context)? onEdit;
  final VoidCallback? onDelete;

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      Text(
                        homeAddress,
                        style: TypographyFont.uih7reg.copyWith(
                          color: AppColor.gray5,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onEdit != null)
                      InkWellEffect(
                        onTap: () => onEdit!(context),
                        child: Tooltip(
                          message: 'Edit Home',
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.edit,
                              color: AppColor.gray4,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    InkWellEffect(
                      onTap: onDelete,
                      child: Tooltip(
                        message: 'Delete Home',
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.delete,
                            color: AppColor.gray4,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Room photo row in Edit Room dialog: thumbnail + Change photo button.
class _RoomEditImageSection extends StatelessWidget {
  const _RoomEditImageSection({
    required this.location,
    required this.pickedImagePath,
    required this.onPickImage,
  });

  final LocationItem location;
  final String? pickedImagePath;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    final showPhotoPath = location.showPhotoPath;
    print('showPhotoPath: $showPhotoPath');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Room photo',
          style: TypographyFont.uih7med.copyWith(color: AppColor.gray6),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 72,
                height: 72,
                child: pickedImagePath != null
                    ? Image.file(File(pickedImagePath!), fit: BoxFit.cover)
                    : (showPhotoPath.isNotEmpty
                          ? Image.network(
                              showPhotoPath,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _placeholder(),
                            )
                          : _placeholder()),
              ),
            ),

            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onPickImage,
                icon: const Icon(Icons.photo_library_outlined, size: 20),
                label: const Text('Change photo'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColor.gray1,
      child: Icon(
        Icons.door_front_door_rounded,
        color: AppColor.gray4,
        size: 32,
      ),
    );
  }
}

/// Section title + list of room tiles.
class _RoomsSection extends StatelessWidget {
  const _RoomsSection({
    required this.rooms,
    this.onEditRoom,
    this.onDeleteRoom,
  });

  final List<LocationItem> rooms;
  final void Function(BuildContext context, LocationItem location)? onEditRoom;
  final void Function(BuildContext context, LocationItem location)?
  onDeleteRoom;

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
                _RoomListTile(
                  location: e.value,
                  onEdit: onEditRoom != null
                      ? (ctx) => onEditRoom!(ctx, e.value)
                      : null,
                  onDelete: onDeleteRoom != null
                      ? (ctx) => onDeleteRoom!(ctx, e.value)
                      : null,
                ),
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
  const _RoomListTile({required this.location, this.onEdit, this.onDelete});

  final LocationItem location;
  final void Function(BuildContext context)? onEdit;
  final void Function(BuildContext context)? onDelete;

  @override
  Widget build(BuildContext context) {
    // final imageUrl = location.locationList?.imageUrl ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        spacing: 16,
        children: [
          _RoomIcon(imageUrl: location.showPhotoPath),
          Expanded(
            child: Text(
              location.name,
              style: TypographyFont.uih5med.copyWith(color: AppColor.black),
            ),
          ),
          Row(
            spacing: 12,
            children: [
              if (onEdit != null)
                InkWellEffect(
                  onTap: () => onEdit!(context),
                  child: Tooltip(
                    message: 'Edit Room',
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.edit, color: AppColor.gray4, size: 24),
                    ),
                  ),
                ),
              if (onDelete != null)
                InkWellEffect(
                  onTap: () => onDelete!(context),
                  child: Tooltip(
                    message: 'Delete Room',
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.delete,
                        color: AppColor.gray4,
                        size: 24,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
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
