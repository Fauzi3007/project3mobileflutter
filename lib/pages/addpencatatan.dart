import 'package:flutter/material.dart';

class AddPencatatanPage extends StatefulWidget {
  const AddPencatatanPage({Key? key}) : super(key: key);

  @override
  State<AddPencatatanPage> createState() => _AddPencatatanPageState();
}

class _AddPencatatanPageState extends State<AddPencatatanPage> {
  TextEditingController idPelangganController = TextEditingController();
  TextEditingController meteranLamaController = TextEditingController();
  TextEditingController meteranBaruController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController fotoMeteranController = TextEditingController();

  String? selectedIdPelanggan; // Add this line

  List<String> idPelangganList = [
    'ID1',
    'ID2',
    'ID3'
  ]; // Add your list of ID Pelanggan here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pencatatan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedIdPelanggan,
              onChanged: (value) {
                setState(() {
                  selectedIdPelanggan = value;
                });
              },
              items: idPelangganList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'ID Pelanggan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: meteranLamaController,
              decoration: InputDecoration(
                labelText: 'Meteran Lama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: meteranBaruController,
              decoration: InputDecoration(
                labelText: 'Meteran Baru',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: tanggalController,
              decoration: InputDecoration(
                labelText: 'Tanggal',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: fotoMeteranController,
              decoration: InputDecoration(
                labelText: 'Foto Meteran',
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
              label: const Text('Simpan Data'),
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
