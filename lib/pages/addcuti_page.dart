import 'package:flutter/material.dart';
import 'package:sipegpdam/models/cuti.dart';
import 'package:sipegpdam/services/cuti_services.dart';

class AddCutiPage extends StatefulWidget {
  const AddCutiPage({Key? key}) : super(key: key);

  @override
  State<AddCutiPage> createState() => _AddCutiPageState();
}

class _AddCutiPageState extends State<AddCutiPage> {
  final CutiService _cutiService = CutiService();

  final TextEditingController tanggalMulaiController = TextEditingController();
  final TextEditingController tanggalSelesaiController =
      TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  Future<void> _createCuti(Cuti newCuti) async {
    try {
      await _cutiService.createCuti(newCuti);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuti created successfully')),
      );
    } catch (e) {
      print('Error creating cuti: $e');
    }
  }

  @override
  void dispose() {
    tanggalMulaiController.dispose();
    tanggalSelesaiController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan Cuti'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextFormField(
              controller: tanggalMulaiController,
              decoration: InputDecoration(
                labelText: 'Tanggal Mulai',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  tanggalMulaiController.text = selectedDate.toString();
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: tanggalSelesaiController,
              decoration: InputDecoration(
                labelText: 'Tanggal Selesai',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  tanggalSelesaiController.text = selectedDate.toString();
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: keteranganController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Keterangan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Cuti newCuti = Cuti(
                  idPegawai: 1,
                  tanggalMulai: DateTime.parse(tanggalMulaiController.text),
                  tanggalSelesai: DateTime.parse(tanggalSelesaiController.text),
                  keterangan: keteranganController.text,
                  status: 'menunggu',
                );

                _createCuti(newCuti);
              },
              icon: const Icon(Icons.save),
              label: const Text('Ajukan Cuti'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 5,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
