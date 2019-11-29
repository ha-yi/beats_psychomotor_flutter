import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TileInfo {
  int x, y;
  String color;
  int timestamp;
  String userID;

  TileInfo(this.x, this.y, this.color);

  TileInfo.fromJson(Map<String, dynamic> json)
      : x = json['x'],
        y = json['y'],
        color = json['color'],
        timestamp = json['timestamp'];

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'color': color,
        'timestamp': timestamp,
      };
}

class GameBoardData extends ChangeNotifier {
  int col = 0;
  List<List<TileInfo>> grid = [];
  int taskId;

  GameBoardData();

  reset() {
    this.col = 0;
    grid = [];
    taskId = 0;
    notifyListeners();
  }

  setColumn(int col) {
    // reset
    this.col = col;
    grid = [];

    //generate content
    for (int y = 0; y < col; y++) {
      List<TileInfo> row = [];
      for (int x = 0; x < col; x++) {
        row.add(TileInfo(x, y, "W"));
      }
      grid.add(row);
    }
    notifyListeners();
  }

  updateBoard(int x, int y, TileInfo i) {
    if (grid.length < y && grid[y].length < x) {
      grid[y][x] = i;
    }
    notifyListeners();
  }

  GameBoardData.fromJson(Map<String, dynamic> json)
      : col = json['col'],
        grid = json['grid'];

  Map<String, dynamic> toJson() => {
        'col': col,
        'taskId': taskId,
        'grid': grid.map((l) {
          return l.map((t) {
            return t.toJson();
          }).toList();
        }).toList(),
      };
}

class SelectedColor extends ChangeNotifier {
  String color = "W";
  setColor(String c) {
    color = c;
    notifyListeners();
  }

  Color getColor() {
    switch (color) {
      case "W":
        return Colors.white;
      case "R":
        return Colors.red;
      case "Y":
        return Colors.yellow;
      case "B":
        return Colors.blue;
      default:
        return Colors.white;
    }
  }
}

class GameTypeProvider {
  bool isPersonal = true;
}
