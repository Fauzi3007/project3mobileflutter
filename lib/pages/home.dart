import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipegpdam/pages/cuti.dart';
import 'package:sipegpdam/pages/dataabsensi.dart';
import 'package:sipegpdam/pages/gaji.dart';
import 'package:sipegpdam/pages/pelanggan.dart';
import 'package:sipegpdam/pages/pencatatan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAdminAdministrasi = false;
  bool isAdminKeuangan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[600],
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
            height: 100,
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: .5,
                    child: Image.asset(
                      'lib/images/tirta.png',
                      fit: BoxFit.contain, // Set the fit property to contain
                    ),
                  ),
                ),
                const Center(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('lib/images/avatar.jpeg'),
                                radius: 30,
                              ),
                              SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Doe',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Staff',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 120),
                              IconButton(
                                icon: Icon(Icons.notifications),
                                color: Colors.white,
                                iconSize: 30,
                                onPressed: null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
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
            height: 190,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('EEEE, d MMMM y', 'id_ID')
                          .format(DateTime.now()),
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
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '07:30',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Keluar',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '16:00',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(indent: 2, endIndent: 2),
                SizedBox(height: 30),
                Column(
                  children: [
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
                        Column(
                          children: [
                            const Text(
                              'Hadir',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '20 Hari',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Izin',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '1 Hari',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.yellow.shade800,
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.yellow.shade800,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Cuti',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '1 Hari',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 20),
            child: const Text(
              'Menu Utama',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.count(
                    crossAxisCount: 3,
                    padding: const EdgeInsets.all(10),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildMenuItem(Icons.calendar_today, 'Data Absensi', () {
                        // Navigate to Data Absensi page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DataAbsensiPage()),
                        );
                      }),
                      _buildMenuItem(Icons.attach_money, 'Info Gaji', () {
                        // Navigate to Info Gaji page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GajiPage()),
                        );
                      }),
                      _buildMenuItem(Icons.beach_access, 'Cuti', () {
                        // Navigate to Cuti page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CutiPage()),
                        );
                      }),
                      _buildMenuItem(Icons.people, 'Pelanggan', () {
                        // Navigate to Pelanggan page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PelangganPage()),
                        );
                      }),
                      _buildMenuItem(Icons.note_add, 'Pencatatan', () {
                        // Navigate to Pencatatan page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PencatatanPage()),
                        );
                      }),
                      if (isAdminAdministrasi)
                        _buildMenuItem(Icons.check, 'Persetujuan Cuti', () {
                          // Navigate to Pencatatan page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PencatatanPage()),
                          );
                        }),
                      if (isAdminKeuangan)
                        _buildMenuItem(Icons.payment, 'Pemberian Gaji', () {
                          // Navigate to Pencatatan page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PencatatanPage()),
                          );
                        }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
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
              width: 60,
              height: 60,
              child: Icon(
                icon,
                size: 30,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
