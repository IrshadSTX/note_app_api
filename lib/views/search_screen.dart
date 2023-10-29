import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_app_api/core/colors.dart';
import 'package:note_app_api/core/constants.dart';
import 'package:note_app_api/model/get_note_model.dart';
import 'package:note_app_api/services/get_notes_services.dart';
import 'package:note_app_api/views/view_note_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScrenState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _SearchScrenState extends State<SearchScreen> {
  final _debouncer = Debouncer();
  List<NoteModel> nlist = [];
  List<NoteModel> noteLists = [];
  @override
  void initState() {
    super.initState();
    GetNoteServices().getTasks().then((subjectFromServer) {
      setState(() {
        nlist = subjectFromServer!;
        noteLists = nlist;
      });
    });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
                child: TextField(
                  style: TextStyle(color: greyColor),
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: bgHomeIcon,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: bgHomeIcon,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: bgHomeIcon),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    suffixIcon: InkWell(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear_outlined,
                            color: greyColor,
                            size: 20,
                          )),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: 'Search by the keyword... ',
                    hintStyle: const TextStyle(color: greyColor),
                  ),
                  onChanged: (string) {
                    _debouncer.run(() {
                      setState(() {
                        isLoading = true;
                        noteLists = nlist
                            .where(
                              (u) => (u.title.toLowerCase().contains(
                                    string.toLowerCase(),
                                  )),
                            )
                            .toList();
                        isLoading = false;
                      });
                    });
                  },
                ),
              ),
              kHeight10,
              Expanded(
                child: noteLists.isEmpty
                    ? Column(
                        children: [
                          Image.asset('assets/images/notfound.png'),
                          const Text(
                            'File not found. Try searching again.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return kHeight10;
                        },
                        itemCount: noteLists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                (MaterialPageRoute(
                                  builder: (context) {
                                    return ViewNoteScreen(
                                      id: noteLists[index].id,
                                      title: noteLists[index].title,
                                      description: noteLists[index].description,
                                    );
                                  },
                                )),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      noteLists[index].title == ''
                                          ? '< No Title >'
                                          : noteLists[index].title,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
