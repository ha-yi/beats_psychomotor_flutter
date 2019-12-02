import 'package:beats_ft/helper.dart';
import 'package:beats_ft/providers/GameBoardData.dart';
import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/providers/TaskProvider.dart';
import 'package:beats_ft/providers/UserInfo.dart';
import 'package:beats_ft/screens/fullscreen_dialog.dart';
import 'package:beats_ft/screens/games/board_tiles.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatefulWidget {
  final bool isPersonal;

  const GameBoard({Key key, this.isPersonal = true}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  ServerInfo server;
  DialogPopup popup;

  @override
  void initState() {
    super.initState();
    popup = DialogPopup(context);
    Future.delayed(Duration(milliseconds: 300), () {
      sendToServer(context, GameCommad(91, ""));
    });
    Future.delayed(Duration(milliseconds: 500), () {
      var task = Provider.of<TaskInfo>(context);
      task.addListener(() {
        if (task.duration <= 0) {
          popup.show("Timeout", "Waktu sudah habis. Kerjakan task berikutnya?",
              () {
            task.nextTask();
            Provider.of<GameBoardData>(context, listen: false)
                .setColumn(task.getCount());
            Provider.of<GameBoardData>(context, listen: false).taskId =
                task.taskId;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: Row(
          children: <Widget>[
            Container(
              width: 150,
              child: Column(
                children: _buildTaskList(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Container(
                        width: 1400,
                        height: 1000,
                        child: Center(child: BoardTiles()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTaskList() {
    return [
      Text(
        "BEATS",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      Expanded(
        child: Consumer<TaskInfo>(
          builder: (context, task, child) {
            if (task.finished) {
              Future.delayed(Duration(milliseconds: 100), () {
                showFinishDialog();
              });
            }
            return SingleChildScrollView(
              child: Column(
                children: TASKS
                    .map(
                      (id) => Container(
                        padding: EdgeInsets.all(10),
                        color: (id == task.taskId)
                            ? Colors.green.withAlpha(120)
                            : Colors.transparent,
                        child: Text("Task $id"),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
      MaterialButton(
        color: Colors.green,
        onPressed: () {
          TaskInfo task = Provider.of<TaskInfo>(context);
          task.nextTask();
          Provider.of<GameBoardData>(context, listen: false)
              .setColumn(task.getCount());
          Provider.of<GameBoardData>(context, listen: false).taskId =
              task.taskId;
        },
        child: Text(
          "Task Berikutnya",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ];
  }

  void showFinishDialog() {
    Provider.of<UserInfo>(context, listen: false).personalFinish = true;
    popup.show("Selamat", "Semua task sudah selesai anda kerjakan.", () {
      popup.dismiss();
      Navigator.pop(context);
    });
  }
}
