import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sumikanova/core/constant/app_color.dart';
import 'package:sumikanova/core/utils/location_helper.dart';
import 'package:sumikanova/core/widget/customheader.dart';

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
  final GlobalKey _mapContainerKey = GlobalKey();
  bool _isDraggingMarker = false;
  String? _address;
  bool _addressLoading = false;
  Timer? _addressDebounce;
  bool _loadingDeviceLocation = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialCenter != null) {
      selectedLocation = widget.initialCenter;
      _fetchAddress(widget.initialCenter!);
    } else {
      _loadingDeviceLocation = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _requestDeviceLocation();
      });
    }
  }

  Future<void> _requestDeviceLocation() async {
    if (!mounted) return;
    final result = await requestLocationAndGetPosition(context);
    if (!mounted) return;
    if (result is LocationAllowed && result.position != null) {
      final p = result.position!;
      final latLng = LatLng(p.latitude, p.longitude);
      final zoom = widget.initialZoom ?? 15.0;
      _mapController.move(latLng, zoom);
      setState(() {
        selectedLocation = latLng;
        _loadingDeviceLocation = false;
      });
      _fetchAddress(latLng);
    } else {
      setState(() => _loadingDeviceLocation = false);
    }
  }

  @override
  void dispose() {
    _addressDebounce?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  static const String _nominatimUserAgent = 'SumikaNova/1.0';

  Future<void> _fetchAddress(LatLng point) async {
    _addressDebounce?.cancel();
    _addressDebounce = Timer(const Duration(milliseconds: 400), () async {
      if (!mounted) return;
      setState(() {
        _address = null;
        _addressLoading = true;
      });
      try {
        final dio = Dio(
          BaseOptions(headers: {'User-Agent': _nominatimUserAgent}),
        );
        final response = await dio.get<Map<String, dynamic>>(
          'https://nominatim.openstreetmap.org/reverse',
          queryParameters: {
            'lat': point.latitude,
            'lon': point.longitude,
            'format': 'json',
          },
        );
        if (!mounted) return;
        final name = response.data?['display_name'] as String?;
        setState(() {
          _address = name ?? 'Unknown location';
          _addressLoading = false;
        });
      } catch (_) {
        if (mounted) {
          setState(() {
            _address = null;
            _addressLoading = false;
          });
        }
      }
    });
  }

  void _onLocationChanged(LatLng location) {
    setState(() => selectedLocation = location);
    _fetchAddress(location);
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

  Future<void> _onCurrentLocationTap() async {
    setState(() => _loadingDeviceLocation = true);
    await _requestDeviceLocation();
  }

  void _onMapTap(TapPosition tapPosition, LatLng latlng) {
    if (!_isDraggingMarker) _onLocationChanged(latlng);
  }

  void _startMarkerDrag() {
    setState(() => _isDraggingMarker = true);
  }

  void _updateMarkerPosition(Offset globalPosition) {
    final box =
        _mapContainerKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final localPos = box.globalToLocal(globalPosition);
    final latlng = _mapController.camera.screenOffsetToLatLng(localPos);
    _onLocationChanged(latlng);
  }

  void _endMarkerDrag() {
    setState(() => _isDraggingMarker = false);
  }

  void _confirmAndReturn() {
    if (selectedLocation != null) {
      Navigator.pop(context, <String, dynamic>{
        'lat': selectedLocation!.latitude,
        'lng': selectedLocation!.longitude,
        'address': _address,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialCenter =
        widget.initialCenter ??
        const LatLng(26.881746390467278, 75.7374074972241);
    final initialZoom = widget.initialZoom ?? 15.0;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Select Location'),
      //   actions: [
      //     if (selectedLocation != null)
      //       IconButton(
      //         icon: const Icon(Icons.check),
      //         tooltip: 'Use this location',
      //         onPressed: _confirmAndReturn,
      //       ),
      //   ],
      // ),
      body: Stack(
        children: [
          SizedBox.expand(
            key: _mapContainerKey,
            child: Column(
              children: [
                CustomHeader(
                  title: 'Select Location',
                  isAllowBack: true,
                  isSubmit: true,
                  submitIcon: const Icon(Icons.check, color: AppColor.white),
                  onSubmit: _confirmAndReturn,
                ),
                Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: initialCenter,
                      initialZoom: initialZoom,
                      onTap: _onMapTap,
                      onPositionChanged: (MapCamera camera, bool hasGesture) {
                        if (!_isDraggingMarker && mounted) {
                          _onLocationChanged(camera.center);
                        }
                      },
                      interactionOptions: InteractionOptions(
                        flags: _isDraggingMarker
                            ? InteractiveFlag.all &
                                  ~InteractiveFlag.drag &
                                  ~InteractiveFlag.flingAnimation
                            : InteractiveFlag.all,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                        userAgentPackageName: 'sumikanova',
                        maxZoom: 19,
                      ),
                      if (selectedLocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: selectedLocation!,
                              width: 120,
                              height: 80,
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onLongPress: _startMarkerDrag,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 4,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        constraints: const BoxConstraints(
                                          maxWidth: 110,
                                          maxHeight: 50,
                                        ),
                                        child: _addressLoading
                                            ? const Center(
                                                child: SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                      ),
                                                ),
                                              )
                                            : Text(
                                                _address ?? 'Loading...',
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                  ],
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
          ),
          if (_isDraggingMarker)
            Positioned.fill(
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerMove: (event) => _updateMarkerPosition(event.position),
                onPointerUp: (_) => _endMarkerDrag(),
                onPointerCancel: (_) => _endMarkerDrag(),
                child: const SizedBox.expand(),
              ),
            ),
          if (_loadingDeviceLocation)
            Positioned.fill(
              child: Container(
                color: Colors.black26,
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        'Getting your location...',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            left: 8,
            bottom: 8,
            child: Text(
              '© OSM © CARTO',
              style: TextStyle(
                fontSize: 10,
                color: Colors.black54,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 60,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.my_location),
                  onPressed: _onCurrentLocationTap,
                  tooltip: 'Current location',
                ),
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
