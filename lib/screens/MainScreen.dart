import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/screens/home_screen.dart';
import 'package:beats_ft/screens/server_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> _stt = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _stt,
      body: Consumer<ServerInfo>(
        builder: (context, server, child) {
          if (server.error != null) {
            Future.delayed(Duration(milliseconds: 500), () {
              _stt.currentState.showSnackBar(
                SnackBar(
                  content: Text("${server.error}"),
                  duration: Duration(seconds: 30),
                  backgroundColor: Colors.deepOrange,
                ),
              );
            });
            return ServerScannerScreen();
          }
          if (server.loading) {
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "BEATS",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "psychomotor",
                      style: TextStyle(
                        color: Colors.blue.withAlpha(100),
                        fontSize: 10,
                        letterSpacing: 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: LoadingBouncingGrid.square(
                        size: 100,
                        backgroundColor: Colors.cyan,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("Mengubungkan ke Server"),
                    ),
                  ],
                ),
              ),
            );
          }
          if (server.connected) {
            return HomeScreen();
          }
          return ServerScannerScreen();
        },
      ),
    );
  }
}
