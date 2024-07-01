import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sipegpdam/services/service.dart';
import 'package:sipegpdam/views/login_page.dart';
import 'package:sipegpdam/views/profil/update_password.dart';
import 'package:sipegpdam/views/profil/update_profile_page.dart';
import '../../models/pegawai.dart';
import '../../services/pegawai_services.dart';
import '../../services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Pegawai? _pegawai;
  bool _isLoading = true;
  bool _hasError = false;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchPegawai();
  }

  Future<void> fetchPegawai() async {
    try {
      String? idString = await _secureStorage.read(key: 'id');
      int? id = idString != null ? int.tryParse(idString) : null;

      if (id == null) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        return;
      }

      Pegawai pegawai =
          await PegawaiService().fetchPegawai(await fetchPegawaiId());
      setState(() {
        _pegawai = pegawai;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print(e);
    }
  }

  Future<void> _handleLogout() async {
    String message = await logoutService();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    if (message == 'Logout successful!') {
      await _secureStorage.deleteAll(); // Clear all secure storage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _hasError
                    ? const Center(child: Text('Error fetching data'))
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildProfileSection(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    if (_pegawai == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 300,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://example.com/profile.jpg', // Placeholder image
                        scale: .8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildProfileDataRow(
                      'Jenis Kelamin:',
                      _pegawai?.jenisKelamin ?? 'Not Available',
                    ),
                    const SizedBox(height: 10),
                    _buildProfileDataRow(
                      'Tanggal Lahir:',
                      _pegawai?.tglLahir ?? 'Not Available',
                    ),
                    const SizedBox(height: 10),
                    _buildProfileDataRow(
                      'Telepon:',
                      _pegawai?.telepon ?? 'Not Available',
                    ),
                    const SizedBox(height: 10),
                    _buildProfileDataRow(
                      'Alamat:',
                      _pegawai?.alamat ?? 'Not Available',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileDataRow(
                      'Nama Lengkap:',
                      _pegawai?.namaLengkap ?? 'Not Available',
                    ),
                    const SizedBox(height: 10),
                    _buildProfileDataRow(
                      'Status Nikah:',
                      _pegawai?.statusNikah ?? 'Not Available',
                    ),
                    const SizedBox(height: 10),
                    _buildProfileDataRow(
                      'Jumlah Anak:',
                      _pegawai?.jumlahAnak.toString() ?? 'Not Available',
                    ),
                    const SizedBox(height: 10),
                    _buildProfileDataRow(
                      'Gaji Pokok:',
                      _pegawai?.gajiPokok.toString() ?? 'Not Available',
                    ),
                    const SizedBox(height: 10),
                    _buildProfileDataRow(
                      'Kantor Cabang:',
                      _pegawai?.kantorCabang.toString() ?? 'Not Available',
                    ),
                    const SizedBox(height: 10),
                    _buildProfileDataRow(
                      'Jabatan:',
                      _pegawai?.jabatan.toString() ?? 'Not Available',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDataRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 10),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            if (_pegawai != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UpdateProfilePage(pegawai: _pegawai!)),
              );
            }
          },
          icon: const Icon(Icons.edit),
          label: const Text('Ubah Data'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 5,
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UpdatePasswordPage()),
            );
          },
          icon: const Icon(Icons.lock),
          label: const Text('Ganti Password'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 5,
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () {
            _handleLogout();
          },
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.black,
            elevation: 5,
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ],
    );
  }
}
