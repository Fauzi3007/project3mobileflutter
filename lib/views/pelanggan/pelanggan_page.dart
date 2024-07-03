import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipegpdam/controllers/pelanggan_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PelangganPage extends StatefulWidget {
  const PelangganPage({super.key});

  @override
  State<PelangganPage> createState() => _PelangganPageState();
}

class _PelangganPageState extends State<PelangganPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PelangganController>(context, listen: false)
        .fetchPelangganList();
  }

  void _launchMapsUrl(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pelanggan Page',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Consumer<PelangganController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          if (controller.pelangganList.isEmpty) {
            return const Center(child: Text('Tidak ada data pelanggan'));
          }

          return ListView.builder(
            itemCount: controller.pelangganList.length,
            itemBuilder: (context, index) {
              final pelanggan = controller.pelangganList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    pelanggan.nomorPelanggan,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    pelanggan.namaPelanggan,
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.location_on,
                        color: Colors.lightBlueAccent),
                    onPressed: () {
                      _launchMapsUrl(pelanggan.latitude, pelanggan.longitude);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
