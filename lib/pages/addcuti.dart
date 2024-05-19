import 'package:flutter/material.dart';

class AddCutiPage extends StatefulWidget {
  const AddCutiPage({Key? key}) : super(key: key);

  @override
  State<AddCutiPage> createState() => _AddCutiPageState();
}

class _AddCutiPageState extends State<AddCutiPage> {
  final TextEditingController tanggalMulaiController = TextEditingController();
  final TextEditingController tanggalSelesaiController =
      TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

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
            TextField(
              controller: tanggalMulaiController,
              decoration: InputDecoration(
                labelText: 'Tanggal Mulai',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: tanggalSelesaiController,
              decoration: InputDecoration(
                labelText: 'Tanggal Selesai',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
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
                // Handle ubah data button press
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
