import 'package:flutter/material.dart';

class PersetujuanCutiPage extends StatefulWidget {
  const PersetujuanCutiPage({Key? key}) : super(key: key);

  @override
  State<PersetujuanCutiPage> createState() => _PersetujuanCutiPageState();
}

class _PersetujuanCutiPageState extends State<PersetujuanCutiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persetujuan Cuti'),
      ),
      body: const Center(
        child: Text('Persetujuan Cuti'),
      ),
    );
  }
}
