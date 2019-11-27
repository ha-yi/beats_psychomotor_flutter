import 'package:beats_ft/providers/UserInfo.dart';
import 'package:beats_ft/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatefulWidget {
  final HomeScreenState parentState;

  UserInfoWidget(this.parentState);

  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  String name;
  String email;
  String age;
  String gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
            child: Column(
              children: <Widget>[
                Text(
                  "Selamat Datang di BEATS Psychomotor test",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "John Doe",
                    labelText: "Nama Anda",
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  onChanged: (data) {
                    name = data;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "john.doe@gmail.com",
                    labelText: "Alamat Email",
                    border: UnderlineInputBorder(),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (data) {
                    email = data;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "20",
                    labelText: "Usia Anda",
                    border: UnderlineInputBorder(),
                  ),
                  maxLines: 1,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  onChanged: (data) {
                    age = data;
                  },
                ),
                Text("Jenis Kelamin"),
                RadioButtonGroup(
                  labels: <String>[
                    "Laki-laki",
                    "Perempuan",
                  ],
                  onSelected: (String selected) {
                    gender = selected;
                  },
                ),
                MaterialButton(
                  minWidth: 250,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "SIMPAN",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                  onPressed: saveAction,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveAction() {
    if (name == null || name.isEmpty) {
      showErrorSnack("Nama tidak boleh kosong");
      return;
    }

    if (email == null || email.isEmpty) {
      showErrorSnack("Email tidak boleh kosong");
      return;
    }
    if (age == null || age.isEmpty) {
      showErrorSnack("Usia tidak boleh kosong");
      return;
    }

    if (gender == null || gender.isEmpty) {
      showErrorSnack("Pilih jenis kelamin terlebih dahulu tidak boleh kosong");
      return;
    }

    processSaveData();
  }

  void showErrorSnack(String s) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(s),
      backgroundColor: Colors.deepOrange,
    ));
  }

  void processSaveData() {
    var data = Provider.of<UserInfo>(context, listen: false);
    data.age = age;
    data.gender = gender;
    data.email = email;
    data.name = name;
    widget.parentState.onUserDataSaved();
    dispose();
  }
}
