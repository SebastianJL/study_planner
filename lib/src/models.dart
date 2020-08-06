import 'package:flutter/cupertino.dart';

class StudyPlan {
  String subject;
  DateTime examDate;

  StudyPlan({@required this.subject, @required this.examDate});

  StudyPlan.empty();

  StudyPlan.fromJson(Map<String, dynamic> json)
      : subject = json['subject'],
        examDate = json['examDate'];

  Map<String, dynamic> toJson() => {
        'subject': subject,
        'examDate': examDate,
      };

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
