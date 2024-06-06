import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class GajiPage extends StatefulWidget {
  const GajiPage({Key? key}) : super(key: key);

  @override
  State<GajiPage> createState() => _GajiPageState();
}

class _GajiPageState extends State<GajiPage> {
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gaji'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _onPressed(context: context, locale: 'id');
                },
                icon: const Icon(Icons.calendar_today, color: Colors.white70),
                label: _selected == null
                    ? const Text('Bulan dan Tahun Belum Dipilih',
                        style: TextStyle(color: Colors.white70, fontSize: 16.0))
                    : Text(DateFormat('MMMM y', 'id_ID').format(_selected!),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 16.0)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.blue,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16.0),
                    _buildRow(
                      'Gaji Pokok',
                      'Rp. 3.000.000',
                      'Potongan',
                      'Rp. 300.000',
                    ),
                    const SizedBox(height: 16.0),
                    _buildRow(
                      'Tunjangan Jabatan',
                      'Rp. 1.500.000',
                      'Pajak',
                      'Rp. 234.032',
                    ),
                    const SizedBox(height: 16.0),
                    _buildRow(
                      'Tunjangan Nikah',
                      'Rp. 100.000',
                      'Total Gaji',
                      'Rp. 4.465.968',
                    ),
                    const SizedBox(height: 16.0),
                    _buildRow(
                      'Tunjangan Anak',
                      'Rp. 200.000',
                      'Tanggal',
                      DateFormat('MMMM yyyy', 'id_ID').format(DateTime.now()),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title1, String value1, String title2, String value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildColumn(title1, value1),
        _buildColumn(title2, value2),
      ],
    );
  }

  Widget _buildColumn(String title, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18.0),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      locale: localeObj,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Set the primary color to blue
            colorScheme: const ColorScheme.light(
                primary: Colors.blue), // Set the color scheme to blue
          ),
          child: child ?? Container(),
        );
      },
    );
    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }
}
