import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sipegpdam/controllers/pencatatan_controller.dart';
import 'package:sipegpdam/models/pencatatan.dart';

class AddPencatatanPage extends StatefulWidget {
  const AddPencatatanPage({Key? key}) : super(key: key);

  @override
  State<AddPencatatanPage> createState() => _AddPencatatanPageState();
}

class _AddPencatatanPageState extends State<AddPencatatanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController meteranLamaController = TextEditingController();
  final TextEditingController meteranBaruController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  File? _fotoMeteran; // Store the picked image file

  String? selectedIdPelanggan;

  List<String> idPelangganList = [
    'ID1',
    'ID2',
    'ID3'
  ]; // Add your list of ID Pelanggan here

  final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pencatatan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                validator: (value) =>
                    value == null ? 'Please select an ID Pelanggan' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: meteranLamaController,
                decoration: InputDecoration(
                  labelText: 'Meteran Lama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Meteran Lama'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: meteranBaruController,
                decoration: InputDecoration(
                  labelText: 'Meteran Baru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter Meteran Baru'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: tanggalController,
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a valid date'
                    : null,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    tanggalController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _showImageSourceDialog(),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    image: _fotoMeteran != null
                        ? DecorationImage(
                            image: FileImage(_fotoMeteran!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _fotoMeteran == null
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
                  if (_formKey.currentState!.validate()) {
                    final pencatatan = Pencatatan(
                      idPelanggan: int.parse(selectedIdPelanggan!),
                      meteranLama: int.parse(meteranLamaController.text),
                      meteranBaru: int.parse(meteranBaruController.text),
                      tanggal: DateFormat('yyyy-MM-dd')
                          .parse(tanggalController.text),
                      fotoMeteran: _fotoMeteran?.path ??
                          '', // Pass the file path or empty string
                      idPegawai: 1, // Example ID Pegawai
                    );

                    Provider.of<PencatatanController>(context, listen: false)
                        .createPencatatan(pencatatan)
                        .then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Simpan Data'),
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
      ),
    );
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
        _fotoMeteran = File(pickedFile.path);
      });
    }
  }
}
