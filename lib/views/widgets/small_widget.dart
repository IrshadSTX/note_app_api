import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_api/core/colors.dart';
import 'package:note_app_api/core/constants.dart';

class IconWidget extends StatelessWidget {
  final Size size;
  final IconData icon;
  final Function()? onPressed;

  const IconWidget({
    required this.size,
    required this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.1,
      decoration: BoxDecoration(
        color: bgHomeIcon,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

void showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            decoration: const BoxDecoration(),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Designed by -',
                      style:
                          GoogleFonts.nunito(fontSize: 14, color: Colors.white),
                    ),
                    kHeight10,
                    Text(
                      'Redesigned by -',
                      style:
                          GoogleFonts.nunito(fontSize: 14, color: Colors.white),
                    ),
                    kHeight10,
                    Text(
                      'Illustrations -',
                      style:
                          GoogleFonts.nunito(fontSize: 14, color: Colors.white),
                    ),
                    kHeight10,
                    Text(
                      'Icons -',
                      textAlign: TextAlign.left,
                      style:
                          GoogleFonts.nunito(fontSize: 14, color: Colors.white),
                    ),
                    kHeight10,
                    Text(
                      'Font -',
                      style:
                          GoogleFonts.nunito(fontSize: 14, color: Colors.white),
                    ),
                    kHeight10,
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Made by',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                            fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
