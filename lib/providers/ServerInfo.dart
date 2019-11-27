import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ServerInfo extends ChangeNotifier {
  String serverAddress;
  final String _defaultPort = "9999";
  WebSocketChannel channel;
  bool connected = false;

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

  onData(String data) {
    if (data.trim() == "connected") {
      connected = true;
      notifyListeners();
    }
    print("WS data $data");
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
