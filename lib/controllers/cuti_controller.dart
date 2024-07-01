import 'package:flutter/material.dart';
import 'package:sipegpdam/services/service.dart';
import '../models/cuti.dart';
import '.././services/cuti_services.dart';

class CutiController extends ChangeNotifier {
  final CutiService _service = CutiService();
  List<Cuti> _cutiList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Cuti> get cutiList => _cutiList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCutiList() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cutiList = await _service.fetchCutiList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCutiData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cutiList =
          await _service.fetchCuti(await fetchPegawaiId()) as List<Cuti>;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createCuti(Cuti cuti) async {
    try {
      await _service.createCuti(cuti);
      fetchCutiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> updateCuti(String id, Cuti cuti) async {
    try {
      await _service.updateCuti(id, cuti);
      fetchCutiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> deleteCuti(String id) async {
    try {
      await _service.deleteCuti(id);
      fetchCutiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
