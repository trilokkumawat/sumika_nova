import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapViewScreen extends StatefulWidget {
  final LatLng? initialCenter;
  final double? initialZoom;
  const MapViewScreen({super.key, this.initialCenter, this.initialZoom});

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  LatLng? selectedLocation;
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _zoomIn() {
    final camera = _mapController.camera;
    final newZoom = camera.zoom + 1;
    _mapController.move(camera.center, camera.clampZoom(newZoom));
  }

  void _zoomOut() {
    final camera = _mapController.camera;
    final newZoom = camera.zoom - 1;
    _mapController.move(camera.center, camera.clampZoom(newZoom));
  }

  @override
  Widget build(BuildContext context) {
    final initialCenter =
        widget.initialCenter ??
        const LatLng(26.881746390467278, 75.7374074972241);
    final initialZoom = widget.initialZoom ?? 15.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          if (selectedLocation != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => Navigator.pop(context, selectedLocation),
            ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: initialCenter,
                initialZoom: initialZoom,
                onTap: (tapPosition, latlng) {
                  setState(() {
                    selectedLocation = latlng;
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'sumikanova',
                ),
                if (selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: selectedLocation!,
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _zoomIn,
                    tooltip: 'Zoom in',
                  ),
                ),
                const SizedBox(height: 8),
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _zoomOut,
                    tooltip: 'Zoom out',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
