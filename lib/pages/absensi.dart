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
  late LatLng myPosition;
  String _status = 'hadir';

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
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid, // Change the map type here
            buildingsEnabled: true,
            circles: {
              Circle(
                circleId: const CircleId('circle'),
                center: const LatLng(-0.914032, 100.467388),
                radius: 160,
                fillColor: Colors.blue.withOpacity(0.5),
                strokeWidth: 1,
              ),
            },
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(-0.914032, 100.467388),
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
                position: myPosition,
                infoWindow: InfoWindow(
                  title: 'My Position',
                  snippet: 'Current Location',
                ),
              ),
            },
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Anda belum berada di radius absen',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
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
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '07:30 - 16:00',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
                              fontSize: 16,
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
                              fontSize: 16,
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
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            DateFormat.Hm().format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 38,
                              color: Colors.blue,
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
                    onPressed: () {
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
                        fontSize: 16,
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
