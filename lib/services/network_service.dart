import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// Create custom HTTP client with timeout settings
final httpClient = http.Client();

Future<Map<String, dynamic>> fetchWeather(String city, String apiKey) async {
  try {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
    );
    
    final response = await httpClient
        .get(url)
        .timeout(const Duration(seconds: 15)); // Increased timeout

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 401) {
      throw Exception('Invalid API key - check your OWM_KEY');
    } else if (response.statusCode == 404) {
      throw Exception('City not found - try another');
    } else {
      throw Exception('Weather API error: ${response.statusCode}');
    }
  } on SocketException catch (e) {
    throw Exception('Network error: ${e.message}. Check your DNS or internet connection.');
  } on TimeoutException {
    throw Exception('Request timeout - API took too long to respond');
  } on FormatException {
    throw Exception('Invalid response from weather API');
  } catch (e) {
    throw Exception('Failed to fetch weather: ${e.toString()}');
  }
}

Future<Map<String, dynamic>?> fetchAQI(String city, String apiKey) async {
  try {
    final url = Uri.parse(
      'https://api.waqi.info/feed/$city/?token=$apiKey',
    );
    
    final response = await httpClient
        .get(url)
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'ok') {
        return data as Map<String, dynamic>;
      }
      return null;
    }
    return null;
  } on SocketException catch (e) {
    // AQI is optional, silently fail
    print('AQI fetch failed: ${e.message}');
    return null;
  } catch (e) {
    // AQI is optional, silently fail
    print('AQI error: $e');
    return null;
  }
}

Future<bool> checkNetworkConnectivity() async {
  try {
    final response = await httpClient
        .get(Uri.parse('https://www.google.com'))
        .timeout(const Duration(seconds: 5));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
