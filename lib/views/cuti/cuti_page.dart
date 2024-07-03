import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sipegpdam/models/cuti.dart';
import 'package:sipegpdam/views/cuti/add_cuti_page.dart';
import 'package:sipegpdam/controllers/cuti_controller.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => _CutiPageState();
}

class _CutiPageState extends State<CutiPage> {
  @override
  void initState() {
    super.initState();
    // Fetch cuti list when the page initializes
    Provider.of<CutiController>(context, listen: false).fetchCutiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cuti',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCutiPage()),
              );
              Provider.of<CutiController>(context, listen: false)
                  .fetchCutiList(); // Refresh cuti list after adding
            },
          ),
        ],
      ),
      body: Consumer<CutiController>(
        builder: (context, cutiController, child) {
          if (cutiController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cutiController.cutiList.isEmpty) {
            return const Center(child: Text('Tidak ada data cuti'));
          }

          return ListView.builder(
            itemCount: cutiController.cutiList.length,
            itemBuilder: (context, index) {
              Cuti cuti = cutiController.cutiList[index];
              return Card(
                elevation: 2.0,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Left Section: Number and "Hari" text
                          SizedBox(
                            width: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  cuti.tanggalSelesai
                                      .difference(cuti.tanggalMulai)
                                      .inDays
                                      .toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Hari',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                          // Vertical Divider

                          // Right Section: Dates and Status
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${DateFormat('dd MMMM yyyy').format(cuti.tanggalMulai)}',
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                        ),
                                        Text(
                                          '${DateFormat('dd MMMM yyyy').format(cuti.tanggalSelesai)}',
                                          style:
                                              const TextStyle(fontSize: 12.0),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      cuti.status
                                              .substring(0, 1)
                                              .toUpperCase() +
                                          cuti.status.substring(1),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: cuti.status == 'Menunggu'
                                            ? Colors.orange
                                            : cuti.status == 'Disetujui'
                                                ? Colors.green
                                                : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Divider(
                                  color: Colors.grey,
                                  height: 1,
                                ),
                                const SizedBox(height: 8),
                                // Description
                                Text(
                                  'Keterangan: ${cuti.keterangan}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.red, size: 14),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Konfirmasi'),
                                content: const Text(
                                    'Apakah Anda yakin ingin menghapus cuti ini?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Provider.of<CutiController>(context,
                                              listen: false)
                                          .deleteCuti(cuti.idCuti as String);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
