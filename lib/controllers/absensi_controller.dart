import 'package:flutter/material.dart';
import 'package:sipegpdam/services/service.dart';
import '../models/absensi.dart';
import '.././services/absensi_services.dart';

class AbsensiController extends ChangeNotifier {
  final AbsensiService _service = AbsensiService();
  List<Absensi> _absensiList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Absensi> get absensiList => _absensiList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAbsensiList() async {
    _isLoading = true;
    notifyListeners();

    try {
      _absensiList = await _service.fetchAbsensiList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAbsensiData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _absensiList = (await _service.fetchAbsensi(await fetchPegawaiId()))
          as List<Absensi>;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createAbsensi(Absensi absensi) async {
    try {
      await _service.createAbsensi(absensi);
      fetchAbsensiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> updateAbsensi(String id, Absensi absensi) async {
    try {
      await _service.updateAbsensi(id, absensi);
      fetchAbsensiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> deleteAbsensi(String id) async {
    try {
      await _service.deleteAbsensi(id);
      fetchAbsensiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
