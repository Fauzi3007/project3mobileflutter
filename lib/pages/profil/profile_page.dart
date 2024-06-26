import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipegpdam/pages/login_page.dart';
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

  @override
  void initState() {
    super.initState();
    fetchPegawai();
  }

  Future<void> fetchPegawai() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');

    try {
      Pegawai pegawai = await PegawaiService().fetchPegawai(id!);
      setState(() {
        _pegawai = pegawai;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // _isLoading
            //     ? const Center(child: CircularProgressIndicator())
            //     : _hasError
            //         ? const Center(child: Text('Error fetching data'))
            //         : const Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [],
            //           ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileSection(),
                    const SizedBox(height: 20),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
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
                        'https://imgs.search.brave.com/eBQndt052LAMVgGGACW3KEuCq71r97mAjPRgZYanPxY/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE1/MjI1NTYxODk2Mzkt/YjE1MGVkOWM0MzMw/P3E9ODAmdz0xMDAw/JmF1dG89Zm9ybWF0/JmZpdD1jcm9wJml4/bGliPXJiLTQuMC4z/Jml4aWQ9TTN3eE1q/QTNmREI4TUh4elpX/RnlZMmg4T0h4OGNH/VnljMjl1WVh4bGJu/d3dmSHd3Zkh4OE1B/PT0.jpeg',
                        scale: .8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Jenis Kelamin:',
                        style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.jenisKelamin,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Tanggal Lahir:',
                        style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.tglLahir,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Telepon:', style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.telepon,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Alamat:', style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.alamat,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nama Lengkap:', style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.namaLengkap,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Status Nikah:', style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.statusNikah,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Jumlah Anak:', style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.jumlahAnak.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Gaji Pokok:', style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.gajiPokok.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Kantor Cabang:',
                        style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.kantorCabang.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Jabatan:', style: TextStyle(fontSize: 18)),
                    Text(
                      _pegawai!.jabatan.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Handle ubah data button press
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
            // Handle ganti password button press
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
            _handleLogout(context);
          },
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            elevation: 5,
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ],
    );
  }
}

void _handleLogout(BuildContext context) async {
  String message = await logout();
  final scaffoldContext = context;
  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
    SnackBar(content: Text(message)),
  );
  if (message == 'Logout successful!') {
    Navigator.pushReplacement(
      scaffoldContext,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
