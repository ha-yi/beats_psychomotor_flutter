import 'package:beats_ft/helper.dart';
import 'package:beats_ft/providers/GameBoardData.dart';
import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/providers/TaskProvider.dart';
import 'package:beats_ft/screens/games/group_game_board.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class WaitingForServerStartGame extends StatefulWidget {
  @override
  _WaitingForServerStartGameState createState() =>
      _WaitingForServerStartGameState();
}

class _WaitingForServerStartGameState extends State<WaitingForServerStartGame> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      sendToServer(context, GameCommad(9, "-"));
      Provider.of<ServerInfo>(context).addListener(_waitForServerUpdate);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onBack() {
    return Future(() {
      sendToServer(context, GameCommad(91, "-"));
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
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
                  child: Text("Menunggu Server memulai Test"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _waitForServerUpdate() {
    GameCommad data = Provider.of<ServerInfo>(context).dataFromServer;
    if (data != null && data.code == START_GROUP_GAME) {
      Provider.of<TaskInfo>(context).reset();
      Provider.of<GameBoardData>(context, listen: false).reset();
      Provider.of<GameTypeProvider>(context, listen: false).isPersonal = false;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GroupGameBoard()));
    }
  }
}
