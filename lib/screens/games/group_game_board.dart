import 'package:beats_ft/helper.dart';
import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/screens/fullscreen_dialog.dart';
import 'package:beats_ft/screens/games/group_board_tiles.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GroupGameBoard extends StatefulWidget {
  final bool isPersonal;

  const GroupGameBoard({Key key, this.isPersonal = true}) : super(key: key);

  @override
  _GroupGameBoardState createState() => _GroupGameBoardState();
}

class _GroupGameBoardState extends State<GroupGameBoard> {
  ServerInfo server;
  DialogPopup popup;

  @override
  void initState() {
    super.initState();
    popup = DialogPopup(context);

    Future.delayed(Duration(milliseconds: 300), () {
      sendToServer(context, GameCommad(ON_GROUP_BOARD, "-"));
      Provider.of<ServerInfo>(context).addListener(listenForServerChange);
    });
  }

  Future<bool> _onBack() {
    return Future(() {
      sendToServer(context, GameCommad(LEAVE_GROUP_BOARD, "-"));
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(50),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "GROUP",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Task ke -",
                    style: TextStyle(
                      color: Colors.blue.withAlpha(200),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${Provider.of<ServerInfo>(context).groupData?.taskID ?? 0}",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          width: 1400,
                          height: 1000,
                          child: Center(child: GroupBoardTiles()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showFinishDialog() {
    sendToServer(context, GameCommad(LEAVE_GROUP_BOARD, "-"));
    popup.show("Selamat!", "Semua task sudah selesai anda kerjakan.", () {
      popup.dismiss();
      Navigator.pop(context);
    });
  }

  void listenForServerChange() {
    if (Provider.of<ServerInfo>(context, listen: false).timeout) {
      popup.show(
          "Waktu Habis!",
          "Waktu pengerjaan task sudah habis. Silahkan tunggu server untuk menjalankan task berikutnya.",
          null);
    } else {
      popup.dismiss();
    }
    if (Provider.of<ServerInfo>(context, listen: false).groupData.taskID > 9) {
      showFinishDialog();
    }
  }
}
