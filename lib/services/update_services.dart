import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UpdateService {
  Future<bool?> updateNote(String title, String description, int id) async {
    print('inside updated');
    final Uri url = Uri.parse('http://159.89.161.169:3001/api/user/notes/$id');
    final Map<String, dynamic> requestBody = {
      'title': title,
      'description': description,
    };
    try {
      final Response response = await http.put(
        url,
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('true');
        return true;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }
}
