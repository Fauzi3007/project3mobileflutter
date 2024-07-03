import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipegpdam/models/pegawai.dart';
import 'dart:io'; // Add this import at the top of your file

class UpdateProfilePage extends StatefulWidget {
  final Pegawai pegawai;

  const UpdateProfilePage({Key? key, required this.pegawai}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaLengkapController;
  late TextEditingController _jenisKelaminController;
  late TextEditingController _tglLahirController;
  late TextEditingController _teleponController;
  late TextEditingController _emailController;
  late TextEditingController _alamatController;
  late TextEditingController _statusNikahController;
  late TextEditingController _jumlahAnakController;
  late TextEditingController _fotoController;
  XFile? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _namaLengkapController =
        TextEditingController(text: widget.pegawai.namaLengkap);
    _jenisKelaminController =
        TextEditingController(text: widget.pegawai.jenisKelamin);
    _tglLahirController = TextEditingController(text: widget.pegawai.tglLahir);
    _teleponController = TextEditingController(text: widget.pegawai.telepon);
    _alamatController = TextEditingController(text: widget.pegawai.alamat);
    _statusNikahController =
        TextEditingController(text: widget.pegawai.statusNikah);
    _jumlahAnakController =
        TextEditingController(text: widget.pegawai.jumlahAnak.toString());
    _fotoController = TextEditingController(text: widget.pegawai.foto);
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _jenisKelaminController.dispose();
    _tglLahirController.dispose();
    _teleponController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    _statusNikahController.dispose();
    _jumlahAnakController.dispose();
    _fotoController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
        _fotoController.text = pickedFile.path; // Store the image path
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Handle the form data here, e.g., send it to a server
      print('Updated Profile:');
      print('Nama Lengkap: ${_namaLengkapController.text}');
      print('Jenis Kelamin: ${_jenisKelaminController.text}');
      print('Tanggal Lahir: ${_tglLahirController.text}');
      print('Telepon: ${_teleponController.text}');
      print('Email: ${_emailController.text}');
      print('Alamat: ${_alamatController.text}');
      print('Status Nikah: ${_statusNikahController.text}');
      print('Jumlah Anak: ${_jumlahAnakController.text}');
      print('Foto: ${_fotoController.text}');
      // Here you should handle the image file (upload it or save it)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFormField(
                controller: _namaLengkapController,
                label: 'Nama Lengkap',
                validator: (value) =>
                    value!.isEmpty ? 'Nama Lengkap is required' : null,
              ),
              _buildTextFormField(
                controller: _jenisKelaminController,
                label: 'Jenis Kelamin',
                validator: (value) =>
                    value!.isEmpty ? 'Jenis Kelamin is required' : null,
              ),
              _buildTextFormField(
                controller: _tglLahirController,
                label: 'Tanggal Lahir',
                validator: (value) =>
                    value!.isEmpty ? 'Tanggal Lahir is required' : null,
              ),
              _buildTextFormField(
                controller: _teleponController,
                label: 'Telepon',
                validator: (value) =>
                    value!.isEmpty ? 'Telepon is required' : null,
              ),
              _buildTextFormField(
                controller: _emailController,
                label: 'Email',
                validator: (value) =>
                    value!.isEmpty ? 'Email is required' : null,
              ),
              _buildTextFormField(
                controller: _alamatController,
                label: 'Alamat',
                validator: (value) =>
                    value!.isEmpty ? 'Alamat is required' : null,
              ),
              _buildTextFormField(
                controller: _statusNikahController,
                label: 'Status Nikah',
                validator: (value) =>
                    value!.isEmpty ? 'Status Nikah is required' : null,
              ),
              _buildTextFormField(
                controller: _jumlahAnakController,
                label: 'Jumlah Anak',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Jumlah Anak is required' : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: _selectedImage == null
                        ? const Text('No image selected.')
                        : Image.file(
                            File(_selectedImage!.path),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _pickImage,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
