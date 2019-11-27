import 'dart:async';

import 'package:beats_ft/screens/home_screen.dart';
import 'package:beats_ft/screens/server_scanner_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ServerScannerScreen()));
    });

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "BEATS",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "psychomotor",
                style: TextStyle(
                  color: Colors.blue.withAlpha(100),
                  fontSize: 20,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
