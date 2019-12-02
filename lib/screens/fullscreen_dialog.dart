import 'dart:ui';
import 'package:flutter/material.dart';

class DialogPopup {
  final BuildContext context;
  OverlayEntry overlayEntry;
  OverlayState overlayState;
  bool _isShowing = false;

  DialogPopup(this.context);

  void show(String title, String message, Function onOK, {Function onCancel}) {
    if (_isShowing) return;
    overlayState = Overlay.of(context);
    overlayEntry = new OverlayEntry(
        builder: (context) => _build(context, title, message, onOK, onCancel));
    overlayState.insert(overlayEntry);
    _isShowing = true;
  }

  Widget _build(BuildContext context, String title, String message,
      Function onOK, Function onCancel) {
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
                  (onOK != null)
                      ? MaterialButton(
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
                        )
                      : Container(),
                  (onCancel != null)
                      ? MaterialButton(
                          minWidth: 200,
                          onPressed: () {
                            onCancel();
                            dismiss();
                          },
                          color: Colors.deepOrange,
                          child: Text(
                            "Batal",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dismiss() {
    _isShowing = false;
    if (overlayEntry != null) overlayEntry.remove();
  }
}
