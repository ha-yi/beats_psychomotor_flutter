import 'dart:async';

import 'package:flutter/material.dart';

final TASKS = [1, 2, 3, 4, 5, 6, 7, 8];

class TaskInfo extends ChangeNotifier {
  int taskId = 0;
  bool finished = false;
  Timer _timer;
  int duration = 120;

  void nextTask() {
    if (!finished) {
      taskId += 1;
    }
    finished = (taskId > 8);
    startTimer();
    notifyListeners();
  }

  reset() {
    taskId = 0;
    finished = false;
  }

  int getCount() {
    int col = 10;
    if (taskId <= 3) {
      col = 10;
    } else if (taskId <= 6) {
      col = 15;
    } else {
      col = 20;
    }
    return col;
  }

  void startTimer() {
    duration = 120;
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (duration <= 0) {
        t.cancel();
      } else {
        duration -= 1;
      }
      notifyListeners();
    });
  }
}
