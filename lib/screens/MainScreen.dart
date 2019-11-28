import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/screens/home_screen.dart';
import 'package:beats_ft/screens/server_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ServerInfo>(
        builder: (context, server, child) {
          if (server.serverAddress == null) {
            return ServerScannerScreen();
          } else {
            return HomeScreen();
          }
        },
      ),
    );
  }
}
