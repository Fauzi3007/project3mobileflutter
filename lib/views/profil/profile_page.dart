import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipegpdam/controllers/pegawai_controller.dart';
import 'package:sipegpdam/services/auth_service.dart';
import 'package:sipegpdam/views/login_page.dart';
import 'package:sipegpdam/views/profil/update_password.dart';
import 'package:sipegpdam/views/profil/update_profile_page.dart';
import '../../models/pegawai.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Fetch Pegawai data using Provider
    Provider.of<PegawaiController>(context, listen: false).fetchPegawaiData();
    Provider.of<PegawaiController>(context, listen: false)
        .fetchNamaJabatanCabang();
  }

  Future<void> _handleLogout() async {
    String message = await logoutService();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    if (message == 'Logout successful!') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PegawaiController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            backgroundColor: Colors.lightBlueAccent,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (controller.pegawaiList.isNotEmpty)
                          _buildProfileSection(controller.pegawaiList[0],
                              controller.jabatanCabang)
                        else
                          _buildProfileSection(
                              Pegawai(
                                idUser: 0,
                                idPegawai: 0,
                                jenisKelamin: 'No data',
                                tglLahir: 'No data',
                                telepon: 'No data',
                                alamat: 'No data',
                                namaLengkap: 'No data',
                                statusNikah: 'No data',
                                jumlahAnak: 0,
                                gajiPokok: 0.00,
                                kantorCabang: 0,
                                jabatan: 0,
                                foto:
                                    'https://imgs.search.brave.com/a0ZfLM4icBBGMQOp7PVGbzq5IHURITDSqg19VROGA6Y/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMjAw/MDY3MjcwMi9waG90/by9oYXBweS1zbWls/aW5nLW1hdHVyZS1p/bmRpYW4tb3ItbGF0/aW4tYnVzaW5lc3Mt/bWFuLWNlby10cmFk/ZXItdXNpbmctY29t/cHV0ZXItdHlwaW5n/LXdvcmtpbmctaW4u/d2VicD9iPTEmcz0x/NzA2NjdhJnc9MCZr/PTIwJmM9UEV4U2Iw/R0lFQWxiQm04d0R0/TnVjS0pyVlZKT1Rx/bjlrSEVadlFCaHpq/VT0',
                              ),
                              []),
                      ],
                    ),
                  ),
                ),
              ),
              // Action buttons
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        if (controller.pegawaiList.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateProfilePage(
                                pegawai: controller.pegawaiList[0],
                              ),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Ubah Data'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 4,
                        minimumSize: const Size(double.infinity, 45),
                      ),
                    ),
                    const SizedBox(height: 8),
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 4,
                        minimumSize: const Size(double.infinity, 45),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        _handleLogout();
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.black,
                        elevation: 4,
                        minimumSize: const Size(double.infinity, 45),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileSection(Pegawai pegawai, List jabatanList) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                pegawai.foto.isNotEmpty
                    ? pegawai.foto
                    : 'https://i.pinimg.com/564x/82/8d/b9/828db9be5b13a6addefcd70431c8845d.jpg', // Default placeholder
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              pegawai.namaLengkap,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              jabatanList.isEmpty ? 'No data' : jabatanList[0],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 18),
          _buildProfileDataRow(
            'Tanggal Lahir:',
            pegawai.tglLahir,
          ),
          const SizedBox(height: 12),
          _buildProfileDataRow(
            'Telepon:',
            pegawai.telepon,
          ),
          const SizedBox(height: 12),
          _buildProfileDataRow(
            'Status Nikah:',
            pegawai.statusNikah,
          ),
          const SizedBox(height: 12),
          _buildProfileDataRow(
            'Jumlah Anak:',
            pegawai.jumlahAnak.toString(),
          ),
          const SizedBox(height: 12),
          _buildProfileDataRow(
            'Gaji Pokok:',
            pegawai.gajiPokok.toStringAsFixed(2),
          ),
          const SizedBox(height: 12),
          _buildProfileDataRow(
            'Cabang:',
            jabatanList.isEmpty ? 'No data' : jabatanList[1],
          ),
          const SizedBox(height: 12),
          _buildProfileDataRow(
            'Alamat:',
            pegawai.alamat,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
