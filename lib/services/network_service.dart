import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchWeather(String city, String apiKey) async {
  try {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 404) {
      throw Exception('City not found');
    } else {
      throw Exception('Failed to fetch weather: ${response.statusCode}');
    }
  } catch (e) {
    rethrow;
  }
}

Future<Map<String, dynamic>?> fetchAQI(String city, String apiKey) async {
  try {
    final response = await http.get(
      Uri.parse('https://api.waqi.info/feed/$city/?token=$apiKey'),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'ok') {
        return data as Map<String, dynamic>;
      }
      return null;
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<bool> checkNetworkConnectivity() async {
  try {
    final response = await http.get(Uri.parse('https://www.google.com')).timeout(const Duration(seconds: 5));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
