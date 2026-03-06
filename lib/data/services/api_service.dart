/// HTTP service for communicating with the FastAPI backend.
///
/// Base URL: http://127.0.0.1:8000
/// Change [baseUrl] to your deployed backend URL when going to production.

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/search_model.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';
  static const Duration _timeout = Duration(seconds: 60);

  /// POST /api/search — returns AI answer + sources.
  Future<SearchResponse> search({
    required String query,
    String searchMode = 'auto',
  }) async {
    final uri = Uri.parse('$baseUrl/api/search');
    final body = jsonEncode(
      SearchRequest(query: query, searchMode: searchMode).toJson(),
    );

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    ).timeout(_timeout);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return SearchResponse.fromJson(json);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['detail'] ?? 'Search failed (${response.statusCode})');
    }
  }

  /// GET /health — checks if backend is alive.
  Future<bool> checkHealth() async {
    try {
      final uri = Uri.parse('$baseUrl/health');
      final response = await http.get(uri).timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
