import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/constant/typography_font.dart';

/// Result of requesting location access.
/// - [allowed] with [position]: user allowed and position was obtained.
/// - [allowed] with null: user allowed but position could not be obtained (e.g. disabled).
/// - [denied]: user denied or permanently denied; [showDeniedDialog] was or should be used.
sealed class LocationResult {
  const LocationResult();
}

final class LocationAllowed extends LocationResult {
  const LocationAllowed({this.position});
  final Position? position;
}

final class LocationDenied extends LocationResult {
  const LocationDenied();
}

/// Requests location permission. If already allowed, gets current position.
/// If user denies or has permanently denied, shows a dialog with instructions
/// and an "Open Settings" button; does not get position.
///
/// Returns [LocationAllowed] when permission is granted (position may be null
/// if location services are off). Returns [LocationDenied] when permission
/// is denied and the "how to allow" dialog is shown.
Future<LocationResult> requestLocationAndGetPosition(
  BuildContext context,
) async {
  final permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    final requested = await Geolocator.requestPermission();
    if (requested != LocationPermission.whileInUse &&
        requested != LocationPermission.always) {
      if (context.mounted) {
        await _showLocationDeniedDialog(context);
      }
      return const LocationDenied();
    }
  }
  if (permission == LocationPermission.deniedForever) {
    if (context.mounted) {
      await _showLocationDeniedDialog(context);
    }
    return const LocationDenied();
  }

  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    if (context.mounted) {
      await _showLocationDeniedDialog(context);
    }
    return const LocationDenied();
  }

  try {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
      ),
    );
    return LocationAllowed(position: position);
  } catch (_) {
    return const LocationAllowed(position: null);
  }
}

/// Shows a dialog explaining how to allow location, with an "Open Settings" button.
Future<void> showLocationDeniedDialog(BuildContext context) async {
  await _showLocationDeniedDialog(context);
}

Future<void> _showLocationDeniedDialog(BuildContext context) async {
  if (!context.mounted) return;
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text(
        'Location access needed',
        style: TypographyFont.uih4bold.copyWith(color: AppColor.primary),
      ),
      content: Text(
        'To use this feature, please allow location access in your device settings.\n\n'
        '• Open Settings → Apps → Sumikanova → Permissions\n'
        '• Or: Settings → Privacy → Location → enable for Sumikanova',
        style: TypographyFont.uih5reg.copyWith(color: AppColor.gray8),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TypographyFont.uih5reg.copyWith(color: AppColor.gray6),
          ),
        ),
        FilledButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await openAppSettings();
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'Open Settings',
            style: TypographyFont.uih5bold.copyWith(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
