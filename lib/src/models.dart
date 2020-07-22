import 'dart:math';

import 'package:flutter/cupertino.dart';

class StudyPlan {
  String subject;
  DateTime examDate;

  StudyPlan({@required this.subject, @required this.examDate});

  Future<bool> save() async {
    // todo: add firebase backend.
    print('saving study plan for $subject on $examDate using a web service');
    return Future.delayed(
        Duration(seconds: 2), () => [true, false][Random().nextInt(2)]);
  }
}

class LearningGoal {
  String name;
  int quantity;
  String quantifier;
  StudyPlan studyPlan;

  LearningGoal({
    @required this.name,
    @required this.quantity,
    @required this.quantifier,
    @required this.studyPlan,
  });

  Future<bool> save() async {
    // todo: add firebase backend.
    print('saving learning goal $name for $studyPlan using a web service');
    return Future.delayed(
        Duration(seconds: 2), () => [true, false][Random().nextInt(2)]);
  }
}
