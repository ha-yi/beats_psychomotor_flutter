import 'package:flutter/cupertino.dart';

class UserInfo extends ChangeNotifier {
  String name;
  String email;
  String age;
  String gender;
  onChange() {
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "email": this.email,
      "age": this.age,
      "gender": this.gender,
    };
  }
}
