import 'package:flutter/material.dart';
import '../models/create_orden_res.dart';
import '../services/api_service.dart';

class OrderProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<OrdenRes> _ordenes = [];
  bool _loading = false;
  String? _error;

  List<OrdenRes> get ordenes => _ordenes;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchOrdenes() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      // Llama al endpoint real
      final result = await _apiService.getOrders();
      // Convierte a OrdenRes si es necesario
      _ordenes = result.map((o) => OrdenRes(id: o.id, nombre: o.fechaAtencion.toString(), examenes: o.examenes)).toList();
      _loading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> crearOrden({
    required String nombrePaciente,
    required DateTime fechaAtencion,
    required List<Map<String, String>> examenes,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      // Simula IDs de exámenes (en real, deberías obtenerlos de la API)
      final examenIds = List<int>.generate(examenes.length, (i) => i + 1);
      final orden = await _apiService.createOrder(
        pacienteId: 1, // Simulado
        fechaAtencion: fechaAtencion,
        examenIds: examenIds,
      );
      _ordenes.add(orden);
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _loading = false;
      notifyListeners();
      return false;
    }
  }
}
