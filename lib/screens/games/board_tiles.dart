import 'package:beats_ft/helper.dart';
import 'package:beats_ft/providers/GameBoardData.dart';
import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/providers/TaskProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tile_grid/flutter_tile_grid.dart';
import 'package:provider/provider.dart';

typedef TileClickListener();

class BoardTiles extends StatefulWidget {
  @override
  _BoardTilesState createState() => _BoardTilesState();
}

class _BoardTilesState extends State<BoardTiles> {
  double baseSize = 50;

  @override
  void initState() {
    super.initState();
  }

  calculateSize(int col) {
    baseSize = 1000 / col;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameBoardData>(
      builder: (context, board, _) {
        if (board.col == null || board.col == 0) {
          return Container(
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  TaskInfo task = Provider.of<TaskInfo>(context);
                  task.nextTask();
                  board.setColumn(task.getCount());
                  board.taskId = task.taskId;
                },
                child: Text(
                  "MULAI",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }
        calculateSize(board.col);

        return Container(
          width: 1400,
          height: 1000,
          child: Row(
            children: <Widget>[
              Container(
                width: 1000,
                height: 1000,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildBoard(board),
                ),
              ),
              Container(
                width: 400,
                height: 1000,
                child: Center(
                  child: Consumer<SelectedColor>(
                    builder: (context, c, _) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Pilih Warna",
                            style: TextStyle(fontSize: 30),
                          ),
                          InkWell(
                            onTap: () {
                              c.setColor("W");
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              color: Colors.black,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(bottom: 50),
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: c.color == "W"
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.blue,
                                          size: 80,
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              c.setColor("R");
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              color: Colors.black,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(bottom: 50),
                              child: Container(
                                color: Colors.red,
                                child: Center(
                                  child: c.color == "R"
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 80,
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              c.setColor("Y");
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              color: Colors.black,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(bottom: 50),
                              child: Container(
                                color: Colors.yellow,
                                child: Center(
                                  child: c.color == "Y"
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 80,
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              c.setColor("B");
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              color: Colors.black,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(bottom: 50),
                              child: Container(
                                color: Colors.blue,
                                child: Center(
                                  child: c.color == "B"
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 80,
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> buildBoard(GameBoardData board) {
    return board.grid.map((row) {
      return Container(
        width: baseSize * board.col,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: createRowContent(board, row),
        ),
      );
    }).toList();
  }

  List<Widget> createRowContent(GameBoardData board, List<TileInfo> row) {
    return row.map((i) {
      Color color;
      switch (i.color) {
        case "W":
          color = Colors.white;
          break;
        case "R":
          color = Colors.red;
          break;
        case "Y":
          color = Colors.yellow;
          break;
        case "B":
          color = Colors.blue;
          break;
        default:
          color = Colors.white;
          break;
      }
      return InkWell(
        onTap: () {
          i.color = Provider.of<SelectedColor>(context, listen: false).color;
          i.timestamp = DateTime.now().millisecondsSinceEpoch;
          board.updateBoard(i.x, i.y, i);
          sendBoard(board);
        },
        child: Container(
          width: baseSize,
          height: baseSize,
          color: Colors.black,
          padding: EdgeInsets.all(1),
          child: Container(
            width: baseSize - 2,
            height: baseSize - 2,
            color: color,
          ),
        ),
      );
    }).toList();
  }

  void sendBoard(GameBoardData board) {
    if (Provider.of<GameTypeProvider>(context, listen: false).isPersonal) {
      Provider.of<ServerInfo>(context, listen: false)
          .sendGameData(ADD_GAME_DATA, board.toJson().toString());
    } else {
      Provider.of<ServerInfo>(context, listen: false)
          .sendGameData(ADD_GROUP_GAME_DATA, board.toJson().toString());
    }
  }
}
