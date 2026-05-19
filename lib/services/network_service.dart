import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';
import 'dart:async' show TimeoutException;
import 'dart:io';

// Check if device has internet connection
Future<bool> hasInternetConnection() async {
  try {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  } catch (e) {
    return false;
  }
}

Future<Map<String, dynamic>> fetchWeather(String city, String owmKey) async {
  // Check internet connectivity first
  if (!await hasInternetConnection()) {
    throw Exception('No internet connection. Please check your network and try again.');
  }

  final url = Uri.parse(
    'https://api.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(city)}&appid=$owmKey&units=metric',
  );

  int retries = 3;
  Exception? lastError;

  while (retries > 0) {
    try {
      final res = await http.get(url).timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) {
        throw Exception('City "$city" not found. Check spelling and try again.');
      }
      return jsonDecode(res.body) as Map<String, dynamic>;
    } on http.ClientException catch (e) {
      lastError = Exception('Network error: ${e.message}. Check your internet connection.');
      retries--;
      if (retries > 0) {
        await Future.delayed(const Duration(seconds: 2));
      }
    } on TimeoutException {
      lastError = Exception('Request timed out. Please check your connection and try again.');
      retries--;
      if (retries > 0) {
        await Future.delayed(const Duration(seconds: 2));
      }
    } on SocketException catch (e) {
      lastError = Exception('Connection failed: ${e.message}. Check your internet.');
      retries--;
      if (retries > 0) {
        await Future.delayed(const Duration(seconds: 2));
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  throw lastError ?? Exception('Failed to fetch weather after multiple attempts.');
}

Future<Map<String, dynamic>?> fetchAQI(String city, String waqiKey) async {
  // Check internet connectivity first
  if (!await hasInternetConnection()) {
    return null;
  }

  final url = Uri.parse(
    'https://api.waqi.info/feed/${Uri.encodeComponent(city)}/?token=$waqiKey',
  );

  int retries = 2;

  while (retries > 0) {
    try {
      final res = await http.get(url).timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) {
        retries--;
        if (retries > 0) {
          await Future.delayed(const Duration(seconds: 2));
        }
        continue;
      }
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return data['status'] == 'ok' ? data['data'] as Map<String, dynamic> : null;
    } catch (e) {
      retries--;
      if (retries > 0) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }
  return null;
}
