import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipegpdam/controllers/pencatatan_controller.dart';
import 'package:sipegpdam/views/pencatatan/add_pencatatan_page.dart';
import 'package:intl/intl.dart';

class PencatatanPage extends StatefulWidget {
  const PencatatanPage({super.key});

  @override
  State<PencatatanPage> createState() => _PencatatanPageState();
}

class _PencatatanPageState extends State<PencatatanPage> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PencatatanController>(context, listen: false)
          .fetchPencatatanList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatatan Page'),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddPencatatanPage()),
              );
            },
          ),
        ],
      ),
      body: Consumer<PencatatanController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          return ListView.builder(
            itemCount: controller.pencatatanList.length,
            itemBuilder: (context, index) {
              final pencatatan = controller.pencatatanList[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    'Pelanggan ID: ${pencatatan.idPelanggan}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal: ${DateFormat('dd MMMM yyyy').format(pencatatan.tanggal)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Meteran Lama: ${pencatatan.meteranLama}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Meteran Baru: ${pencatatan.meteranBaru}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon:
                        const Icon(Icons.image, color: Colors.lightBlueAccent),
                    onPressed: () {
                      // Handle image display or any other action
                    },
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
