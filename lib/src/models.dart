import 'package:flutter/cupertino.dart';

class StudyPlan {
  String subject;
  DateTime examDate;

  StudyPlan({@required this.subject, @required this.examDate});

  StudyPlan.empty();

  String toString() {
    return '<$subject>';
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
}
