import 'dart:io'; // For File handling
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image picking
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

  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();

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

  // Show dialog to select image source
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }

  // Pick image from the selected source
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
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
        title: const Text('Pengajuan Cuti',
            style: TextStyle(color: Colors.white, fontSize: 16)),
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
            GestureDetector(
              onTap: _showImageSourceDialog,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  image: _selectedFile != null
                      ? DecorationImage(
                          image: FileImage(_selectedFile!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _selectedFile == null
                    ? Center(
                        child: Text(
                          'Tap to select image',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      )
                    : null,
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
                  // You can also handle file upload here if needed
                );

                _createCuti(newCuti);
              },
              icon: const Icon(Icons.save),
              label: const Text('Ajukan Cuti'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.lightBlueAccent,
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
