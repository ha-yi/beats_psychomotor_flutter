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
  var error;
  bool loading = false;

  GameCommad dataFromServer;

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

  onData(String data) {
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
}

sendToServer(BuildContext context, GameCommad data) {
  ServerInfo server = Provider.of<ServerInfo>(context, listen: false);
  server.channel.sink.add(data.toJson().toString());
}
