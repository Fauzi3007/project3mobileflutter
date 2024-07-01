import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sipegpdam/controllers/absensi_controller.dart';

class DataAbsensiPage extends StatefulWidget {
  const DataAbsensiPage({Key? key}) : super(key: key);

  @override
  _DataAbsensiPageState createState() => _DataAbsensiPageState();
}

class _DataAbsensiPageState extends State<DataAbsensiPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AbsensiController>(context, listen: false).fetchAbsensiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Absensi'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Consumer<AbsensiController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          if (controller.absensiList.isEmpty) {
            return const Center(child: Text('Tidak ada data absensi'));
          }

          return ListView.builder(
            itemCount: controller.absensiList.length,
            itemBuilder: (context, index) {
              final absensi = controller.absensiList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Row(
                    children: [
                      const Text(
                        'Tanggal: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat('dd MMMM yyyy').format(absensi.tanggal),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Status: ${absensi.status}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const VerticalDivider(),
                      Text(
                        'Keterangan: ${absensi.keterangan}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Masuk: ${DateFormat('HH:mm').format(absensi.waktuMasuk)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Keluar: ${DateFormat('HH:mm').format(absensi.waktuKeluar)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
