import 'dart:convert';

import 'package:machine_test_user_api/core/common/api.dart';
import 'package:machine_test_user_api/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<UserModel?> getUserData({required String name}) async {
    try {
      final response = await http.get(Uri.parse('$apiKey/$name'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
}
