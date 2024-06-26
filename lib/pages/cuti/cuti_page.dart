import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipegpdam/models/cuti.dart';
import 'package:sipegpdam/pages/cuti/addcuti_page.dart';
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
      // Handle error gracefully
      print('Error fetching cuti list: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCutiList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cuti',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCutiPage()),
              );
              _fetchCutiList(); // Refresh cuti list after adding
            },
          ),
        ],
      ),
      body: _cutiList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cutiList.length,
              itemBuilder: (context, index) {
                Cuti cuti = _cutiList[index];
                return Card(
                  elevation: 2.0,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${cuti.idCuti}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tanggal Mulai: ${DateFormat('dd MMMM yyyy').format(cuti.tanggalMulai)}',
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tanggal Selesai: ${DateFormat('dd MMMM yyyy').format(cuti.tanggalSelesai)}',
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Keterangan: ${cuti.keterangan}',
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${cuti.status}',
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                );
              },
              // // Add separator between list items
              // separatorBuilder: (context, index) => const Divider(
              //   height: 1.0,
              //   color: Colors.grey[300],
              // ),
            ),
    );
  }
}
