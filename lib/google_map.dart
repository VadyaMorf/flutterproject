import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapStateWidget();
}

class _GoogleMapStateWidget extends State<GoogleMapWidget> {
  LatLng myCurrentLocation = const LatLng(47.82289, 35.19031);  
  final Set<Marker> _markers = {};

  @override
  void initState(){
    super.initState();
    _addMarkers();
  }

  void _addMarkers(){
    _markers.add(
      Marker(markerId: const MarkerId('shop1'),
      position: const LatLng(47.82243, 35.04262),
      infoWindow: const InfoWindow(title: 'вул. Героїв 93 бригади 15', snippet: '+380 (63) 473-60-78, +380 (99) 964-09-72'))
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('shop2'),
        position: const LatLng(47.78426, 35.18255),
        infoWindow: const InfoWindow(title: 'вул. Новокузнецька 21, Комунарський район', snippet: '+380 (95) 075-84-42'),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('shop3'),
        position: const LatLng(47.78446, 35.24325),
        infoWindow: const InfoWindow(title: 'ул.Оріхівське шосе 10-Г, (обласна лікарня) 2 поверх',snippet: '+380 (50) 970-32-34'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition: CameraPosition(target: myCurrentLocation,
      zoom: 10,
      ),
      markers: _markers,
      ),
    );
  }
}