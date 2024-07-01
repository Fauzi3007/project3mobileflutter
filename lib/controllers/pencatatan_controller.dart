import 'package:flutter/material.dart';
import '../models/pencatatan.dart';
import '.././services/pencatatan_services.dart';

class PencatatanController extends ChangeNotifier {
  final PencatatanService _service = PencatatanService();
  List<Pencatatan> _pencatatanList = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Pencatatan> get pencatatanList => _pencatatanList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPencatatanList() async {
    _isLoading = true;
    notifyListeners();

    try {
      _pencatatanList = await _service.fetchPencatatanList();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createPencatatan(Pencatatan pencatatan) async {
    try {
      await _service.createPencatatan(pencatatan);
      fetchPencatatanList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> updatePencatatan(String id, Pencatatan pencatatan) async {
    try {
      await _service.updatePencatatan(id, pencatatan);
      fetchPencatatanList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<void> deletePencatatan(String id) async {
    try {
      await _service.deletePencatatan(id);
      fetchPencatatanList();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }
}
