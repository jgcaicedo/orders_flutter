import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/orden.dart';
import '../models/login_req.dart';
import '../models/token_res.dart';
import '../models/create_orden_res.dart'; 


class ApiService {
  static const String _baseUrl = 'http://localhost:5050/api'; 
  static const String _tokenKey = 'auth_token';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Headers base para las peticiones
  Map<String, String> get _baseHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Headers con autenticación
  Future<Map<String, String>> get _authHeaders async {
    final token = await getToken();
    final headers = Map<String, String>.from(_baseHeaders);
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Gestión de tokens
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Autenticación
  Future<TokenRes?> login(String username, String password) async {
    try {
      final request = LoginReq(username: username, password: password);
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: _baseHeaders,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final tokenResponse = TokenRes.fromJson(jsonDecode(response.body));
        await saveToken(tokenResponse.token);
        return tokenResponse;
      } else {
        // Handle login failure
        return null;
      }
    } catch (e) {
      // Handle login error
      return null;
    }
  }

  Future<void> logout() async {
    await deleteToken();
  }

  // Obtener todas las órdenes
  Future<List<Orden>> getOrders() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/ordenes'),
        headers: await _authHeaders,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Orden.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Token expirado o inválido');
      } else {
        throw ApiException('Error al obtener órdenes: ${response.statusCode}');
      }
    } catch (e) {
      if (e is UnauthorizedException) rethrow;
      throw ApiException('Error de conexión: $e');
    }
  }

  // Obtener una orden específica
  Future<Orden?> getOrder(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/ordenes/$id'),
        headers: await _authHeaders,
      );

      if (response.statusCode == 200) {
        return Orden.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        return null;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Token expirado o inválido');
      } else {
        throw ApiException('Error al obtener orden: ${response.statusCode}');
      }
    } catch (e) {
      if (e is UnauthorizedException) rethrow;
      throw ApiException('Error de conexión: $e');
    }
  }

  // Crear una nueva orden
  Future<OrdenRes> createOrder({
    required int pacienteId,
    required DateTime fechaAtencion,
    required List<int> examenIds,
  }) async {
    try {
      final request = {
        'pacienteId': pacienteId,
        'fechaAtencion': fechaAtencion.toIso8601String(),
        'examenIds': examenIds,
      };
      final response = await http.post(
        Uri.parse('$_baseUrl/ordenes'),
        headers: await _authHeaders,
        body: jsonEncode(request),
      );

      if (response.statusCode == 201) {
        return OrdenRes.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        final errorBody = jsonDecode(response.body);
        throw ValidationException(errorBody['message'] ?? 'Datos inválidos');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Token expirado o inválido');
      } else {
        throw ApiException('Error al crear orden: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ValidationException || e is UnauthorizedException) rethrow;
      throw ApiException('Error de conexión: $e');
    }
  }

  // Verificar salud del API
  Future<bool> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/../health'),
        headers: _baseHeaders,
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

// Excepciones personalizadas
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  
  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
  
  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
  
  @override
  String toString() => message;
}
