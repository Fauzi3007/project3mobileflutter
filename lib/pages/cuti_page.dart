import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipegpdam/models/cuti.dart';
import 'package:sipegpdam/pages/addcuti_page.dart';
import 'package:sipegpdam/services/cuti_services.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  final CutiService _cutiService = CutiService();
  late List<Cuti> _cutiList = [];

  // Method to fetch cuti list
  Future<void> _fetchCutiList() async {
    try {
      List<Cuti> cutiList = await _cutiService.fetchCutiList();
      setState(() {
        _cutiList = cutiList;
      });
    } catch (e) {
      // Handle error gracefully, e.g., show error message to the user
      print('Error fetching cuti list: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch cuti list when the page is first initialized
    _fetchCutiList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuti'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCutiPage()),
              ).then((_) {
                // Refresh cuti list after adding a new cuti
                _fetchCutiList();
              });
            },
          ),
        ],
      ),
      body: _cutiList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _cutiList.length,
              itemBuilder: (context, index) {
                Cuti cuti = _cutiList[index];
                return Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${cuti.idCuti}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tanggal Mulai: ${DateFormat('dd MMMM yyyy').format(cuti.tanggalMulai)}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tanggal Selesai: ${DateFormat('dd MMMM yyyy').format(cuti.tanggalSelesai)}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Keterangan: ${cuti.keterangan}',
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${cuti.status}',
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
