import 'dart:ui';
import 'package:flutter/material.dart';

class DialogPopup {
  final BuildContext context;
  OverlayEntry overlayEntry;
  OverlayState overlayState;

  DialogPopup(this.context);

  void show(String title, String message, Function onOK) {
    overlayState = Overlay.of(context);
    overlayEntry = new OverlayEntry(
        builder: (context) => _build(context, title, message, onOK));
    overlayState.insert(overlayEntry);
  }

  Widget _build(
      BuildContext context, String title, String message, Function onOK) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
            child: Container(
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 250,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Text(message),
                  ),
                  MaterialButton(
                    minWidth: 200,
                    onPressed: () {
                      onOK();
                      dismiss();
                    },
                    color: Colors.cyan,
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dismiss() {
    overlayEntry.remove();
  }
}
