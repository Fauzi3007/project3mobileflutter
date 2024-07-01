import 'package:flutter/material.dart';
import 'package:sipegpdam/services/service.dart';
import '../models/pegawai.dart';
import '.././services/pegawai_services.dart';

class PegawaiController extends ChangeNotifier {
  final PegawaiService _service = PegawaiService();
  List<Pegawai> _pegawaiList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Pegawai> get pegawaiList => _pegawaiList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPegawaiList() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pegawaiList = await _service.fetchPegawaiList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPegawaiData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pegawaiList =
          await _service.fetchPegawai(await fetchPegawaiId()) as List<Pegawai>;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createPegawai(Pegawai pegawai) async {
    try {
      await _service.createPegawai(pegawai);
      fetchPegawaiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> updatePegawai(String id, Pegawai pegawai) async {
    try {
      await _service.updatePegawai(id, pegawai);
      fetchPegawaiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> deletePegawai(String id) async {
    try {
      await _service.deletePegawai(id);
      fetchPegawaiList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
