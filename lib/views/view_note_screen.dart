import 'package:flutter/material.dart';
import 'package:note_app_api/core/colors.dart';
import 'package:note_app_api/core/constants.dart';

import 'package:note_app_api/views/home_screen.dart';
import 'package:note_app_api/views/update_screen.dart';
import 'package:note_app_api/views/widgets/small_widget.dart';

class ViewNoteScreen extends StatefulWidget {
  ViewNoteScreen({
    required this.id,
    super.key,
    required this.title,
    this.description,
  });
  int id;
  String title;
  String? description;
  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
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
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                        ),
                        IconWidget(
                          size: size,
                          icon: Icons.edit,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateScreen(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    id: widget.id,
                                  ),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                  kHeight10,
                  TextFormField(
                    readOnly: true,
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
                    readOnly: true,
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
