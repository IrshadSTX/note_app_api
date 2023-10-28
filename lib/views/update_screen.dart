import 'package:flutter/material.dart';
import 'package:note_app_api/core/colors.dart';
import 'package:note_app_api/core/constants.dart';

import 'package:note_app_api/views/home_screen.dart';
import 'package:note_app_api/views/view_note_screen.dart';
import 'package:note_app_api/views/widgets/show_dialogue_widget.dart';
import 'package:note_app_api/views/widgets/small_widget.dart';
import 'package:note_app_api/views/widgets/update_dialogues.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen({
    required this.id,
    super.key,
    required this.title,
    this.description,
  });
  int id;
  String title;
  String? description;
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);

    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconWidget(
                          size: size,
                          icon: Icons.arrow_back_ios_new,
                          onPressed: () async {
                            await updateConfirmationDialog(
                                context,
                                titleController.text,
                                descriptionController.text,
                                widget.id);
                            ;
                          },
                        ),
                        Row(
                          children: [
                            IconWidget(
                              size: size,
                              icon: Icons.remove_red_eye_outlined,
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewNoteScreen(
                                        id: widget.id,
                                        title: titleController.text,
                                        description: descriptionController.text,
                                      ),
                                    ));
                              },
                            ),
                            kWidth10,
                            IconWidget(
                              size: size,
                              icon: Icons.save_outlined,
                              onPressed: () async {
                                print(widget.id);
                                await update2ConfirmationDialog(
                                    context,
                                    titleController.text,
                                    descriptionController.text,
                                    widget.id);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  kHeight10,
                  TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          fontSize: 28,
                          color: greyColor,
                        )),
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'fill';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Type something...',
                        hintStyle: TextStyle(color: greyColor)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'fill';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
