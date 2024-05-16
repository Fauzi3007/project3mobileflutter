import 'package:flutter/material.dart';

class DataAbsensiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Absensi'),
      ),
      body: ListView.builder(
        itemCount: absensiList.length,
        itemBuilder: (context, index) {
          Absensi absensi = absensiList[index];
          return Card(
            child: ListTile(
              title: Row(
                children: [
                  const Text(
                    'Tanggal: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${absensi.tanggal}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  const Text(
                    'Bulan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VerticalDivider(),
                  const Text(
                    'Nama Hari',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VerticalDivider(),
                  Text(
                    'Status: ${absensi.status}',
                  ),
                  const VerticalDivider(),
                  Text(
                    'Keterangan: ${absensi.keterangan}',
                  ),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${absensi.waktuMasuk}',
                  ),
                  const Text(
                    'Keluar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${absensi.waktuKeluar}',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Absensi {
  final String tanggal;
  final String waktuMasuk;
  final String waktuKeluar;
  final String status;
  final String keterangan;

  Absensi({
    required this.tanggal,
    required this.waktuMasuk,
    required this.waktuKeluar,
    required this.status,
    required this.keterangan,
  });
}

List<Absensi> absensiList = [
  Absensi(
    tanggal: '01-01-2022',
    waktuMasuk: '08:00',
    waktuKeluar: '17:00',
    status: 'Hadir',
    keterangan: 'Tidak ada keterangan',
  ),
  Absensi(
    tanggal: '02-01-2022',
    waktuMasuk: '08:30',
    waktuKeluar: '16:30',
    status: 'Hadir',
    keterangan: 'Tidak ada keterangan',
  ),
  Absensi(
    tanggal: '03-01-2022',
    waktuMasuk: '09:00',
    waktuKeluar: '18:00',
    status: 'Hadir',
    keterangan: 'Tidak ada keterangan',
  ),
];
