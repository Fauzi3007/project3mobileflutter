import 'package:flutter/material.dart';
import '../models/pelanggan.dart';
import '.././services/pelanggan_services.dart';

class PelangganController extends ChangeNotifier {
  final PelangganService _service = PelangganService();
  List<Pelanggan> _pelangganList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Pelanggan> get pelangganList => _pelangganList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPelangganList() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pelangganList = await _service.fetchPelangganList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createPelanggan(Pelanggan pelanggan) async {
    try {
      await _service.createPelanggan(pelanggan);
      fetchPelangganList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> updatePelanggan(String id, Pelanggan pelanggan) async {
    try {
      await _service.updatePelanggan(id, pelanggan);
      fetchPelangganList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> deletePelanggan(String id) async {
    try {
      await _service.deletePelanggan(id);
      fetchPelangganList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
