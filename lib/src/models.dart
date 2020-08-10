import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(nullable: false)
class StudyPlan {
  String subject;
  DateTime examDate;
  List<LearningGoal> learningGoals;

  StudyPlan(
      {@required this.subject,
      @required this.examDate,
      @required this.learningGoals});

  factory StudyPlan.fromJson(Map<String, dynamic> json) =>
      _$StudyPlanFromJson(json);

  Map<String, dynamic> toJson() => _$StudyPlanToJson(this);


  String toString() {
    return '<$subject>';
  }
}

@JsonSerializable(nullable: false)
class LearningGoal {
  String description;
  @JsonKey(fromJson: _intFromString, toJson: _intToString)
  int quantity;
  String quantifier;

  LearningGoal({
    @required this.description,
    @required this.quantity,
    @required this.quantifier,
  });

  static int _intFromString(dynamic value) => int.parse(value as String);
  static String _intToString(dynamic value) => '${value as int}';

  factory LearningGoal.fromJson(Map<String, dynamic> json) =>
      _$LearningGoalFromJson(json);

  Map<String, dynamic> toJson() => _$LearningGoalToJson(this);
}
