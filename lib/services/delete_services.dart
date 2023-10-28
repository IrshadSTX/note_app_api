import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:note_app_api/core/api.dart';
import 'package:note_app_api/core/colors.dart';

class DeleteNote {
  Future<void> deleteNote(int id, BuildContext context) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/notes/$id'));

      if (response.statusCode == 200) {
        debugPrint('Note deleted successfully');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: redColor,
            content: Text(
              'Note Removed Successfully',
            ),
          ),
        );
      } else {
        debugPrint(
            'Failed to delete note. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
