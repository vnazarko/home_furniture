import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Map<String, dynamic>>> fetchData(String endpoint) async {
    final uri = Uri.https(baseUrl, '/$endpoint');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
