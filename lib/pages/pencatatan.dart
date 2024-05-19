import 'package:flutter/material.dart';
import 'package:sipegpdam/pages/addpencatatan.dart';

class PencatatanPage extends StatefulWidget {
  const PencatatanPage({super.key});

  @override
  State<PencatatanPage> createState() => _PencatatanPageState();
}

class _PencatatanPageState extends State<PencatatanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatatan Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              // Add button logic here
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddPencatatanPage()));
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to Pencatatan Page'),
      ),
    );
  }
}
