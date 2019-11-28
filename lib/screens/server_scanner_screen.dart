import 'package:barcode_scan/barcode_scan.dart';
import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class ServerScannerScreen extends StatefulWidget {
  @override
  _ServerScannerScreenState createState() => _ServerScannerScreenState();
}

class _ServerScannerScreenState extends State<ServerScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "BEATS client",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                  "Scan barcode yang ada pada server untuk menginisialisasi koneksi ke server"),
            ),
            MaterialButton(
              onPressed: _scanQR,
              color: Colors.green,
              child: Text(
                "Scan Barcode",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void tryConnectToServer(String ip) {
    ServerInfo data = Provider.of<ServerInfo>(context, listen: true);
    data.serverAddress = ip;
    data.startConnect().then((d) {
      print("listener $d");
      print("is connecter ${data.connected}");
    });
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      if (isIP(qrResult)) {
        tryConnectToServer(qrResult);
      }
    } catch (ex) {
      print(ex);
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
      } else {}
    }
  }
}
