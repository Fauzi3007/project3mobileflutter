import 'package:flutter/material.dart';
import 'package:sipegpdam/models/absensi.dart';
import 'package:sipegpdam/services/absensi_services.dart';

class DataAbsensiPage extends StatefulWidget {
  const DataAbsensiPage({Key? key}) : super(key: key);

  @override
  _DataAbsensiPageState createState() => _DataAbsensiPageState();
}

class _DataAbsensiPageState extends State<DataAbsensiPage> {
  final AbsensiService _absensiService = AbsensiService();
  late List<Absensi> _absensiList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAbsensiList();
  }

  Future<void> _fetchAbsensiList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Absensi> absensiList = await _absensiService.fetchAbsensiList();
      setState(() {
        _absensiList = absensiList;
      });
    } catch (e) {
      print('Error fetching Absensi list: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Absensi'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _absensiList.length,
              itemBuilder: (context, index) {
                Absensi absensi = _absensiList[index];
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        const Text(
                          'Tanggal: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          absensi.tanggal
                              .toString(), // Assuming tanggal is a DateTime object
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        const Text(
                          'Bulan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const VerticalDivider(),
                        const Text(
                          'Nama Hari',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const VerticalDivider(),
                        Text(
                          'Status: ${absensi.status}',
                        ),
                        const VerticalDivider(),
                        Text(
                          'Keterangan: ${absensi.keterangan}',
                        ),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          absensi.waktuMasuk
                              .toString(), // Assuming waktuMasuk is a DateTime object
                        ),
                        const Text(
                          'Keluar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          absensi.waktuKeluar
                              .toString(), // Assuming waktuKeluar is a DateTime object
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
