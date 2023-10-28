import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_api/core/colors.dart';
import 'package:note_app_api/core/constants.dart';
import 'package:note_app_api/model/get_note_model.dart';
import 'package:note_app_api/services/delete_services.dart';
import 'package:note_app_api/services/get_notes_services.dart';

import 'package:note_app_api/views/add_new_note.dart';
import 'package:note_app_api/views/search_screen.dart';
import 'package:note_app_api/views/view_note_screen.dart';
import 'package:note_app_api/views/widgets/small_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<NoteModel>?>? _data;

  @override
  void initState() {
    super.initState();
    _data = GetNoteServices().getTasks();
  }

  Future<void> _refreshData() async {
    setState(() {
      _data = GetNoteServices().getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: bgColor,
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          foregroundColor: Colors.white,
          backgroundColor: bgColor,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AddNoteScreen()),
            );
          },
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Notes',
                            style: GoogleFonts.nunito(
                                fontSize: 34, color: Colors.white),
                          ),
                          Row(
                            children: [
                              IconWidget(
                                size: size,
                                icon: Icons.search,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchScreen()));
                                },
                              ),
                              kWidth10,
                              IconWidget(
                                size: size,
                                icon: Icons.info_outline,
                                onPressed: () {
                                  showInfoDialog(context);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<NoteModel>?>(
                          future: GetNoteServices().getTasks(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                return Column(
                                  children: [
                                    Image.asset('assets/images/firstnote.png'),
                                    Text(
                                      'Create your first note',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                );
                              }
                              final List<Color> tileColors = [
                                pink,
                                lightCream,
                                lightGreen,
                                lightYellow,
                                lightCyan,
                                violet,
                              ];

                              return ListView.separated(
                                separatorBuilder: (context, index) {
                                  return kHeight10;
                                },
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final NoteModel data = snapshot.data![index];
                                  final Color tileColor =
                                      tileColors[index % tileColors.length];

                                  return Dismissible(
                                    key: Key(data.id.toString()),
                                    background: Container(color: Colors.red),
                                    onDismissed: (direction) {
                                      DeleteNote().deleteNote(data.id, context);

                                      setState(() {
                                        snapshot.data!.removeAt(index);
                                      });
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          (MaterialPageRoute(
                                            builder: (context) {
                                              debugPrint(data.title);
                                              return ViewNoteScreen(
                                                  id: data.id,
                                                  title: data.title,
                                                  description:
                                                      data.description);
                                            },
                                          )),
                                        );
                                      },
                                      child: Container(
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: tileColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: size.height * 0.03,
                                                  horizontal: size.width * 0.1),
                                              child: Text(
                                                data.title == ''
                                                    ? '< No Title >'
                                                    : data.title,
                                                maxLines: 3,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return const Center(
                                  child: Text(
                                'Network Lost',
                                style: TextStyle(color: Colors.white),
                              ));
                            }
                          }),
                    ),
                  ],
                )),
          ),
        ));
  }
}
