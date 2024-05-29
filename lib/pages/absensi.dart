// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({Key? key}) : super(key: key);

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  late GoogleMapController mapController;
  LatLng? myPosition;
  String _status = 'hadir';
  bool isMockLocation = false;
  bool isWithinRadius = false;

  final LatLng kantorPdamLocation = const LatLng(-0.914032, 100.467388);
  final double radius = 200; // Radius in meters

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        myPosition = LatLng(position.latitude, position.longitude);
        isMockLocation = position.isMocked;
        isWithinRadius =
            _isWithinRadius(myPosition!, kantorPdamLocation, radius);
      });
    } catch (e) {
      print(e);
    }
  }

  bool _isWithinRadius(LatLng position, LatLng target, double radius) {
    final double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      target.latitude,
      target.longitude,
    );
    return distance <= radius;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          myPosition == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  mapType: MapType.hybrid,
                  buildingsEnabled: true,
                  circles: {
                    Circle(
                      circleId: const CircleId('circle'),
                      center: kantorPdamLocation,
                      radius: radius,
                      fillColor: Colors.blue.withOpacity(0.5),
                      strokeWidth: 1,
                    ),
                  },
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: myPosition!,
                    zoom: 18.0,
                  ),
                  markers: {
                    const Marker(
                      markerId: MarkerId('marker'),
                      position: LatLng(-0.914032, 100.467388),
                      infoWindow: InfoWindow(
                        title: 'Kantor PDAM Tirta Sakti',
                        snippet: 'Cabang Padang',
                      ),
                    ),
                    Marker(
                      markerId: const MarkerId('myPosition'),
                      position: myPosition!,
                      infoWindow: const InfoWindow(
                        title: 'My Position',
                        snippet: 'Current Location',
                      ),
                    ),
                  },
                ),
          if (isMockLocation)
            Positioned(
              bottom: 285,
              left: 5,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                height: 50,
                padding: const EdgeInsets.all(10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 20,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Matikan mock location.',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 240,
            left: 5,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              height: 40,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20,
                    color: isWithinRadius ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    isWithinRadius
                        ? 'Anda berada di dalam radius absen'
                        : 'Anda belum berada di radius absen',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isWithinRadius ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              height: 230,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEEE, d MMMM y', 'id_ID')
                            .format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat.Hm().format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'hadir',
                            groupValue: _status,
                            onChanged: (value) {
                              setState(() {
                                _status = value.toString();
                              });
                            },
                          ),
                          const Text(
                            'Hadir',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Radio(
                            value: 'sakit',
                            groupValue: _status,
                            onChanged: (value) {
                              setState(() {
                                _status = value.toString();
                              });
                            },
                          ),
                          const Text(
                            'Sakit',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Radio(
                            value: 'izin',
                            groupValue: _status,
                            onChanged: (value) {
                              setState(() {
                                _status = value.toString();
                              });
                            },
                          ),
                          const Text(
                            'Izin',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Keterangan (Optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isMockLocation || !isWithinRadius
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Absensi berhasil'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Absen',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
