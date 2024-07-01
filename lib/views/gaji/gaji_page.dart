import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:sipegpdam/controllers/gaji_controller.dart';
import 'package:sipegpdam/models/gaji.dart';

class GajiPage extends StatefulWidget {
  const GajiPage({Key? key}) : super(key: key);

  @override
  State<GajiPage> createState() => _GajiPageState();
}

class _GajiPageState extends State<GajiPage> {
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    // Fetch gaji data when the page initializes
    Provider.of<GajiController>(context, listen: false).fetchGajiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gaji'),
      ),
      body: Consumer<GajiController>(
        builder: (context, gajiController, child) {
          if (gajiController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (gajiController.gajiList.isEmpty) {
            return const Center(child: Text('Tidak ada data gaji'));
          }

          Gaji gaji = gajiController.gajiList[0];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _onPressed(context: context, locale: 'id');
                    },
                    icon:
                        const Icon(Icons.calendar_today, color: Colors.white70),
                    label: _selected == null
                        ? const Text('Bulan dan Tahun Belum Dipilih',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 16.0))
                        : Text(DateFormat('MMMM y', 'id_ID').format(_selected!),
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 16.0)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
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
                        Text(
                          'Bulan : ${DateFormat('MMMM yyyy', 'id_ID').format(DateTime.now())}',
                          style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16.0),
                        _buildRow(
                          'Gaji Pokok',
                          'Rp. ${gaji.gajiPokok}',
                          'Potongan',
                          'Rp. ${gaji.potongan}',
                        ),
                        const SizedBox(height: 16.0),
                        _buildRow(
                          'Tunjangan Jabatan',
                          'Rp. ${gaji.tunjanganJabatan}',
                          'Pajak',
                          'Rp. ${gaji.pajak}',
                        ),
                        const SizedBox(height: 16.0),
                        _buildRow(
                          'Tunjangan Nikah',
                          'Rp. ${gaji.tunjanganNikah}',
                          'Tunjangan Anak',
                          'Rp. ${gaji.tunjanganAnak}',
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0, 45.0, 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total :',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              const Spacer(),
                              Text(
                                'Rp. ${gaji.totalGaji}',
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
            style: const TextStyle(fontSize: 12.0),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 12.0,
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
            primaryColor:
                Colors.lightBlueAccent, // Set the primary color to blue
            colorScheme: const ColorScheme.light(
                primary:
                    Colors.lightBlueAccent), // Set the color scheme to blue
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
