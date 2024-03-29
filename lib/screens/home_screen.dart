import 'package:beats_ft/providers/UserInfo.dart';
import 'package:beats_ft/screens/choice_screen.dart';
import 'package:beats_ft/screens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool loading = true;
//  UserInfo userInfo;

  @override
  void initState() {
    super.initState();
//    userInfo = Provider.of<UserInfo>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () {
        return Future<bool>(() {
          return false;
        });
      },
      child: Scaffold(
        body: Container(
          child: createUI(),
        ),
      ),
    );
  }

  createUI() {
    return Consumer<UserInfo>(
      builder: (context, user, child) {
        if (user.name == null || user.name.isEmpty) {
          return requestUserInfo();
        } else {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ChoiceScreen()));
          });
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget loadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text("Connecting to server...")
        ],
      ),
    );
  }

  Widget requestUserInfo() {
    return UserInfoWidget(this);
  }

  onUserDataSaved() {
    setState(() {});
  }
}
