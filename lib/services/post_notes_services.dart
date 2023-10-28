import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:note_app_api/core/api.dart';
import 'package:http/http.dart' as http;

class AddNoteService {
  Future<bool?> addNote(String title, String description) async {
    final Uri url = Uri.parse(baseUrl + postNoteApi);
    final Map<String, dynamic> requestBody = {
      'title': title,
      'description': description,
    };
    try {
      final Response response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;
  }
}
