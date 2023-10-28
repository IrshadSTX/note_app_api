import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:note_app_api/core/colors.dart';
import 'package:note_app_api/core/constants.dart';
import 'package:note_app_api/services/post_notes_services.dart';
import 'package:note_app_api/views/home_screen.dart';

showConfirmationDialog(BuildContext context, String title, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.info,
                color: greyColor,
                size: 40,
              ),
              const SizedBox(height: 16),
              const Text(
                'Save Changes ?',
                style: TextStyle(
                  color: greyColor,
                  fontSize: 18,
                ),
              ),
              kHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                      height: 40,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Discard',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      height: 40,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: TextButton(
                        onPressed: () async {
                          if (title == '' && description == '') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Add Note'),
                              backgroundColor: redColor,
                            ));
                          } else {
                            await AddNoteService()
                                .addNote(title, description)
                                .then((value) => {
                                      if (value == true)
                                        {
                                          Navigator.pushReplacement(
                                              context,
                                              (MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen())))
                                        }
                                    });
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
