import 'dart:convert';

import 'package:beats_ft/helper.dart';
import 'package:beats_ft/providers/GameBoardData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ServerInfo extends ChangeNotifier {
  String serverAddress;
  final String _defaultPort = "9999";
  WebSocketChannel channel;
  bool connected = false;
  var error;
  bool loading = false;

  GameCommad dataFromServer;
  GroupTestData groupData;

  String getServerFullAddress() {
    print(serverAddress);
    if (serverAddress != null && !serverAddress.contains(":")) {
      serverAddress += ":$_defaultPort";
    }
    return serverAddress;
  }

  startConnect() {
    error = null;
    loading = true;
    channel = IOWebSocketChannel.connect('ws://${getServerFullAddress()}');
    channel.stream.listen((data) => onData(data),
        onError: (e) => onError(e),
        onDone: () => onDone(),
        cancelOnError: true);
    notifyListeners();
  }

  sendGameData(int command, dynamic data) {
    channel.sink.add(GameCommad(command, data).toJson().toString());
  }

  onData(dynamic data) {
    loading = false;
    error = null;
    dataFromServer = null;
    print(data);
    if (data.trim() == "connected") {
      connected = true;
      notifyListeners();
      return;
    }
    dataFromServer = GameCommad.fromJson(json.decode(data));
    print(dataFromServer);

    switch (dataFromServer.code) {
      case START_GROUP_TASK:
        groupData = GroupTestData(dataFromServer.data);
        break;
      case ADD_GROUP_GAME_TILE:
        print("ADD_GROUP_GAME_TILE from server");
        TileInfo i = TileInfo.fromJson(dataFromServer.data);
        groupData.data.addTile(i);
        print(groupData.data.toJson().toString());
        break;
      case ADD_GROUP_GAME_DATA:
        if (groupData != null) {
          groupData.data = GameBoardData.fromJson(dataFromServer.data);
        }
        break;
    }

    notifyListeners();
  }

  onError(e) {
    loading = false;
    print("WS conenction error $e");
    connected = false;
    error = e;
    notifyListeners();
  }

  onDone() {
    loading = false;
    connected = false;
    print("WS conenction done");
    notifyListeners();
  }

  localAddTile(TileInfo i) {
    groupData.data.addTile(i);
    notifyListeners();
    sendGameData(ADD_GROUP_GAME_TILE, i.toJson().toString());
  }
}

sendToServer(BuildContext context, GameCommad data) {
  ServerInfo server = Provider.of<ServerInfo>(context, listen: false);
  server.channel.sink.add(data.toJson().toString());
}

class GroupTestData {
  int taskID = 0;
  GameBoardData data;

  int getCount() {
    int col = 10;
    if (taskID <= 3) {
      col = 10;
    } else if (taskID <= 6) {
      col = 15;
    } else {
      col = 20;
    }
    return col;
  }

  GroupTestData(this.taskID) {
    data = GameBoardData();
    data.setColumn(getCount());
    data.taskId = taskID;
  }
}
