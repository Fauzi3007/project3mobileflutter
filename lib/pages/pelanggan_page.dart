import 'package:flutter/material.dart';
import 'package:sipegpdam/models/pelanggan.dart';
import 'package:sipegpdam/services/pelanggan_services.dart';
import 'package:url_launcher/url_launcher.dart';

class PelangganPage extends StatefulWidget {
  const PelangganPage({super.key});

  @override
  State<PelangganPage> createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  List<Pelanggan> _pelanggan = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    getPelanggan();
  }

  Future<void> getPelanggan() async {
    try {
      List<Pelanggan> pelanggan = await PelangganService().fetchPelangganList();
      setState(() {
        _pelanggan = pelanggan;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pelanggan Page'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: 300,
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _hasError
                ? const Center(
                    child: Text('An error occurred, please try again'))
                : ListView.builder(
                    itemCount: _pelanggan.length,
                    itemBuilder: (context, index) {
                      final pelanggan = _pelanggan[index];
                      return ListTile(
                        title: Text(pelanggan.nomorPelanggan),
                        subtitle: Text(pelanggan.namaPelanggan),
                        trailing: IconButton(
                          icon:
                              const Icon(Icons.location_on, color: Colors.blue),
                          onPressed: () {
                            double latitude = pelanggan.latitude;
                            double longitude = pelanggan.longitude;
                            String url =
                                'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                            launchUrl(Uri(path: url));
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
