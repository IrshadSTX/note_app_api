import 'package:flutter/material.dart';
import 'package:note_app_api/views/home_screen.dart';

class SplashScreenProvider with ChangeNotifier {
  Future<void> navigateToHome(BuildContext context) async {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}
