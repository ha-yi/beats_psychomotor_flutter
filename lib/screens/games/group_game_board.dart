import 'package:beats_ft/providers/GameBoardData.dart';
import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/providers/TaskProvider.dart';
import 'package:beats_ft/screens/games/board_tiles.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupGameBoard extends StatefulWidget {
  final bool isPersonal;

  const GroupGameBoard({Key key, this.isPersonal = true}) : super(key: key);

  @override
  _GroupGameBoardState createState() => _GroupGameBoardState();
}

class _GroupGameBoardState extends State<GroupGameBoard> {
  ServerInfo server;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        "GROUP Task ke - ${Provider.of<TaskInfo>(context).taskId}"),
                  ),
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
    ];
  }

  void showFinishDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => FancyDialog(
        title: "Selamat!",
        descreption: "Semua task sudah selesai anda kerjakan.",
        theme: FancyTheme.FANCY,
        okFun: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
