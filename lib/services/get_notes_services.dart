import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note_app_api/core/api.dart';
import 'package:note_app_api/model/get_note_model.dart';

class GetNoteServices {
  Future<List<NoteModel>?> getTasks() async {
    const url = baseUrl + getNoteApi;
    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        List<NoteModel> tasks =
            data.map((json) => NoteModel.fromJson(json)).toList();
        return tasks;
      }
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
    return null;
  }
}
