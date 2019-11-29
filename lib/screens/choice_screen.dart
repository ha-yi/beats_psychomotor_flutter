import 'package:beats_ft/helper.dart';
import 'package:beats_ft/providers/GameBoardData.dart';
import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/providers/TaskProvider.dart';
import 'package:beats_ft/screens/games/game_board.dart';
import 'package:beats_ft/screens/games/group_game_board.dart';
import 'package:beats_ft/screens/wating_group_started.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChoiceScreen extends StatefulWidget {
  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
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
              Consumer<ServerInfo>(
                builder: (context, server, child) {
                  if (server.connected) {
                    return Text(
                      "connected to server...",
                      style: TextStyle(fontSize: 10, color: Colors.green[300]),
                    );
                  } else {
                    return Text(
                      "disconnected from server...",
                      style: TextStyle(fontSize: 10, color: Colors.red[300]),
                    );
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: _gotoPersonalTest,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Image.asset(
                              "img/puzzle.png",
                              width: 150,
                              height: 150,
                            ),
                          ),
                          Text(
                            "Personal Test",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  InkWell(
                    onTap: _gotoGroupTest,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              "img/teamwork.png",
                              width: 150,
                              height: 150,
                            ),
                            margin: EdgeInsets.all(20),
                          ),
                          Text(
                            "Group Test",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _gotoPersonalTest() {
    Provider.of<TaskInfo>(context).reset();
    Provider.of<GameBoardData>(context, listen: false).reset();
    Provider.of<GameTypeProvider>(context, listen: false).isPersonal = true;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GameBoard()));
  }

  void _gotoGroupTest() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WaitingForServerStartGame()));
  }
}
