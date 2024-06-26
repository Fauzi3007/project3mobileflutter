import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipegpdam/pages/cuti/cuti_page.dart';
import 'package:sipegpdam/pages/absensi/dataabsensi_page.dart';
import 'package:sipegpdam/pages/gaji/gaji_page.dart';
import 'package:sipegpdam/pages/pelanggan/pelanggan_page.dart';
import 'package:sipegpdam/pages/pencatatan/pencatatan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isAdminAdministrasi;
  late bool isAdminKeuangan;
  // final PegawaiService _PegawaiService = PegawaiService();
  // late Pegawai _pegawaiList;
  // late String role;

  // // Future<void> _fetchCutiList() async {
  // //   try {
  // //     Pegawai pegawaiList = await _PegawaiService.fetchPegawai(1);
  // //     setState(() {
  // //       _pegawaiList = pegawaiList;
  // //     });
  // //   } catch (e) {
  // //     // Handle error gracefully
  // //     print('Error fetching cuti list: $e');
  // //   }
  // // }

  // Future<void> _fetchHakAkses() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? role = prefs.getString('hak_akses');
  //   setState(() {
  //     role = role!;
  //     if (role == 'admin administrasi') {
  //       isAdminAdministrasi = true;
  //     } else if (role == 'admin keuangan') {
  //       isAdminKeuangan = true;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _fetchCutiList();
    // _fetchHakAkses();
    isAdminAdministrasi = true;
    isAdminKeuangan = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildAttendanceSummary(),
            _buildMainMenuTitle(),
            _buildMainMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 150,
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'lib/images/tirta.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('lib/images/avatar.jpeg'),
                    radius: 30,
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "role",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    color: Colors.white,
                    iconSize: 30,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceSummary() {
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
      height: 210,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('EEEE, d MMMM y', 'id_ID').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '07:30 - 16:00',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAttendanceColumn('Masuk', '07:30'),
              _buildAttendanceColumn('Keluar', '16:00'),
            ],
          ),
          const Divider(),
          const Center(
            child: Text(
              'Absensi Bulan Ini',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAttendanceStatus('Hadir', '20 Hari', Colors.green),
              _buildAttendanceStatus('Izin', '1 Hari', Colors.yellow.shade800),
              _buildAttendanceStatus('Cuti', '1 Hari', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceColumn(String title, String time) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceStatus(String status, String days, Color color) {
    return Column(
      children: [
        Text(
          status,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          days,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
        Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildMainMenuTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 20),
      child: const Text(
        'Menu Utama',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMainMenu() {
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
      height: 220,
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        children: [
          _buildMenuItem('lib/images/attendance.png', 'Data Absensi', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DataAbsensiPage()),
            );
          }),
          _buildMenuItem('lib/images/salary.png', 'Info Gaji', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GajiPage()),
            );
          }),
          _buildMenuItem('lib/images/leave.png', 'Cuti', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CutiPage()),
            );
          }),
          _buildMenuItem('lib/images/rating.png', 'Pelanggan', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PelangganPage()),
            );
          }),
          _buildMenuItem('lib/images/documentation.png', 'Pencatatan', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PencatatanPage()),
            );
          }),
          if (isAdminAdministrasi)
            _buildMenuItem('lib/images/approved.png', 'Persetujuan Cuti', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CutiPage()),
              );
            }),
          if (isAdminKeuangan)
            _buildMenuItem('lib/images/budget.png', 'Pemberian Gaji', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GajiPage()),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    icon,
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 7,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
