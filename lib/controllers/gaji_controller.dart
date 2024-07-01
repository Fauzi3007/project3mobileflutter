import 'package:flutter/material.dart';
import 'package:sipegpdam/services/service.dart';
import '../models/gaji.dart';
import '.././services/gaji_services.dart';

class GajiController extends ChangeNotifier {
  final GajiService _service = GajiService();
  List<Gaji> _gajiList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Gaji> get gajiList => _gajiList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchGajiList() async {
    _isLoading = true;
    notifyListeners();

    try {
      _gajiList = await _service.fetchGajiList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchGajiData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _gajiList =
          (await _service.fetchGaji(await fetchPegawaiId())) as List<Gaji>;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createGaji(Gaji gaji) async {
    try {
      await _service.createGaji(gaji);
      fetchGajiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> updateGaji(String id, Gaji gaji) async {
    try {
      await _service.updateGaji(id, gaji);
      fetchGajiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> deleteGaji(String id) async {
    try {
      await _service.deleteGaji(id);
      fetchGajiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
