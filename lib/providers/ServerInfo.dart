import 'dart:convert';

import 'package:beats_ft/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ServerInfo extends ChangeNotifier {
  String serverAddress;
  final String _defaultPort = "9999";
  WebSocketChannel channel;
  bool connected = false;

  GameCommad dataFromServer;

  String getServerFullAddress() {
    if (serverAddress != null && !serverAddress.contains(":")) {
      serverAddress += ":$_defaultPort";
    }
    return serverAddress;
  }

  Future<dynamic> startConnect() async {
    channel = IOWebSocketChannel.connect('ws://${getServerFullAddress()}');
    channel.stream.listen((data) => onData(data),
        onError: (e) => onError(e), onDone: () => onDone());
    return await channel.stream.first;
  }

  sendGameData(int command, dynamic data) {
    channel.sink.add(GameCommad(command, data).toJson().toString());
  }

  onData(String data) {
    dataFromServer = null;
    print(data);
    if (data.trim() == "connected") {
      connected = true;
      notifyListeners();
    }
    if (data.startsWith("{code: 3")) {
      dataFromServer = GameCommad.fromJson(json.decode(data));
      print(dataFromServer);
      notifyListeners();
    }
  }

  onError(e) {
    print("WS conenction error $e");
    notifyListeners();
  }

  onDone() {
    connected = false;
    print("WS conenction done");
    notifyListeners();
  }
}

sendToServer(BuildContext context, GameCommad data) {
  ServerInfo server = Provider.of<ServerInfo>(context, listen: false);
  server.channel.sink.add(data.toJson().toString());
}
