import 'package:beats_ft/helper.dart';
import 'package:beats_ft/providers/ServerInfo.dart';
import 'package:beats_ft/screens/games/group_board_tiles.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupGameBoard extends StatefulWidget {
  final bool isPersonal;

  const GroupGameBoard({Key key, this.isPersonal = true}) : super(key: key);

  @override
  _GroupGameBoardState createState() => _GroupGameBoardState();
}

class _GroupGameBoardState extends State<GroupGameBoard> {
  ServerInfo server;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      sendToServer(context, GameCommad(ON_GROUP_BOARD, "-"));
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
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(50),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                          "GROUP Task ke - ${Provider.of<ServerInfo>(context).groupData?.taskID ?? 0}"),
                    ),
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
    showDialog(
      context: context,
      builder: (BuildContext context) => FancyDialog(
        title: "Selamat!",
        descreption: "Semua task sudah selesai anda kerjakan.",
        theme: FancyTheme.FANCY,
        okFun: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
