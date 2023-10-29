import 'package:flutter/material.dart';
import 'package:note_app_api/controller/add_new_provider.dart';
import 'package:note_app_api/core/colors.dart';
import 'package:note_app_api/core/constants.dart';
import 'package:note_app_api/views/home_screen.dart';
import 'package:note_app_api/views/widgets/show_dialogue_widget.dart';
import 'package:note_app_api/views/widgets/small_widget.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({
    super.key,
  });

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<AddNewNoteProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                                (MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                )));
                          },
                        ),
                        Row(
                          children: [
                            IconWidget(
                              size: size,
                              icon: Icons.remove_red_eye_outlined,
                              onPressed: () {},
                            ),
                            kWidth10,
                            IconWidget(
                              size: size,
                              icon: Icons.save_outlined,
                              onPressed: () async {
                                await showConfirmationDialog(
                                    context,
                                    titleController.text,
                                    descriptionController.text);
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
                    onChanged: (value) {
                      noteProvider.updateTitle(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'fill';
                      }
                      return null;
                    },
                  ),
                  kHeight20,
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                    onChanged: (value) {
                      noteProvider.updateDescription(value);
                    },
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
                  kHeight10
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
