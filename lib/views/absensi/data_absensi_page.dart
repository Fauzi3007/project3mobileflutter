import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipegpdam/models/absensi.dart';
import 'package:sipegpdam/services/absensi_services.dart';

class DataAbsensiPage extends StatefulWidget {
  const DataAbsensiPage({Key? key}) : super(key: key);

  @override
  _DataAbsensiPageState createState() => _DataAbsensiPageState();
}

class _DataAbsensiPageState extends State<DataAbsensiPage> {
  final AbsensiService _absensiService = AbsensiService();
  List<Absensi> _absensiList = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAbsensiList();
  }

  Future<void> _fetchAbsensiList() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      List<Absensi> absensiList = await _absensiService.fetchAbsensiList();
      setState(() {
        _absensiList = absensiList;
      });
    } catch (e) {
      print('Error fetching Absensi list: $e');
      setState(() {
        _errorMessage = 'Gagal memuat data absensi.';
      });
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
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : ListView.builder(
                  itemCount: _absensiList.length,
                  itemBuilder: (context, index) {
                    Absensi absensi = _absensiList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
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
                              DateFormat('dd MMMM yyyy')
                                  .format(absensi.tanggal),
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
                ),
    );
  }
}
