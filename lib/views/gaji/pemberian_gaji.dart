import 'package:flutter/material.dart';

class PemberianGajiPage extends StatefulWidget {
  const PemberianGajiPage({super.key});

  @override
  State<PemberianGajiPage> createState() => _PemberianGajiPageState();
}

class _PemberianGajiPageState extends State<PemberianGajiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemberian Gaji'),
      ),
      body: const Center(
        child: Text('Pemberian Gaji'),
      ),
    );
  }
}
